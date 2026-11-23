from __future__ import annotations

from datetime import datetime
from enum import StrEnum
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field, model_validator


class EvidenceClass(StrEnum):
    OBSERVED_TARGET = "observed_target"
    REFERENCE_PLATFORM = "reference_platform"
    AI_HYPOTHESIS = "ai_hypothesis"


class EvidenceKind(StrEnum):
    STATIC = "static"
    RUNTIME = "runtime"
    EMPIRICAL_AB = "empirical_ab"
    REFERENCE_PLATFORM = "reference_platform"


class Provenance(BaseModel):
    model_config = ConfigDict(frozen=True)

    source: str
    reference: str
    observed_at: datetime | None = None
    sha256: str | None = None


class EvidenceRecord(BaseModel):
    model_config = ConfigDict(frozen=True)

    identifier: str
    kind: EvidenceKind
    evidence_class: EvidenceClass = EvidenceClass.OBSERVED_TARGET
    provenance: Provenance
    summary: str

    @model_validator(mode="before")
    @classmethod
    def infer_legacy_evidence_class(cls, value: object) -> object:
        if isinstance(value, dict) and "evidence_class" not in value:
            data = dict(value)
            data["evidence_class"] = (
                EvidenceClass.REFERENCE_PLATFORM
                if data.get("kind") == EvidenceKind.REFERENCE_PLATFORM
                else EvidenceClass.OBSERVED_TARGET
            )
            return data
        return value

    @model_validator(mode="after")
    def reference_kind_has_reference_class(self) -> EvidenceRecord:
        if self.evidence_class is EvidenceClass.AI_HYPOTHESIS:
            raise ValueError(
                "AI hypotheses must be represented as findings, not evidence"
            )
        if self.kind is EvidenceKind.REFERENCE_PLATFORM:
            if self.evidence_class is not EvidenceClass.REFERENCE_PLATFORM:
                raise ValueError(
                    "reference-platform evidence must retain its evidence class"
                )
        elif self.evidence_class is EvidenceClass.REFERENCE_PLATFORM:
            raise ValueError("reference evidence must use the reference-platform kind")
        return self


class PlatformEvidence(BaseModel):
    """A collection of distinct evidence records; it does not assert findings."""

    model_config = ConfigDict(frozen=True)

    records: tuple[EvidenceRecord, ...] = ()


_SHA256_PATTERN = r"^[0-9a-f]{64}$"


class ToolInvocation(BaseModel):
    """One recorded execution of a deterministic external tool."""

    model_config = ConfigDict(frozen=True, extra="forbid")

    tool: str
    executable: str
    executable_sha256: str = Field(pattern=_SHA256_PATTERN)
    version: str
    argv: tuple[str, ...] = Field(min_length=1)
    working_directory: str
    environment: dict[str, str]
    timeout_seconds: float = Field(gt=0)
    timed_out: bool
    exit_status: int | None
    stdout_sha256: str = Field(pattern=_SHA256_PATTERN)
    stderr_sha256: str = Field(pattern=_SHA256_PATTERN)


class SourceCapture(BaseModel):
    """Identity of one observed raw capture consumed by a derivation."""

    model_config = ConfigDict(frozen=True, extra="forbid")

    snapshot_id: str
    capture_id: str
    content_sha256: str = Field(pattern=_SHA256_PATTERN)


class DerivedArtifact(BaseModel):
    """Deterministic tool output derived from identified observed captures.

    It is neither raw observed evidence nor an AI hypothesis: its trust is that of
    its source captures plus the recorded tool invocation that produced it.
    """

    model_config = ConfigDict(frozen=True, extra="forbid")

    artifact_path: str
    size_bytes: int = Field(ge=0)
    content_sha256: str = Field(pattern=_SHA256_PATTERN)
    derivation_id: str = Field(pattern=_SHA256_PATTERN)
    source_evidence_class: Literal[EvidenceClass.OBSERVED_TARGET] = (
        EvidenceClass.OBSERVED_TARGET
    )
    subject_capture_id: str | None = None
    derived_from: tuple[SourceCapture, ...] = Field(min_length=1)
    derived_by: ToolInvocation

    @model_validator(mode="after")
    def subject_is_a_source(self) -> DerivedArtifact:
        if self.subject_capture_id is not None and self.subject_capture_id not in {
            source.capture_id for source in self.derived_from
        }:
            raise ValueError("derived artifact subject must be one of its source captures")
        return self


class Finding(BaseModel):
    """Derived, unverified interpretation linked to its supporting evidence."""

    model_config = ConfigDict(frozen=True)

    identifier: str
    evidence_class: Literal[EvidenceClass.AI_HYPOTHESIS] = EvidenceClass.AI_HYPOTHESIS
    summary: str
    evidence_ids: tuple[str, ...]
    derived_by: str
    confidence: float | None = Field(default=None, ge=0.0, le=1.0)
