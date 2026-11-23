from __future__ import annotations

import hashlib
from collections.abc import Sequence
from pathlib import Path
from typing import Protocol

from platform_compiler.reference.models import (
    ArtifactClass,
    ReferenceArtifact,
    ReferencePlatformId,
    ReferencePlatformModel,
    ParserOutput,
)


class ReferenceSource(Protocol):
    """Local reference corpus interface; implementations must not require network."""

    def list_platforms(self) -> tuple[ReferencePlatformModel, ...]:
        ...

    def get_artifacts(
        self,
        platform: ReferencePlatformId,
        artifact_classes: Sequence[ArtifactClass],
    ) -> tuple[ReferenceArtifact, ...]:
        ...

    def read_artifact(self, artifact: ReferenceArtifact) -> bytes:
        ...

    def read_excerpt(
        self,
        artifact: ReferenceArtifact,
        max_bytes: int,
    ) -> tuple[bytes, bool]:
        ...


class ArtifactParser(Protocol):
    name: str
    version: str

    def parse(self, raw_content: bytes) -> ParserOutput:
        """Return a parsed representation, normalized facts, and parse status."""
        ...


class LocalReferenceRoot:
    """Resolve source-relative paths without allowing traversal or symlink reads."""

    def __init__(self, path: Path) -> None:
        self.path = path.resolve()
        if not self.path.is_dir():
            raise ValueError(f"reference repository is not a directory: {path}")

    def read(self, relative_path: str) -> bytes:
        candidate = self._resolve(relative_path)
        return candidate.read_bytes()

    def read_excerpt(
        self,
        relative_path: str,
        max_bytes: int,
        expected_sha256: str,
    ) -> tuple[bytes, bool]:
        if max_bytes < 1:
            raise ValueError("excerpt limit must be positive")
        candidate = self._resolve(relative_path)
        digest = hashlib.sha256()
        excerpt = bytearray()
        with candidate.open("rb") as artifact_file:
            while chunk := artifact_file.read(64 * 1024):
                digest.update(chunk)
                if len(excerpt) <= max_bytes:
                    excerpt.extend(chunk[: max_bytes + 1 - len(excerpt)])
        if digest.hexdigest() != expected_sha256:
            raise ValueError(f"reference artifact changed since indexing: {relative_path}")
        return bytes(excerpt[:max_bytes]), len(excerpt) > max_bytes

    def _resolve(self, relative_path: str) -> Path:
        candidate = self.path / relative_path
        if candidate.is_symlink():
            raise ValueError(
                f"reference artifact must not be a symlink: {relative_path}"
            )
        resolved = candidate.resolve()
        if not resolved.is_relative_to(self.path):
            raise ValueError(
                f"reference artifact path escapes repository: {relative_path}"
            )
        return resolved
