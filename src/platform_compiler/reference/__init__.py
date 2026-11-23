"""Local, provenance-preserving reference-platform knowledge sources."""

from platform_compiler.reference.acpi import compare_acpi_structure
from platform_compiler.reference.config import (
    DarwinDumpedConfig,
    KnowledgeSourcesConfig,
    ReferenceSourcesConfig,
    create_darwin_dumped_source,
    load_reference_config,
)
from platform_compiler.reference.darwin_dumped import DarwinDumpedSource
from platform_compiler.reference.gate import (
    GateOutcome,
    NativeGateResult,
    evaluate_native_gate,
)
from platform_compiler.reference.indexer import (
    DARWINDUMPED_REPOSITORY,
    DarwinDumpedIndexer,
    parse_artifact,
)
from platform_compiler.reference.matching import (
    FEATURE_DIMENSIONS,
    CandidateScorer,
    ExactFeatureScorer,
    ReferenceFeatureExtractor,
    select_reference_candidates,
)
from platform_compiler.reference.models import (
    ACPIComparisonResult,
    ACPIResultStatus,
    ArtifactClass,
    ArtifactProvenance,
    CandidateFeature,
    ParseStatus,
    ParsedArtifact,
    PlatformIdentityViews,
    ParserOutput,
    ReferenceArtifact,
    ReferenceCandidate,
    ReferenceContext,
    ReferenceFeatureFact,
    ReferenceIndex,
    ReferencePlatformId,
    ReferencePlatformModel,
    ReferenceSelection,
    TargetFeatureFact,
    TargetPlatformProfile,
    UnclassifiedReferenceFile,
)
from platform_compiler.reference.retrieval import (
    build_reference_context,
    render_reference_context,
)
from platform_compiler.reference.source import ArtifactParser, ReferenceSource

__all__ = [
    "ACPIComparisonResult",
    "ACPIResultStatus",
    "ArtifactClass",
    "ArtifactParser",
    "ArtifactProvenance",
    "CandidateFeature",
    "CandidateScorer",
    "DARWINDUMPED_REPOSITORY",
    "DarwinDumpedConfig",
    "DarwinDumpedIndexer",
    "DarwinDumpedSource",
    "ExactFeatureScorer",
    "FEATURE_DIMENSIONS",
    "GateOutcome",
    "KnowledgeSourcesConfig",
    "NativeGateResult",
    "ParseStatus",
    "ParsedArtifact",
    "PlatformIdentityViews",
    "ParserOutput",
    "ReferenceArtifact",
    "ReferenceCandidate",
    "ReferenceContext",
    "ReferenceFeatureExtractor",
    "ReferenceFeatureFact",
    "ReferenceIndex",
    "ReferencePlatformId",
    "ReferencePlatformModel",
    "ReferenceSelection",
    "ReferenceSource",
    "ReferenceSourcesConfig",
    "TargetPlatformProfile",
    "TargetFeatureFact",
    "UnclassifiedReferenceFile",
    "build_reference_context",
    "compare_acpi_structure",
    "create_darwin_dumped_source",
    "evaluate_native_gate",
    "load_reference_config",
    "parse_artifact",
    "render_reference_context",
    "select_reference_candidates",
]
