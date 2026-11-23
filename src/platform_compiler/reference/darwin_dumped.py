from __future__ import annotations

from collections.abc import Sequence
from pathlib import Path

from platform_compiler.reference.indexer import (
    DARWINDUMPED_REPOSITORY,
    _DarwinDumpedIndexer,
    _revision,
)
from platform_compiler.reference.models import (
    ArtifactClass,
    ReferenceArtifact,
    ReferenceSnapshot,
)
from platform_compiler.reference.source import LocalReferenceSource


class DarwinDumpedSource:
    """Local adapter; DarwinDumped repository paths remain private to this class."""

    def __init__(
        self,
        local_path: Path,
        *,
        cache_path: Path | None = None,
    ) -> None:
        self._root = local_path.resolve()
        self._indexer = _DarwinDumpedIndexer(self._root, cache_path=cache_path)
        self._source: LocalReferenceSource
        self.refresh_index()

    def refresh_index(self) -> None:
        revision, artifacts = self._indexer.build()
        self._source = LocalReferenceSource(
            self._root,
            DARWINDUMPED_REPOSITORY,
            revision,
            artifacts,
        )

    def get_artifacts(
        self,
        reference_id: str,
        artifact_classes: Sequence[ArtifactClass] | None = None,
    ) -> tuple[ReferenceArtifact, ...]:
        return self._get_source().get_artifacts(reference_id, artifact_classes)

    def read_excerpt(
        self,
        artifact: ReferenceArtifact,
        max_bytes: int,
    ) -> tuple[bytes, bool]:
        return self._get_source().read_excerpt(artifact, max_bytes)

    def materialize_snapshot(
        self,
        reference_id: str,
        snapshot_root: Path,
        artifact_classes: Sequence[ArtifactClass] | None = None,
        *,
        max_artifacts: int = 8,
        max_bytes_per_artifact: int = 16_384,
    ) -> ReferenceSnapshot:
        return self._get_source().materialize_snapshot(
            reference_id,
            snapshot_root,
            artifact_classes,
            max_artifacts=max_artifacts,
            max_bytes_per_artifact=max_bytes_per_artifact,
        )

    def _get_source(self) -> LocalReferenceSource:
        if _revision(self._root) != self._source.revision:
            raise ValueError(
                "reference source revision changed; refresh the index before retrieval"
            )
        return self._source
