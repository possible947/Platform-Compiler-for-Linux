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
    ParseStatus,
    ParsedArtifact,
    ParserOutput,
    ReferenceArtifact,
    ReferenceIndex,
    ReferencePlatformId,
    ReferencePlatformModel,
    UnclassifiedReferenceFile,
)
from platform_compiler.reference.source import ArtifactParser, LocalReferenceRoot

INDEX_VERSION = 1
PARSER_VERSION = "1"
DARWINDUMPED_REPOSITORY = "possible947/DarwinDumped"

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

_MISSING = tuple(ArtifactClass)


def _category_for(relative_path: Path) -> tuple[ArtifactClass, str | None]:
    for part in relative_path.parts[2:-1]:
        normalized = re.sub(r"\s+", " ", part.strip().lower())
        artifact_class = _CATEGORY_MAP.get(normalized)
        if artifact_class is not None:
            return artifact_class, part
    return ArtifactClass.OTHER, None


def _platform_name(family: str, folder: str) -> tuple[str, str]:
    suffix = re.fullmatch(r"(.+?)\s*\((.+)\)", folder)
    if suffix:
        return suffix.group(1).strip(), suffix.group(2).strip()
    return folder, "default"


def _revision(root: Path) -> str | None:
    if not (root / ".git").exists():
        return None
    try:
        result = subprocess.run(
            ["git", "-C", str(root), "rev-parse", "HEAD"],
            check=True,
            capture_output=True,
            text=True,
            timeout=3,
        )
    except (OSError, subprocess.SubprocessError):
        return None
    return result.stdout.strip() or None


def _file_digest(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as artifact_file:
        for chunk in iter(lambda: artifact_file.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


class DarwinDumpedIndexer:
    """Deterministic local filesystem indexer for DarwinDumped's family/model tree."""

    def __init__(
        self,
        local_path: Path,
        *,
        cache_path: Path | None = None,
        repository: str = DARWINDUMPED_REPOSITORY,
    ) -> None:
        self.root = LocalReferenceRoot(local_path)
        self.cache_path = cache_path.resolve() if cache_path else None
        if (
            self.cache_path is not None
            and self.cache_path.is_relative_to(self.root.path)
        ):
            raise ValueError(
                "reference index cache must be outside the source checkout"
            )
        self.repository = repository
        self._loaded_cache_stats: dict[str, list[int | bool]] = {}

    def build(self) -> ReferenceIndex:
        self._loaded_cache_stats = {}
        revision = _revision(self.root.path)
        files_by_model, unclassified_paths = self._discover_files()
        cached = self._load_cache()
        cached_files = self._cached_file_map(cached)
        platforms: list[ReferencePlatformModel] = []

        for identity, files in sorted(
            files_by_model.items(), key=lambda item: item[0].source_path
        ):
            artifacts: list[ReferenceArtifact] = []
            for path in sorted(files, key=lambda candidate: candidate.as_posix()):
                relative = path.relative_to(self.root.path).as_posix()
                stat = path.lstat()
                symlink = path.is_symlink()
                size = (
                    len(os.readlink(path).encode("utf-8"))
                    if symlink
                    else stat.st_size
                )
                digest = self._digest(
                    path, symlink, cached_files, relative, size, stat.st_mtime_ns
                )
                relative_path = Path(relative)
                artifact_class, source_category = _category_for(relative_path)
                artifacts.append(
                    ReferenceArtifact(
                        artifact_class=artifact_class,
                        source_category=source_category,
                        relative_path=relative,
                        size_bytes=size,
                        content_sha256=digest,
                        is_symlink=symlink,
                        provenance=ArtifactProvenance(
                            repository=self.repository,
                            revision=revision,
                            platform=identity,
                            relative_path=relative,
                            content_sha256=digest,
                        ),
                    )
                )
            available = tuple(
                sorted({item.artifact_class for item in artifacts}, key=str)
            )
            platforms.append(
                ReferencePlatformModel(
                    identity=identity,
                    available_artifact_classes=available,
                    missing_artifact_classes=tuple(
                        item for item in _MISSING if item not in available
                    ),
                    source_paths=tuple(item.relative_path for item in artifacts),
                    artifacts=tuple(artifacts),
                )
            )

        unclassified = tuple(
            self._unclassified_file(path, revision, cached_files)
            for path in sorted(unclassified_paths, key=lambda item: item.as_posix())
        )
        index = ReferenceIndex(
            index_version=INDEX_VERSION,
            parser_version=PARSER_VERSION,
            repository=self.repository,
            source_revision=revision,
            platforms=tuple(platforms),
            unclassified_files=unclassified,
        )
        self._save_cache(index)
        return index

    def _discover_files(
        self,
    ) -> tuple[dict[ReferencePlatformId, list[Path]], list[Path]]:
        files_by_model: dict[ReferencePlatformId, list[Path]] = {}
        root = self.root.path
        for family_dir in sorted(root.iterdir(), key=lambda item: item.name):
            if not family_dir.is_dir() or family_dir.name.startswith("."):
                continue
            for model_dir in sorted(family_dir.iterdir(), key=lambda item: item.name):
                if not model_dir.is_dir() or model_dir.name.startswith("."):
                    continue
                model_identifier, sample_identifier = _platform_name(
                    family_dir.name, model_dir.name
                )
                identity = ReferencePlatformId(
                    vendor="Apple",
                    product_family=family_dir.name,
                    model_identifier=model_identifier,
                    sample_identifier=sample_identifier,
                    source_path=model_dir.relative_to(root).as_posix(),
                )
                files: list[Path] = []
                for path in sorted(
                    model_dir.rglob("*"), key=lambda item: item.as_posix()
                ):
                    relative_parts = path.relative_to(root).parts
                    if ".git" in relative_parts:
                        continue
                    if self.cache_path == path.resolve():
                        continue
                    if path.is_file() or path.is_symlink():
                        files.append(path)
                files_by_model[identity] = files
        assigned = {
            path.relative_to(root).as_posix()
            for model_files in files_by_model.values()
            for path in model_files
        }
        unclassified: list[Path] = []
        for directory, directories, filenames in os.walk(
            root, topdown=True, followlinks=False
        ):
            current = Path(directory)
            directories[:] = [name for name in directories if name != ".git"]
            filenames[:] = [name for name in filenames if name != ".git"]
            for name in tuple(directories):
                path = current / name
                if path.is_symlink():
                    directories.remove(name)
                    filenames.append(name)
            for name in filenames:
                path = current / name
                if (
                    (path.is_file() or path.is_symlink())
                    and path.relative_to(root).as_posix() not in assigned
                    and self.cache_path != path.resolve()
                ):
                    unclassified.append(path)
        return files_by_model, unclassified

    @staticmethod
    def _cached_file_map(index: ReferenceIndex | None) -> dict[str, str]:
        if index is None:
            return {}
        cached = {
            artifact.relative_path: artifact.content_sha256
            for platform in index.platforms
            for artifact in platform.artifacts
        }
        cached.update(
            (item.relative_path, item.content_sha256)
            for item in index.unclassified_files
        )
        return cached

    def _digest(
        self,
        path: Path,
        symlink: bool,
        cached: dict[str, str],
        relative: str,
        size: int,
        mtime_ns: int,
    ) -> str:
        previous = cached.get(relative)
        previous_stat = self._loaded_cache_stats.get(relative)
        if previous is not None and previous_stat == [size, mtime_ns, symlink]:
            return previous
        if symlink:
            return hashlib.sha256(os.readlink(path).encode("utf-8")).hexdigest()
        return _file_digest(path)

    def _load_cache(self) -> ReferenceIndex | None:
        if self.cache_path is None or not self.cache_path.is_file():
            return None
        try:
            payload = json.loads(self.cache_path.read_text(encoding="utf-8"))
            index_data = payload["index"]
            if (
                payload["index_version"] != INDEX_VERSION
                or payload["parser_version"] != PARSER_VERSION
                or payload["repository"] != self.repository
                or payload["source_root"] != str(self.root.path)
            ):
                return None
            file_stats = payload.get("file_stats")
            if not isinstance(file_stats, dict):
                return None
            index = ReferenceIndex.model_validate(index_data)
            self._loaded_cache_stats = file_stats
            return index
        except (OSError, ValueError, KeyError, TypeError):
            return None

    def _save_cache(self, index: ReferenceIndex) -> None:
        if self.cache_path is None:
            return
        stats: dict[str, list[int | bool]] = {}
        indexed_files = [
            artifact
            for platform in index.platforms
            for artifact in platform.artifacts
        ]
        indexed_files.extend(index.unclassified_files)
        for artifact in indexed_files:
            path = self.root.path / artifact.relative_path
            stat = path.lstat()
            stats[artifact.relative_path] = [
                artifact.size_bytes,
                stat.st_mtime_ns,
                artifact.is_symlink,
            ]
        self.cache_path.parent.mkdir(parents=True, exist_ok=True)
        payload = {
            "index_version": INDEX_VERSION,
            "parser_version": PARSER_VERSION,
            "repository": self.repository,
            "source_root": str(self.root.path),
            "source_revision": index.source_revision,
            "file_stats": stats,
            "index": json.loads(index.model_dump_json()),
        }
        self.cache_path.write_text(
            json.dumps(payload, sort_keys=True, indent=2) + "\n",
            encoding="utf-8",
        )

    def _unclassified_file(
        self,
        path: Path,
        revision: str | None,
        cached: dict[str, str],
    ) -> UnclassifiedReferenceFile:
        relative = path.relative_to(self.root.path).as_posix()
        stat = path.lstat()
        symlink = path.is_symlink()
        size = len(os.readlink(path).encode("utf-8")) if symlink else stat.st_size
        return UnclassifiedReferenceFile(
            repository=self.repository,
            revision=revision,
            relative_path=relative,
            size_bytes=size,
            content_sha256=self._digest(
                path,
                symlink,
                cached,
                relative,
                size,
                stat.st_mtime_ns,
            ),
            is_symlink=symlink,
        )


def parse_artifact(
    raw_content: bytes,
    artifact: ReferenceArtifact,
    parser: ArtifactParser | None = None,
) -> ParsedArtifact:
    """Parse one artifact without allowing its failure to discard its platform."""
    provenance = artifact.provenance
    raw_sha256 = hashlib.sha256(raw_content).hexdigest()
    if raw_sha256 != artifact.content_sha256:
        return ParsedArtifact(
            raw_sha256=raw_sha256,
            normalized_facts={"parse_error": "raw content digest does not match index"},
            provenance=provenance.model_copy(
                update={
                    "parser": parser.name if parser is not None else "raw-digest-check",
                    "parser_version": parser.version if parser is not None else "1",
                    "parse_status": ParseStatus.FAILED,
                }
            ),
        )
    if parser is None:
        return ParsedArtifact(raw_sha256=raw_sha256, provenance=provenance)
    try:
        result = ParserOutput.model_validate(parser.parse(raw_content))
    except Exception as error:
        return ParsedArtifact(
            raw_sha256=raw_sha256,
            provenance=provenance.model_copy(
                update={
                    "parser": parser.name,
                    "parser_version": parser.version,
                    "parse_status": ParseStatus.FAILED,
                }
            ),
        ).model_copy(update={"normalized_facts": {"parse_error": str(error)}})
    return ParsedArtifact(
        raw_sha256=raw_sha256,
        parsed_value=result.parsed_value,
        normalized_facts=result.normalized_facts,
        provenance=provenance.model_copy(
            update={
                "parser": parser.name,
                "parser_version": parser.version,
                "parse_status": result.status,
            }
        ),
    )
