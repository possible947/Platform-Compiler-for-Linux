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


class Finding(BaseModel):
    """Derived, unverified interpretation linked to its supporting evidence."""

    model_config = ConfigDict(frozen=True)

    identifier: str
    evidence_class: Literal[EvidenceClass.AI_HYPOTHESIS] = EvidenceClass.AI_HYPOTHESIS
    summary: str
    evidence_ids: tuple[str, ...]
    derived_by: str
    confidence: float | None = Field(default=None, ge=0.0, le=1.0)
