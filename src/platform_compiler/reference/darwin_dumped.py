from __future__ import annotations

from collections.abc import Sequence
from pathlib import Path

from platform_compiler.reference.indexer import (
    DARWINDUMPED_REPOSITORY,
    DarwinDumpedIndexer,
)
from platform_compiler.reference.models import (
    ArtifactClass,
    ReferenceArtifact,
    ReferenceIndex,
    ReferencePlatformId,
    ReferencePlatformModel,
)
from platform_compiler.reference.source import LocalReferenceRoot


class DarwinDumpedSource:
    """Read-only adapter over a local DarwinDumped checkout."""

    def __init__(
        self,
        local_path: Path,
        *,
        cache_path: Path | None = None,
    ) -> None:
        self.root = LocalReferenceRoot(local_path)
        self.indexer = DarwinDumpedIndexer(
            self.root.path,
            cache_path=cache_path,
            repository=DARWINDUMPED_REPOSITORY,
        )
        self._index: ReferenceIndex | None = None

    def refresh_index(self) -> ReferenceIndex:
        self._index = self.indexer.build()
        return self._index

    def _get_index(self) -> ReferenceIndex:
        if self._index is None:
            self._index = self.indexer.build()
        return self._index

    def list_platforms(self) -> tuple[ReferencePlatformModel, ...]:
        return self._get_index().platforms

    def get_artifacts(
        self,
        platform: ReferencePlatformId,
        artifact_classes: Sequence[ArtifactClass],
    ) -> tuple[ReferenceArtifact, ...]:
        model = next(
            (item for item in self.list_platforms() if item.identity == platform),
            None,
        )
        if model is None:
            return ()
        selected = set(artifact_classes)
        return tuple(
            artifact
            for artifact in model.artifacts
            if artifact.artifact_class in selected
        )

    def read_artifact(self, artifact: ReferenceArtifact) -> bytes:
        return self.root.read(artifact.relative_path)

    def read_excerpt(
        self,
        artifact: ReferenceArtifact,
        max_bytes: int,
    ) -> tuple[bytes, bool]:
        return self.root.read_excerpt(
            artifact.relative_path,
            max_bytes,
            artifact.content_sha256,
        )
