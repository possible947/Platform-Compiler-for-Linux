"""Offline, provenance-preserving reference artifact access."""

from platform_compiler.reference.config import (
    DarwinDumpedConfig,
    KnowledgeSourcesConfig,
    ReferenceSourcesConfig,
    create_darwin_dumped_source,
    load_reference_config,
)
from platform_compiler.reference.darwin_dumped import DarwinDumpedSource
from platform_compiler.reference.models import (
    ArtifactClass,
    ArtifactProvenance,
    ReferenceArtifact,
    ReferenceSnapshot,
)
from platform_compiler.reference.source import LocalReferenceSource, ReferenceSource

__all__ = [
    "ArtifactClass",
    "ArtifactProvenance",
    "DarwinDumpedConfig",
    "DarwinDumpedSource",
    "KnowledgeSourcesConfig",
    "LocalReferenceSource",
    "ReferenceArtifact",
    "ReferenceSnapshot",
    "ReferenceSource",
    "ReferenceSourcesConfig",
    "create_darwin_dumped_source",
    "load_reference_config",
]
