from __future__ import annotations

import hashlib
import json
import os
import tempfile
from collections.abc import Sequence
from pathlib import Path
from typing import Protocol

from platform_compiler.reference.models import (
    ArtifactClass,
    ReferenceArtifact,
    ReferenceSnapshot,
)


class ReferenceSource(Protocol):
    """Data-access contract for explicitly requested immutable references."""

    def get_artifacts(
        self,
        reference_id: str,
        artifact_classes: Sequence[ArtifactClass] | None = None,
    ) -> tuple[ReferenceArtifact, ...]:
        ...

    def read_excerpt(
        self,
        artifact: ReferenceArtifact,
        max_bytes: int,
    ) -> tuple[bytes, bool]:
        ...

    def materialize_snapshot(
        self,
        reference_id: str,
        snapshot_root: Path,
        artifact_classes: Sequence[ArtifactClass] | None = None,
        *,
        max_artifacts: int = 8,
        max_bytes_per_artifact: int = 16_384,
    ) -> ReferenceSnapshot:
        ...


class LocalReferenceSource:
    """Hash-verified access and bounded snapshot materialization for local files."""

    def __init__(
        self,
        root: Path,
        source: str,
        revision: str,
        artifacts: Sequence[tuple[ReferenceArtifact, str]],
    ) -> None:
        self.root = root.resolve()
        if not self.root.is_dir():
            raise ValueError(f"reference repository is not a directory: {root}")
        self.source = source
        self.revision = revision
        self._artifacts: dict[str, tuple[tuple[ReferenceArtifact, str], ...]] = {}
        grouped: dict[str, list[tuple[ReferenceArtifact, str]]] = {}
        for artifact, relative_path in artifacts:
            provenance = artifact.provenance
            if provenance.source != source or provenance.revision != revision:
                raise ValueError("artifact provenance does not match local source")
            source_path = Path(relative_path)
            if (
                source_path.is_absolute()
                or not source_path.parts
                or ".." in source_path.parts
            ):
                raise ValueError(
                    f"reference artifact path must be source-relative: {relative_path}"
                )
            grouped.setdefault(provenance.reference_id, []).append(
                (artifact, relative_path)
            )
        self._artifacts = {
            reference_id: tuple(sorted(items, key=lambda item: item[1]))
            for reference_id, items in grouped.items()
        }

    def get_artifacts(
        self,
        reference_id: str,
        artifact_classes: Sequence[ArtifactClass] | None = None,
    ) -> tuple[ReferenceArtifact, ...]:
        self._validate_reference_id(reference_id)
        if reference_id not in self._artifacts:
            raise ValueError(f"reference is not available: {reference_id}")
        artifacts = self._artifacts[reference_id]
        if artifact_classes is None:
            return tuple(artifact for artifact, _ in artifacts)
        selected = set(artifact_classes)
        return tuple(
            artifact
            for artifact, _ in artifacts
            if artifact.artifact_class in selected
        )

    def _read_artifact(
        self,
        artifact: ReferenceArtifact,
        max_bytes: int,
    ) -> bytes:
        relative_path = self._validate_artifact(artifact)
        path = self._resolve(relative_path)
        with path.open("rb") as artifact_file:
            content = artifact_file.read(max_bytes + 1)
        if len(content) > max_bytes:
            raise ValueError(
                f"reference artifact exceeds retrieval limit: {artifact.artifact_id}"
            )
        if hashlib.sha256(content).hexdigest() != artifact.content_sha256:
            raise ValueError(
                f"reference artifact changed since indexing: {artifact.artifact_id}"
            )
        return content

    def read_excerpt(
        self,
        artifact: ReferenceArtifact,
        max_bytes: int,
    ) -> tuple[bytes, bool]:
        if max_bytes < 1:
            raise ValueError("excerpt limit must be positive")
        relative_path = self._validate_artifact(artifact)
        path = self._resolve(relative_path)
        digest = hashlib.sha256()
        excerpt = bytearray()
        with path.open("rb") as artifact_file:
            while chunk := artifact_file.read(64 * 1024):
                digest.update(chunk)
                if len(excerpt) <= max_bytes:
                    excerpt.extend(chunk[: max_bytes + 1 - len(excerpt)])
        if digest.hexdigest() != artifact.content_sha256:
            raise ValueError(
                f"reference artifact changed since indexing: {artifact.artifact_id}"
            )
        return bytes(excerpt[:max_bytes]), len(excerpt) > max_bytes

    def materialize_snapshot(
        self,
        reference_id: str,
        snapshot_root: Path,
        artifact_classes: Sequence[ArtifactClass] | None = None,
        *,
        max_artifacts: int = 8,
        max_bytes_per_artifact: int = 16_384,
    ) -> ReferenceSnapshot:
        if max_artifacts < 0:
            raise ValueError("max_artifacts must not be negative")
        if max_bytes_per_artifact < 1:
            raise ValueError("max_bytes_per_artifact must be positive")
        destination = snapshot_root.resolve()
        if destination.is_relative_to(self.root):
            raise ValueError("reference snapshots must be outside the source checkout")

        available = self.get_artifacts(reference_id, artifact_classes)
        bounded = available[:max_artifacts]
        included = tuple(
            item for item in bounded if item.size_bytes <= max_bytes_per_artifact
        )
        omitted = len(available) - len(included)
        manifest = {
            "reference_id": reference_id,
            "source": self.source,
            "revision": self.revision,
            "omitted_artifact_count": omitted,
            "artifacts": [
                {
                    "artifact_id": item.artifact_id,
                    "artifact_class": item.artifact_class.value,
                    "size_bytes": item.size_bytes,
                    "content_sha256": item.content_sha256,
                }
                for item in included
            ],
        }
        manifest_digest = hashlib.sha256(
            json.dumps(manifest, sort_keys=True).encode("utf-8")
        ).hexdigest()
        snapshot_path = (
            destination
            / "references"
            / self._safe_component(reference_id)
            / hashlib.sha256(self.revision.encode("utf-8")).hexdigest()
            / manifest_digest
        )
        if snapshot_path.exists():
            return self._reuse_snapshot(snapshot_path, manifest, included, omitted)

        snapshot_path.parent.mkdir(parents=True, exist_ok=True)
        with tempfile.TemporaryDirectory(dir=snapshot_path.parent) as temporary:
            staging = Path(temporary) / "snapshot"
            staging.mkdir()
            for artifact in included:
                content = self._read_artifact(artifact, max_bytes_per_artifact)
                target = staging / "artifacts" / artifact.artifact_id
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(content)
            (staging / "manifest.json").write_text(
                json.dumps(manifest, sort_keys=True, indent=2) + "\n",
                encoding="utf-8",
            )
            try:
                os.replace(staging, snapshot_path)
            except OSError:
                if not snapshot_path.exists():
                    raise
                return self._reuse_snapshot(snapshot_path, manifest, included, omitted)
        return ReferenceSnapshot(
            reference_id=reference_id,
            source=self.source,
            revision=self.revision,
            path=snapshot_path,
            artifacts=included,
            omitted_artifact_count=omitted,
        )

    def _reuse_snapshot(
        self,
        snapshot_path: Path,
        manifest: dict[str, object],
        artifacts: tuple[ReferenceArtifact, ...],
        omitted: int,
    ) -> ReferenceSnapshot:
        try:
            existing = json.loads(
                (snapshot_path / "manifest.json").read_text(encoding="utf-8")
            )
        except (OSError, ValueError) as error:
            raise ValueError(
                f"existing reference snapshot is invalid: {snapshot_path}"
            ) from error
        if existing != manifest:
            raise ValueError(f"reference snapshot is immutable: {snapshot_path}")
        for artifact in artifacts:
            path = snapshot_path / "artifacts" / artifact.artifact_id
            if (
                path.is_symlink()
                or not path.is_file()
                or hashlib.sha256(path.read_bytes()).hexdigest()
                != artifact.content_sha256
            ):
                raise ValueError(f"materialized reference artifact is corrupt: {path}")
        return ReferenceSnapshot(
            reference_id=manifest["reference_id"],
            source=manifest["source"],
            revision=manifest["revision"],
            path=snapshot_path,
            artifacts=artifacts,
            omitted_artifact_count=omitted,
        )

    def _validate_artifact(self, artifact: ReferenceArtifact) -> str:
        for indexed_artifact, relative_path in self._artifacts.get(
            artifact.provenance.reference_id, ()
        ):
            if artifact == indexed_artifact:
                return relative_path
        raise ValueError("reference artifact does not belong to this source")

    def _resolve(self, relative_path: str) -> Path:
        candidate = self.root / relative_path
        if candidate.is_symlink():
            raise ValueError(
                f"reference artifact must not be a symlink: {relative_path}"
            )
        resolved = candidate.resolve()
        if not resolved.is_relative_to(self.root):
            raise ValueError(
                f"reference artifact path escapes repository: {relative_path}"
            )
        return resolved

    @staticmethod
    def _validate_reference_id(reference_id: str) -> None:
        if not reference_id or not reference_id.strip():
            raise ValueError(f"invalid reference identifier: {reference_id!r}")

    @staticmethod
    def _safe_component(value: str) -> str:
        LocalReferenceSource._validate_reference_id(value)
        return hashlib.sha256(value.encode("utf-8")).hexdigest()
