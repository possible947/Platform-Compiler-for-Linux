from __future__ import annotations

from datetime import datetime, timezone
from pathlib import Path

import pytest
from pydantic import ValidationError

from platform_compiler.evidence.models import (
    EvidenceKind,
    EvidenceRecord,
    Finding,
    Provenance,
)
from platform_compiler.inference import (
    InferenceConfig,
    InferenceRecord,
    InferenceRequest,
    InferenceRole,
    InferenceRouter,
    RoleConfig,
    load_inference_config,
)
from platform_compiler.verification import (
    RepairProposal,
    VerificationResult,
    VerificationStatus,
)
from platform_compiler.workspace import Workspace


def test_workspace_initialize_and_validate(tmp_path: Path) -> None:
    workspace_path = tmp_path / "outside-checkout"
    workspace = Workspace.initialize(workspace_path)

    assert workspace.config.path == workspace_path.resolve()
    assert Workspace.open(workspace_path).config == workspace.config
    assert list(workspace_path.iterdir()) == []

    with pytest.raises(ValueError, match="does not exist"):
        Workspace.open(tmp_path / "missing")


def test_workspace_initialize_rejects_file(tmp_path: Path) -> None:
    file_path = tmp_path / "not-a-directory"
    file_path.write_text("synthetic", encoding="utf-8")

    with pytest.raises((NotADirectoryError, ValueError)):
        Workspace.initialize(file_path)


def test_evidence_keeps_provenance_and_findings_derived() -> None:
    evidence = EvidenceRecord(
        identifier="ev-1",
        kind=EvidenceKind.RUNTIME,
        provenance=Provenance(source="synthetic-test", reference="capture-1"),
        summary="Synthetic runtime observation",
    )
    finding = Finding(
        identifier="finding-1",
        summary="Derived interpretation",
        evidence_ids=(evidence.identifier,),
        derived_by="test",
        confidence=0.8,
    )

    restored = EvidenceRecord.model_validate_json(evidence.model_dump_json())
    assert restored == evidence
    assert restored.provenance.source == "synthetic-test"
    assert finding.evidence_ids == ("ev-1",)
    assert not hasattr(finding, "kind")

    with pytest.raises(ValidationError):
        Finding(
            identifier="invalid",
            summary="Invalid confidence",
            evidence_ids=(),
            derived_by="test",
            confidence=1.5,
        )


def test_inference_roles_route_to_fake_provider_without_server() -> None:
    config = InferenceConfig(
        roles={
            InferenceRole.REPAIR_ENGINEER: RoleConfig(
                endpoint="http://127.0.0.1:8080/v1",
                model="configured-model",
            )
        }
    )

    class FakeProvider:
        def complete(self, request: InferenceRequest, role_config: RoleConfig) -> str:
            assert request.role is InferenceRole.REPAIR_ENGINEER
            assert role_config.model == "configured-model"
            return "synthetic proposal"

    record = InferenceRouter(config, {"local": FakeProvider()}).infer(
        InferenceRequest(
            role=InferenceRole.REPAIR_ENGINEER,
            prompt="Use synthetic evidence only.",
            evidence_ids=("synthetic-evidence",),
        )
    )

    assert record.response == "synthetic proposal"
    assert record.model == "configured-model"
    assert len(record.request_sha256) == 64
    assert "status" not in record.model_dump()
    assert InferenceRecord.model_validate_json(record.model_dump_json()) == record


def test_inference_config_loads_role_mapping_from_toml() -> None:
    config = load_inference_config(
        Path(__file__).parents[1] / "examples" / "inference.example.toml"
    )

    assert config.roles[InferenceRole.RUNTIME_FORENSIC_ANALYZER].provider == "local"
    assert config.roles[InferenceRole.FRONTIER_REVIEWER].api_key_env
    assert "api_key" not in config.roles[InferenceRole.FRONTIER_REVIEWER].model_dump()


def test_inference_config_requires_section(tmp_path: Path) -> None:
    config_path = tmp_path / "empty.toml"
    config_path.write_text("", encoding="utf-8")

    with pytest.raises(ValueError, match="missing"):
        load_inference_config(config_path)


def test_proposal_and_verification_are_distinct_serialized_contracts() -> None:
    proposal = RepairProposal(
        identifier="proposal-1",
        finding_ids=("finding-1",),
        summary="Synthetic change",
        proposed_changes=("synthetic change only",),
        confidence=0.99,
    )
    result = VerificationResult(
        proposal_id=proposal.identifier,
        status=VerificationStatus.REJECTED,
        verifier="synthetic-test-verifier",
        checks=("synthetic rejection check",),
        evidence_ids=("synthetic-evidence",),
        completed_at=datetime.now(timezone.utc),
    )

    assert not hasattr(proposal, "status")
    assert not hasattr(proposal, "mark_verified")
    assert RepairProposal.model_validate_json(proposal.model_dump_json()) == proposal
    assert (
        VerificationResult.model_validate_json(result.model_dump_json()).status
        is VerificationStatus.REJECTED
    )

    with pytest.raises(ValidationError):
        RepairProposal(
            identifier="invalid",
            finding_ids=(),
            summary="Invalid confidence",
            proposed_changes=(),
            confidence=1.1,
        )
