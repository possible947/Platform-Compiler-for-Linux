from __future__ import annotations

from datetime import datetime
from enum import StrEnum

from pydantic import BaseModel, ConfigDict, Field


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
    provenance: Provenance
    summary: str


class PlatformEvidence(BaseModel):
    """A collection of distinct evidence records; it does not assert findings."""

    model_config = ConfigDict(frozen=True)

    records: tuple[EvidenceRecord, ...] = ()


class Finding(BaseModel):
    """Derived, unverified interpretation linked to its supporting evidence."""

    model_config = ConfigDict(frozen=True)

    identifier: str
    summary: str
    evidence_ids: tuple[str, ...]
    derived_by: str
    confidence: float | None = Field(default=None, ge=0.0, le=1.0)
