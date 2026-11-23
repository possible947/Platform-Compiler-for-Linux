from __future__ import annotations

import hashlib
import json
import os
import re
import subprocess
from pathlib import Path

from platform_compiler.reference.models import (
    ArtifactClass,
    ArtifactProvenance,
    ReferenceArtifact,
)

DARWINDUMPED_REPOSITORY = "possible947/DarwinDumped"
_INDEX_VERSION = 2
_CATEGORY_MAP: dict[str, ArtifactClass] = {
    "acpi tables": ArtifactClass.ACPI,
    "acpi": ArtifactClass.ACPI,
    "dmi tables": ArtifactClass.DMI,
    "dmi": ArtifactClass.DMI,
    "lspci": ArtifactClass.PCI,
    "pci": ArtifactClass.PCI,
    "ioregistry": ArtifactClass.IOREGISTRY,
    "cpu": ArtifactClass.CPU,
    "memory": ArtifactClass.MEMORY,
    "device properties": ArtifactClass.DEVICE_PROPERTIES,
    "power": ArtifactClass.POWER,
    "rtc": ArtifactClass.RTC,
    "nvram": ArtifactClass.NVRAM,
    "smc": ArtifactClass.SMC,
    "kernel info": ArtifactClass.KERNEL,
    "bootlog_kernel": ArtifactClass.KERNEL,
    "boot loaders": ArtifactClass.BOOT,
    "system profiler": ArtifactClass.SYSTEM_PROFILER,
}


def _revision(root: Path) -> str:
    if not (root / ".git").exists():
        return "working-tree"
    try:
        result = subprocess.run(
            ["git", "-C", str(root), "rev-parse", "HEAD"],
            check=True,
            capture_output=True,
            text=True,
            timeout=3,
        )
    except (OSError, subprocess.SubprocessError) as error:
        raise ValueError(f"unable to determine immutable source revision: {root}") from error
    revision = result.stdout.strip()
    if not revision:
        raise ValueError(f"unable to determine immutable source revision: {root}")
    return revision


def _file_digest(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as artifact_file:
        for chunk in iter(lambda: artifact_file.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _category_for(relative_path: Path) -> ArtifactClass:
    for part in relative_path.parts[2:-1]:
        normalized = re.sub(r"\s+", " ", part.strip().lower())
        artifact_class = _CATEGORY_MAP.get(normalized)
        if artifact_class is not None:
            return artifact_class
    return ArtifactClass.OTHER


class _DarwinDumpedIndexer:
    """Private translation of DarwinDumped's directory layout into artifacts."""

    def __init__(
        self,
        local_path: Path,
        *,
        cache_path: Path | None = None,
    ) -> None:
        self.root = local_path.resolve()
        if not self.root.is_dir():
            raise ValueError(f"reference repository is not a directory: {local_path}")
        self.cache_path = cache_path.resolve() if cache_path else None
        if self.cache_path is not None and self.cache_path.is_relative_to(self.root):
            raise ValueError("reference index cache must be outside the source checkout")
        self._loaded_cache_stats: dict[str, list[int]] = {}

    def build(self) -> tuple[str, tuple[tuple[ReferenceArtifact, str], ...]]:
        revision = _revision(self.root)
        cached_hashes = self._load_cache(revision)
        artifacts: list[tuple[ReferenceArtifact, str]] = []
        stats: dict[str, list[int]] = {}
        reference_families: dict[str, str] = {}
        for family_dir in sorted(self.root.iterdir(), key=lambda item: item.name):
            if not family_dir.is_dir() or family_dir.name.startswith("."):
                continue
            for model_dir in sorted(family_dir.iterdir(), key=lambda item: item.name):
                if not model_dir.is_dir() or model_dir.name.startswith("."):
                    continue
                reference_id = model_dir.name
                previous_family = reference_families.setdefault(
                    reference_id, family_dir.name
                )
                if previous_family != family_dir.name:
                    raise ValueError(
                        f"ambiguous explicit reference identifier: {reference_id}"
                    )
                for path in sorted(model_dir.rglob("*"), key=lambda item: item.as_posix()):
                    relative_parts = path.relative_to(self.root).parts
                    if ".git" in relative_parts or path.is_symlink() or not path.is_file():
                        continue
                    relative = path.relative_to(self.root).as_posix()
                    stat = path.stat()
                    size = stat.st_size
                    previous_stats = self._loaded_cache_stats.get(relative)
                    if (
                        previous_stats == [size, stat.st_mtime_ns]
                        and relative in cached_hashes
                    ):
                        digest = cached_hashes[relative]
                    else:
                        digest = _file_digest(path)
                    stats[relative] = [size, stat.st_mtime_ns]
                    artifact = ReferenceArtifact(
                        artifact_id=hashlib.sha256(relative.encode("utf-8")).hexdigest(),
                        artifact_class=_category_for(Path(relative)),
                        size_bytes=size,
                        content_sha256=digest,
                        provenance=ArtifactProvenance(
                            source=DARWINDUMPED_REPOSITORY,
                            revision=revision,
                            reference_id=reference_id,
                            content_sha256=digest,
                        ),
                    )
                    artifacts.append(
                        (
                            artifact,
                            relative,
                        )
                    )
        self._save_cache(revision, artifacts, stats)
        return revision, tuple(artifacts)

    def _load_cache(self, revision: str) -> dict[str, str]:
        self._loaded_cache_stats = {}
        if self.cache_path is None or not self.cache_path.is_file():
            return {}
        try:
            payload = json.loads(self.cache_path.read_text(encoding="utf-8"))
            if (
                payload["index_version"] != _INDEX_VERSION
                or payload["source"] != DARWINDUMPED_REPOSITORY
                or payload["source_root"] != str(self.root)
                or payload["revision"] != revision
            ):
                return {}
            stats = payload["file_stats"]
            hashes = payload["hashes"]
            if not isinstance(stats, dict) or not isinstance(hashes, dict):
                return {}
            self._loaded_cache_stats = stats
            return hashes
        except (OSError, ValueError, KeyError, TypeError):
            return {}

    def _save_cache(
        self,
        revision: str,
        artifacts: list[tuple[ReferenceArtifact, str]],
        stats: dict[str, list[int]],
    ) -> None:
        if self.cache_path is None:
            return
        self.cache_path.parent.mkdir(parents=True, exist_ok=True)
        payload = {
            "index_version": _INDEX_VERSION,
            "source": DARWINDUMPED_REPOSITORY,
            "source_root": str(self.root),
            "revision": revision,
            "file_stats": stats,
            "hashes": {
                relative_path: artifact.content_sha256
                for artifact, relative_path in artifacts
            },
        }
        self.cache_path.write_text(
            json.dumps(payload, sort_keys=True, indent=2) + "\n",
            encoding="utf-8",
        )
