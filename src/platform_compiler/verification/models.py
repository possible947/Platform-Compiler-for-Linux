from __future__ import annotations

from datetime import datetime
from enum import StrEnum
from typing import Protocol

from pydantic import BaseModel, ConfigDict, Field

from platform_compiler.evidence.models import Finding


class RepairProposal(BaseModel):
    """An unverified proposed change derived from findings."""

    model_config = ConfigDict(frozen=True)

    identifier: str
    finding_ids: tuple[str, ...]
    summary: str
    proposed_changes: tuple[str, ...]
    confidence: float | None = Field(default=None, ge=0.0, le=1.0)


class VerificationStatus(StrEnum):
    VERIFIED = "verified"
    REJECTED = "rejected"


class VerificationResult(BaseModel):
    """A verifier-owned outcome, not a field on an inference proposal."""

    model_config = ConfigDict(frozen=True)

    proposal_id: str
    status: VerificationStatus
    verifier: str
    checks: tuple[str, ...]
    evidence_ids: tuple[str, ...]
    completed_at: datetime


class Verifier(Protocol):
    """Independent service contract for evaluating a proposal against evidence."""

    def verify(
        self,
        proposal: RepairProposal,
        findings: tuple[Finding, ...],
    ) -> VerificationResult:
        ...
