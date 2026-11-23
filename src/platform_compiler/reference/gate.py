from __future__ import annotations

from enum import StrEnum

from pydantic import BaseModel, ConfigDict

from platform_compiler.evidence.models import EvidenceClass, EvidenceRecord


class GateOutcome(StrEnum):
    INSUFFICIENT_EVIDENCE = "insufficient_evidence"
    NATIVE_SOLUTION_REQUIRED = "native_solution_required"
    NATIVE_TEST_REQUIRED = "native_test_required"
    ESCALATION_ELIGIBLE = "escalation_eligible"


class NativeGateResult(BaseModel):
    model_config = ConfigDict(frozen=True)

    outcome: GateOutcome
    target_evidence_ids: tuple[str, ...]
    reference_evidence_ids: tuple[str, ...]
    rationale: str


def evaluate_native_gate(
    evidence: tuple[EvidenceRecord, ...],
    *,
    native_solution_tested: bool,
    native_solution_sufficient: bool,
) -> NativeGateResult:
    """Reference evidence informs comparison but never satisfies target-side gates."""
    target_ids = tuple(
        record.identifier
        for record in evidence
        if record.evidence_class is EvidenceClass.OBSERVED_TARGET
    )
    reference_ids = tuple(
        record.identifier
        for record in evidence
        if record.evidence_class is EvidenceClass.REFERENCE_PLATFORM
    )
    if not target_ids:
        return NativeGateResult(
            outcome=GateOutcome.INSUFFICIENT_EVIDENCE,
            target_evidence_ids=(),
            reference_evidence_ids=reference_ids,
            rationale="Reference-platform evidence cannot establish target behavior.",
        )
    if not native_solution_tested:
        outcome = GateOutcome.NATIVE_TEST_REQUIRED
        rationale = "Test the native solution path before considering escalation."
    elif native_solution_sufficient:
        outcome = GateOutcome.NATIVE_SOLUTION_REQUIRED
        rationale = "A sufficient native solution must take priority over escalation."
    else:
        outcome = GateOutcome.ESCALATION_ELIGIBLE
        rationale = "Target evidence and an insufficient native path permit review."
    return NativeGateResult(
        outcome=outcome,
        target_evidence_ids=target_ids,
        reference_evidence_ids=reference_ids,
        rationale=rationale,
    )
