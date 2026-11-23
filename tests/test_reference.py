from __future__ import annotations

import hashlib
import os
import socket
from pathlib import Path

import pytest
from pydantic import ValidationError

from platform_compiler.evidence.models import (
    EvidenceClass,
    EvidenceKind,
    EvidenceRecord,
    Provenance,
)
from platform_compiler.reference import (
    ACPIResultStatus,
    ArtifactClass,
    ArtifactProvenance,
    CandidateFeature,
    DarwinDumpedConfig,
    DarwinDumpedIndexer,
    DarwinDumpedSource,
    GateOutcome,
    ParseStatus,
    ParserOutput,
    PlatformIdentityViews,
    ReferenceCandidate,
    ReferenceFeatureFact,
    ReferencePlatformModel,
    TargetFeatureFact,
    TargetPlatformProfile,
    build_reference_context,
    compare_acpi_structure,
    create_darwin_dumped_source,
    evaluate_native_gate,
    load_reference_config,
    parse_artifact,
    render_reference_context,
    select_reference_candidates,
)
from platform_compiler.reference.indexer import _file_digest


def _write(root: Path, relative: str, content: bytes = b"fixture\n") -> Path:
    path = root / relative
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(content)
    return path


def _fixture(root: Path) -> None:
    _write(root, "README.md", b"repository metadata")
    _write(root, "MacPro/MacPro7,1/ACPI Tables/DSDT.aml", b"raw-acpi")
    _write(root, "MacPro/MacPro7,1/LSPCI/lspci.txt", b"0000:00:1f.0")
    _write(root, "MacPro/MacPro7,1(Retail Demo)/CPU/cpu.txt", b"cpu")
    _write(root, "MacBookPro/MacBookPro15,1/Mystery/unknown.bin", b"unknown")


def _reference_feature(
    identity: dict[str, str],
    path: str,
    value: str | int,
) -> ReferenceFeatureFact:
    return ReferenceFeatureFact(
        value=value,
        provenance=(
            ArtifactProvenance(
                repository="possible947/DarwinDumped",
                revision=None,
                platform=identity,
                relative_path=path,
                content_sha256=hashlib.sha256(path.encode()).hexdigest(),
                parser="fixture",
                parser_version="1",
                parse_status=ParseStatus.PARSED,
            ),
        ),
    )


def test_index_discovers_families_models_samples_and_missing_categories(
    tmp_path: Path,
) -> None:
    _fixture(tmp_path)

    index = DarwinDumpedIndexer(tmp_path).build()
    by_id = {
        (
            item.identity.product_family,
            item.identity.model_identifier,
            item.identity.sample_identifier,
        ): item
        for item in index.platforms
    }

    assert ("MacPro", "MacPro7,1", "default") in by_id
    assert ("MacPro", "MacPro7,1", "Retail Demo") in by_id
    assert ("MacBookPro", "MacBookPro15,1", "default") in by_id
    assert by_id[("MacPro", "MacPro7,1", "default")].available_artifact_classes == (
        ArtifactClass.ACPI,
        ArtifactClass.PCI,
    )
    assert (
        ArtifactClass.MEMORY
        in by_id[("MacPro", "MacPro7,1", "default")].missing_artifact_classes
    )
    other = by_id[("MacBookPro", "MacBookPro15,1", "default")].artifacts[0]
    assert other.artifact_class is ArtifactClass.OTHER
    assert other.relative_path.endswith("Mystery/unknown.bin")
    assert any(item.relative_path == "README.md" for item in index.unclassified_files)


def test_index_is_deterministic_and_preserves_digest_provenance(tmp_path: Path) -> None:
    _fixture(tmp_path)
    cache = tmp_path.parent / f"{tmp_path.name}-index.json"
    indexer = DarwinDumpedIndexer(tmp_path, cache_path=cache)

    first = indexer.build()
    second = indexer.build()
    assert first == second

    artifact = next(
        item
        for model in first.platforms
        for item in model.artifacts
        if item.relative_path.endswith("DSDT.aml")
    )
    assert artifact.content_sha256 == hashlib.sha256(b"raw-acpi").hexdigest()
    assert artifact.provenance.repository == "possible947/DarwinDumped"
    assert artifact.provenance.revision is None
    assert artifact.provenance.platform.model_identifier == "MacPro7,1"
    assert artifact.provenance.relative_path == artifact.relative_path
    assert artifact.provenance.parser == "none"
    assert artifact.provenance.parse_status is ParseStatus.UNSUPPORTED
    assert artifact.evidence_class == "reference_platform"
    assert artifact.provenance.evidence_class == "reference_platform"


def test_index_cache_reuses_unchanged_artifact_hashes(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    _fixture(tmp_path)
    cache = tmp_path.parent / f"{tmp_path.name}-cache.json"
    indexer = DarwinDumpedIndexer(tmp_path, cache_path=cache)
    calls = 0

    def count_digest(path: Path) -> str:
        nonlocal calls
        calls += 1
        return _file_digest(path)

    monkeypatch.setattr("platform_compiler.reference.indexer._file_digest", count_digest)
    initial = indexer.build()
    initial_calls = calls
    indexer.build()
    assert initial_calls == 5
    assert calls == initial_calls
    acpi_path = tmp_path / "MacPro/MacPro7,1/ACPI Tables/DSDT.aml"
    acpi_path.write_bytes(b"new-acpi")
    stat = acpi_path.stat()
    os.utime(acpi_path, ns=(stat.st_atime_ns, stat.st_mtime_ns + 1_000_000))
    changed = indexer.build()
    assert calls == initial_calls + 1
    changed_artifact = next(
        item
        for model in changed.platforms
        for item in model.artifacts
        if item.relative_path.endswith("DSDT.aml")
    )
    assert changed_artifact.content_sha256 == hashlib.sha256(b"new-acpi").hexdigest()
    assert changed_artifact.content_sha256 != next(
        item
        for model in initial.platforms
        for item in model.artifacts
        if item.relative_path.endswith("DSDT.aml")
    ).content_sha256


def test_index_cache_cannot_write_into_reference_checkout(tmp_path: Path) -> None:
    _fixture(tmp_path)
    with pytest.raises(ValueError, match="outside the source checkout"):
        DarwinDumpedIndexer(tmp_path, cache_path=tmp_path / "index.json")


def test_parser_failure_is_recorded_without_invalidating_platform(
    tmp_path: Path,
) -> None:
    _fixture(tmp_path)
    source = DarwinDumpedSource(tmp_path)
    artifact = next(
        item
        for model in source.list_platforms()
        for item in model.artifacts
        if item.relative_path.endswith("DSDT.aml")
    )

    class BrokenParser:
        name = "fixture-parser"
        version = "2"

        def parse(self, raw_content: bytes) -> ParserOutput:
            raise ValueError("invalid fixture")

    parsed = parse_artifact(source.read_artifact(artifact), artifact, BrokenParser())
    assert parsed.raw_sha256 == artifact.content_sha256
    assert parsed.provenance.parse_status is ParseStatus.FAILED
    assert parsed.provenance.parser == "fixture-parser"
    assert parsed.normalized_facts["parse_error"] == "invalid fixture"
    mismatched_raw = parse_artifact(b"tampered", artifact)
    assert mismatched_raw.raw_sha256 != artifact.content_sha256
    assert mismatched_raw.provenance.parse_status is ParseStatus.FAILED
    assert len(source.list_platforms()) == 3


def test_parser_status_and_normalized_facts_keep_raw_provenance(
    tmp_path: Path,
) -> None:
    _fixture(tmp_path)
    source = DarwinDumpedSource(tmp_path)
    artifact = next(
        item
        for model in source.list_platforms()
        for item in model.artifacts
        if item.relative_path.endswith("DSDT.aml")
    )

    class PartialParser:
        name = "fixture-parser"
        version = "3"

        def parse(self, raw_content: bytes) -> ParserOutput:
            assert raw_content == b"raw-acpi"
            return ParserOutput(
                parsed_value={"objects": ["\\_SB.PCI0"]},
                normalized_facts={"object_count": 1},
                status=ParseStatus.PARTIALLY_PARSED,
            )

    parsed = parse_artifact(source.read_artifact(artifact), artifact, PartialParser())
    assert parsed.raw_sha256 == artifact.content_sha256
    assert parsed.provenance.parse_status is ParseStatus.PARTIALLY_PARSED
    assert parsed.provenance.parser_version == "3"
    assert parsed.normalized_facts == {"object_count": 1}


def test_candidate_matching_reports_matches_mismatches_and_unknowns() -> None:
    target = TargetPlatformProfile(
        features={
            "cpu_generation": TargetFeatureFact(
                value="Cascade Lake", evidence_ids=("target-cpu",)
            ),
            "cpu_packages": TargetFeatureFact(value=2, evidence_ids=("target-cpu",)),
            "chipset_generation": TargetFeatureFact(
                value="C620", evidence_ids=("target-pci",)
            ),
        },
        identity_views=PlatformIdentityViews(
            physical_hardware={
                "cpu_vendor": TargetFeatureFact(
                    value="GenuineIntel", evidence_ids=("target-cpu",)
                )
            },
            firmware_provided={
                "system_product_name": TargetFeatureFact(
                    value="Board model", evidence_ids=("target-dmi",)
                )
            },
            presented_or_spoofed={
                "system_product_name": TargetFeatureFact(
                    value="MacPro7,1", evidence_ids=("target-identity-config",)
                )
            },
            os_interpretation={
                "reported_platform": TargetFeatureFact(
                    value="MacPro7,1", evidence_ids=("target-os-view",)
                )
            },
        ),
    )
    close_identity = {
        "vendor": "Apple",
        "product_family": "MacPro",
        "model_identifier": "unrelated-name",
        "source_path": "MacPro/unrelated-name",
    }
    distant_identity = {
        "vendor": "Apple",
        "product_family": "MacBookPro",
        "model_identifier": "similar-name-not-used",
        "source_path": "MacBookPro/similar-name-not-used",
    }
    close = ReferencePlatformModel(
        identity=close_identity,
        features={
            "cpu_generation": _reference_feature(
                close_identity, "MacPro/unrelated-name/CPU/cpu.txt", "Cascade Lake"
            ),
            "cpu_packages": _reference_feature(
                close_identity, "MacPro/unrelated-name/CPU/cpu.txt", 1
            ),
            "chipset_generation": _reference_feature(
                close_identity, "MacPro/unrelated-name/LSPCI/pci.txt", "C620"
            ),
        },
    )
    distant = ReferencePlatformModel(
        identity=distant_identity,
        features={
            "cpu_generation": _reference_feature(
                distant_identity,
                "MacBookPro/similar-name-not-used/CPU/cpu.txt",
                "Coffee Lake",
            ),
            "cpu_packages": _reference_feature(
                distant_identity, "MacBookPro/similar-name-not-used/CPU/cpu.txt", 2
            ),
            "chipset_generation": _reference_feature(
                distant_identity,
                "MacBookPro/similar-name-not-used/LSPCI/pci.txt",
                "300-series",
            ),
        },
    )

    result = select_reference_candidates(target, (distant, close))
    assert result.selected is not None
    assert result.selected.platform == close.identity
    assert result.selected.score == pytest.approx(2 / 3)
    assert [item.feature for item in result.selected.matched_features] == [
        "cpu_generation",
        "chipset_generation",
    ]
    assert result.selected.matched_features[0].target_evidence_ids == ("target-cpu",)
    assert (
        result.selected.matched_features[0].reference_provenance[0].relative_path
        == "MacPro/unrelated-name/CPU/cpu.txt"
    )
    assert [item.feature for item in result.selected.mismatched_features] == [
        "cpu_packages"
    ]
    assert "pcie_topology" in result.selected.unknown_features
    assert result.selected.mismatched_features[0].target_value == 2
    tie_target = TargetPlatformProfile(
        features={
            "cpu_generation": TargetFeatureFact(
                value="Cascade Lake", evidence_ids=("target-cpu",)
            )
        }
    )
    tied_reference = ReferencePlatformModel(
        identity={
            "vendor": "Apple",
            "product_family": "iMac",
            "model_identifier": "different-name",
            "source_path": "iMac/different-name",
        },
        features={
            "cpu_generation": _reference_feature(
                {
                    "vendor": "Apple",
                    "product_family": "iMac",
                    "model_identifier": "different-name",
                    "source_path": "iMac/different-name",
                },
                "iMac/different-name/CPU/cpu.txt",
                "Cascade Lake",
            )
        },
    )
    assert (
        select_reference_candidates(tie_target, (close, tied_reference)).selected
        is None
    )
    presented_only = TargetPlatformProfile(
        identity_views=PlatformIdentityViews(
            presented_or_spoofed={
                "product_name": TargetFeatureFact(
                    value="MacPro7,1", evidence_ids=("spoofed-identity",)
                )
            }
        )
    )
    name_only = select_reference_candidates(presented_only, (close,))
    assert name_only.selected is None


def test_target_reference_and_hypothesis_evidence_classes_stay_distinct() -> None:
    with pytest.raises(ValidationError):
        TargetPlatformProfile(evidence_class="reference_platform")

    reference = EvidenceRecord(
        identifier="ref-1",
        kind=EvidenceKind.REFERENCE_PLATFORM,
        evidence_class=EvidenceClass.REFERENCE_PLATFORM,
        provenance=Provenance(source="DarwinDumped", reference="MacPro7,1/DSDT"),
        summary="Reference ACPI fact",
    )
    legacy_reference = EvidenceRecord(
        identifier="legacy-ref",
        kind=EvidenceKind.REFERENCE_PLATFORM,
        provenance=Provenance(source="fixture", reference="reference"),
        summary="Legacy serialization infers the reference class from its kind",
    )
    assert legacy_reference.evidence_class is EvidenceClass.REFERENCE_PLATFORM
    gate = evaluate_native_gate(
        (reference,),
        native_solution_tested=True,
        native_solution_sufficient=False,
    )
    assert gate.outcome is GateOutcome.INSUFFICIENT_EVIDENCE
    assert gate.target_evidence_ids == ()
    assert gate.reference_evidence_ids == ("ref-1",)


def test_targeted_retrieval_only_includes_requested_classes(tmp_path: Path) -> None:
    _fixture(tmp_path)
    source = DarwinDumpedSource(tmp_path)
    model = next(
        item
        for item in source.list_platforms()
        if item.identity.model_identifier == "MacPro7,1"
        and item.identity.sample_identifier == "default"
    )
    candidate = ReferenceCandidate(platform=model.identity, score=1.0)
    pci_artifact = next(
        item for item in model.artifacts if item.artifact_class is ArtifactClass.PCI
    )
    candidate = candidate.model_copy(
        update={
            "matched_features": (
                CandidateFeature(
                    feature="pcie_topology",
                    target_value="single-root",
                    reference_value="single-root",
                    target_evidence_ids=("target-pci",),
                    reference_provenance=(pci_artifact.provenance,),
                ),
            )
        }
    )

    context = build_reference_context(
        source,
        candidate,
        "Compare target PCI topology",
        (ArtifactClass.PCI, ArtifactClass.MEMORY),
        max_bytes_per_artifact=4,
    )
    rendered = render_reference_context(context)
    assert len(context.artifacts) == 1
    assert context.artifacts[0].artifact.artifact_class is ArtifactClass.PCI
    assert context.artifacts[0].content == "0000"
    assert context.artifacts[0].truncated
    assert context.missing_requested_classes == (ArtifactClass.MEMORY,)
    assert "REFERENCE-PLATFORM EVIDENCE ONLY" in rendered
    assert "LSPCI/lspci.txt" in rendered
    assert "DSDT.aml" not in rendered
    assert "not facts about the target" in rendered
    assert "Missing requested reference categories: memory" in rendered
    assert "[BEGIN UNTRUSTED REFERENCE ARTIFACT]" in rendered
    assert "Matched hardware feature pcie_topology" in rendered
    assert "status=UNSUPPORTED" in rendered

    limited_context = build_reference_context(
        source,
        candidate,
        "Compare target PCI topology",
        (ArtifactClass.PCI,),
        max_artifacts=0,
    )
    assert limited_context.omitted_artifact_count == 1
    assert "omitted by retrieval limit: 1" in render_reference_context(limited_context)


def test_retrieval_rejects_artifacts_changed_after_indexing(tmp_path: Path) -> None:
    _fixture(tmp_path)
    source = DarwinDumpedSource(tmp_path)
    model = next(
        item
        for item in source.list_platforms()
        if item.identity.model_identifier == "MacPro7,1"
        and item.identity.sample_identifier == "default"
    )
    candidate = ReferenceCandidate(platform=model.identity, score=1.0)
    _write(tmp_path, "MacPro/MacPro7,1/LSPCI/lspci.txt", b"changed-size")

    with pytest.raises(ValueError, match="changed since indexing"):
        build_reference_context(
            source,
            candidate,
            "Compare target PCI topology",
            (ArtifactClass.PCI,),
        )


def test_acpi_comparison_reports_observations_without_claiming_a_defect() -> None:
    comparison = compare_acpi_structure(
        {"\\_SB.PCI0.XHC._ADR": "0x00140000"},
        {"\\_SB.PCI0.XHC._ADR": "0x00150000"},
        target_evidence_ids=("target-acpi",),
        reference_evidence_ids=("reference-acpi",),
        target_device_paths={"\\_SB.PCI0.XHC._ADR": "0000:00:14.0"},
        reference_device_paths={"\\_SB.PCI0.XHC._ADR": "0000:00:15.0"},
    )
    assert comparison.status is ACPIResultStatus.MODIFIED
    assert comparison.differences[0].classification == "observed_difference"
    assert comparison.differences[0].target_device_id == "0000:00:14.0"
    assert comparison.target_evidence_ids == ("target-acpi",)
    assert comparison.reference_evidence_ids == ("reference-acpi",)
    assert "defect" not in str(comparison.model_dump()).lower()


def test_acpi_comparison_preserves_result_statuses() -> None:
    unchanged = compare_acpi_structure({"A": "1"}, {"A": "1"})
    insufficient = compare_acpi_structure(None, {"A": "1"})
    failed = compare_acpi_structure({}, {}, parse_error="fixture parser error")

    assert unchanged.status is ACPIResultStatus.UNCHANGED
    assert insufficient.status is ACPIResultStatus.INSUFFICIENT_EVIDENCE
    assert failed.status is ACPIResultStatus.FAILED


def test_offline_local_fixture_configuration_and_source(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    _fixture(tmp_path / "DarwinDumped")
    config_path = tmp_path / "reference.toml"
    config_path.write_text(
        "\n".join(
            [
                "[knowledge_sources.darwin_dumped]",
                "enabled = true",
                'repository = "possible947/DarwinDumped"',
                f'local_path = "{tmp_path / "DarwinDumped"}"',
                "network_runtime_access = false",
            ]
        ),
        encoding="utf-8",
    )
    config = load_reference_config(config_path)
    assert config.knowledge_sources.darwin_dumped.enabled
    assert create_darwin_dumped_source(config.knowledge_sources.darwin_dumped)

    def reject_network(*args: object, **kwargs: object) -> None:
        raise AssertionError("offline source attempted network access")

    monkeypatch.setattr(socket, "create_connection", reject_network)
    source = create_darwin_dumped_source(config.knowledge_sources.darwin_dumped)
    assert source is not None
    assert len(source.list_platforms()) == 3

    with pytest.raises(ValidationError):
        DarwinDumpedConfig.model_validate(
            {
                "enabled": True,
                "local_path": str(tmp_path),
                "network_runtime_access": True,
            }
        )
    assert create_darwin_dumped_source(DarwinDumpedConfig()) is None


def test_gate_requires_native_path_before_escalation() -> None:
    target = EvidenceRecord(
        identifier="target-runtime",
        kind=EvidenceKind.RUNTIME,
        provenance=Provenance(source="local-capture", reference="scan-1"),
        summary="Target runtime observation",
    )
    not_tested = evaluate_native_gate(
        (target,),
        native_solution_tested=False,
        native_solution_sufficient=False,
    )
    assert not_tested.outcome is GateOutcome.NATIVE_TEST_REQUIRED
    eligible = evaluate_native_gate(
        (target,),
        native_solution_tested=True,
        native_solution_sufficient=False,
    )
    assert eligible.outcome is GateOutcome.ESCALATION_ELIGIBLE
    sufficient = evaluate_native_gate(
        (target,),
        native_solution_tested=True,
        native_solution_sufficient=True,
    )
    assert sufficient.outcome is GateOutcome.NATIVE_SOLUTION_REQUIRED
    contradictory = evaluate_native_gate(
        (target,),
        native_solution_tested=False,
        native_solution_sufficient=True,
    )
    assert contradictory.outcome is GateOutcome.NATIVE_TEST_REQUIRED
