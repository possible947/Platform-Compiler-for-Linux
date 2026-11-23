from __future__ import annotations

from enum import StrEnum
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field


class ArtifactClass(StrEnum):
    ACPI = "acpi"
    DMI = "dmi"
    PCI = "pci"
    IOREGISTRY = "ioregistry"
    CPU = "cpu"
    MEMORY = "memory"
    DEVICE_PROPERTIES = "device_properties"
    POWER = "power"
    RTC = "rtc"
    NVRAM = "nvram"
    SMC = "smc"
    KERNEL = "kernel"
    BOOT = "boot"
    SYSTEM_PROFILER = "system_profiler"
    OTHER = "other"


class ParseStatus(StrEnum):
    PARSED = "PARSED"
    PARTIALLY_PARSED = "PARTIALLY_PARSED"
    UNSUPPORTED = "UNSUPPORTED"
    FAILED = "FAILED"


class ReferencePlatformId(BaseModel):
    model_config = ConfigDict(frozen=True)

    vendor: str
    product_family: str
    model_identifier: str
    sample_identifier: str = "default"
    source_path: str


class ArtifactProvenance(BaseModel):
    model_config = ConfigDict(frozen=True)

    repository: str
    revision: str | None
    platform: ReferencePlatformId
    relative_path: str
    content_sha256: str
    parser: str = "none"
    parser_version: str = "0"
    parse_status: ParseStatus = ParseStatus.UNSUPPORTED
    evidence_class: Literal["reference_platform"] = "reference_platform"


class ReferenceArtifact(BaseModel):
    model_config = ConfigDict(frozen=True)

    artifact_class: ArtifactClass
    source_category: str | None = None
    relative_path: str
    size_bytes: int = Field(ge=0)
    content_sha256: str
    is_symlink: bool = False
    evidence_class: Literal["reference_platform"] = "reference_platform"
    provenance: ArtifactProvenance


class ReferencePlatformModel(BaseModel):
    """Reference data kept distinct from facts about the target machine."""

    model_config = ConfigDict(frozen=True)

    identity: ReferencePlatformId
    evidence_class: Literal["reference_platform"] = "reference_platform"
    available_artifact_classes: tuple[ArtifactClass, ...] = ()
    missing_artifact_classes: tuple[ArtifactClass, ...] = ()
    source_paths: tuple[str, ...] = ()
    artifacts: tuple[ReferenceArtifact, ...] = ()
    features: dict[str, ReferenceFeatureFact] = Field(default_factory=dict)


class ReferenceFeatureFact(BaseModel):
    model_config = ConfigDict(frozen=True)

    value: str | int | tuple[str, ...]
    provenance: tuple[ArtifactProvenance, ...] = Field(min_length=1)


class ParserOutput(BaseModel):
    model_config = ConfigDict(frozen=True)

    parsed_value: str | dict[str, object] | list[object] | None = None
    normalized_facts: dict[str, str | int | bool | tuple[str, ...]] = Field(
        default_factory=dict
    )
    status: Literal[ParseStatus.PARSED, ParseStatus.PARTIALLY_PARSED]


class TargetFeatureFact(BaseModel):
    model_config = ConfigDict(frozen=True)

    value: str | int | tuple[str, ...]
    evidence_ids: tuple[str, ...] = Field(min_length=1)


class PlatformIdentityViews(BaseModel):
    """Keep distinct identity layers rather than treating presented names as hardware."""

    model_config = ConfigDict(frozen=True)

    physical_hardware: dict[str, TargetFeatureFact] = Field(default_factory=dict)
    firmware_provided: dict[str, TargetFeatureFact] = Field(default_factory=dict)
    presented_or_spoofed: dict[str, TargetFeatureFact] = Field(default_factory=dict)
    os_interpretation: dict[str, TargetFeatureFact] = Field(default_factory=dict)


class TargetPlatformProfile(BaseModel):
    """Feature facts observed on the target, never a reference profile."""

    model_config = ConfigDict(frozen=True)

    evidence_class: Literal["observed_target"] = "observed_target"
    features: dict[str, TargetFeatureFact] = Field(default_factory=dict)
    identity_views: PlatformIdentityViews = Field(default_factory=PlatformIdentityViews)


class ReferenceIndex(BaseModel):
    model_config = ConfigDict(frozen=True)

    index_version: int
    parser_version: str
    repository: str
    source_revision: str | None
    platforms: tuple[ReferencePlatformModel, ...]
    unclassified_files: tuple[UnclassifiedReferenceFile, ...] = ()


class UnclassifiedReferenceFile(BaseModel):
    """Repository-level file retained when it is outside a model directory."""

    model_config = ConfigDict(frozen=True)

    repository: str
    revision: str | None
    relative_path: str
    size_bytes: int = Field(ge=0)
    content_sha256: str
    is_symlink: bool = False


class ParsedArtifact(BaseModel):
    """A derived parse result that retains its raw artifact provenance."""

    model_config = ConfigDict(frozen=True)

    raw_sha256: str
    parsed_value: str | dict[str, object] | list[object] | None = None
    normalized_facts: dict[str, str | int | bool | tuple[str, ...]] = Field(
        default_factory=dict
    )
    provenance: ArtifactProvenance


class CandidateFeature(BaseModel):
    model_config = ConfigDict(frozen=True)

    feature: str
    target_value: str | int | tuple[str, ...] | None = None
    reference_value: str | int | tuple[str, ...] | None = None
    target_evidence_ids: tuple[str, ...] = ()
    reference_provenance: tuple[ArtifactProvenance, ...] = ()


class ReferenceCandidate(BaseModel):
    model_config = ConfigDict(frozen=True)

    platform: ReferencePlatformId
    score: float = Field(ge=0.0, le=1.0)
    matched_features: tuple[CandidateFeature, ...] = ()
    mismatched_features: tuple[CandidateFeature, ...] = ()
    unknown_features: tuple[str, ...] = ()


class ReferenceSelection(BaseModel):
    model_config = ConfigDict(frozen=True)

    candidates: tuple[ReferenceCandidate, ...]
    selected: ReferenceCandidate | None = None


class RetrievedReferenceArtifact(BaseModel):
    model_config = ConfigDict(frozen=True)

    artifact: ReferenceArtifact
    content: str
    truncated: bool = False


class ReferenceContext(BaseModel):
    model_config = ConfigDict(frozen=True)

    evidence_class: Literal["reference_platform"] = "reference_platform"
    diagnostic_question: str
    candidate: ReferenceCandidate
    requested_classes: tuple[ArtifactClass, ...]
    artifacts: tuple[RetrievedReferenceArtifact, ...]
    missing_requested_classes: tuple[ArtifactClass, ...] = ()
    omitted_artifact_count: int = 0


class ACPIResultStatus(StrEnum):
    MODIFIED = "MODIFIED"
    UNCHANGED = "UNCHANGED"
    INSUFFICIENT_EVIDENCE = "INSUFFICIENT_EVIDENCE"
    FAILED = "FAILED"


class ACPIDifference(BaseModel):
    model_config = ConfigDict(frozen=True)

    path: str
    target_value: str | None
    reference_value: str | None
    target_device_id: str | None = None
    reference_device_id: str | None = None
    classification: Literal["observed_difference"] = "observed_difference"


class ACPIComparisonResult(BaseModel):
    """MODIFIED means structures differ; this comparison never patches target ACPI."""

    model_config = ConfigDict(frozen=True)

    status: ACPIResultStatus
    differences: tuple[ACPIDifference, ...] = ()
    target_evidence_ids: tuple[str, ...] = ()
    reference_evidence_ids: tuple[str, ...] = ()
    error: str | None = None
