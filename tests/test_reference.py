from __future__ import annotations

import hashlib
import json
import os
import socket
import subprocess
from pathlib import Path

import pytest
from pydantic import ValidationError

from platform_compiler.evidence.models import EvidenceClass, EvidenceKind, EvidenceRecord
from platform_compiler.reference import (
    ArtifactClass,
    DarwinDumpedConfig,
    DarwinDumpedSource,
    ReferenceArtifact,
    create_darwin_dumped_source,
    load_reference_config,
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
    _write(root, "MacPro/MacPro7,1 (Retail Demo)/CPU/cpu.txt", b"cpu")
    _write(root, "MacBookPro/MacBookPro15,1/Mystery/unknown.bin", b"unknown")


def _git(root: Path, *args: str) -> str:
    return subprocess.run(
        ["git", "-C", str(root), *args],
        check=True,
        capture_output=True,
        text=True,
        env={
            **os.environ,
            "GIT_CONFIG_GLOBAL": os.devnull,
            "GIT_CONFIG_SYSTEM": os.devnull,
            "GIT_TERMINAL_PROMPT": "0",
        },
    ).stdout.strip()


def _git_fixture(root: Path) -> str:
    root.mkdir()
    _git(root, "init", "-q")
    _fixture(root)
    _git(root, "add", ".")
    _git(
        root, "-c", "user.name=Fixture", "-c", "user.email=fixture@example.invalid",
        "commit", "-q", "--no-verify", "-m", "fixture",
    )
    return _git(root, "rev-parse", "HEAD")


def test_clean_git_checkout_uses_head_revision(tmp_path: Path) -> None:
    root = tmp_path / "source"
    revision = _git_fixture(root)
    source = DarwinDumpedSource(root)
    assert source.get_artifacts("MacPro7,1")[0].provenance.revision == revision


@pytest.mark.parametrize(
    "change",
    ["modified", "staged", "deleted", "untracked", "ignored", "assume", "skip"],
)
def test_dirty_git_checkout_is_rejected_without_modification(
    tmp_path: Path, change: str,
) -> None:
    root = tmp_path / "source"
    _git_fixture(root)
    source = DarwinDumpedSource(root)
    artifact = source.get_artifacts("MacPro7,1")[0]
    path = root / "MacPro/MacPro7,1/ACPI Tables/DSDT.aml"
    if change in {"modified", "staged", "assume", "skip"}:
        if change in {"assume", "skip"}:
            flag = "--assume-unchanged" if change == "assume" else "--skip-worktree"
            _git(root, "update-index", flag, str(path))
        path.write_bytes(b"changed")
        if change == "staged":
            _git(root, "add", str(path))
    elif change == "deleted":
        path.unlink()
    elif change == "untracked":
        _write(root, "MacPro/MacPro7,1/ACPI Tables/new.aml", b"untracked")
    else:
        (root / ".git" / "info" / "exclude").write_text("*.aml\n", encoding="utf-8")
        _write(root, "MacPro/MacPro7,1/ACPI Tables/new.aml", b"ignored")
    before_status = _git(root, "status", "--porcelain=v1", "--ignored", "-uall")
    index_before = (root / ".git" / "index").read_bytes()
    files_before = {
        p.relative_to(root): p.read_bytes()
        for p in root.rglob("*")
        if p.is_file() and ".git" not in p.relative_to(root).parts
    }

    with pytest.raises(ValueError, match="dirty Git reference checkout"):
        DarwinDumpedSource(root)
    with pytest.raises(ValueError, match="dirty Git reference checkout"):
        source.read_excerpt(artifact, 1024)
    with pytest.raises(ValueError, match="dirty Git reference checkout"):
        source.refresh_index()
    with pytest.raises(ValueError, match="dirty Git reference checkout"):
        source.materialize_snapshot("MacPro7,1", tmp_path / "snapshots")

    assert (root / ".git" / "index").read_bytes() == index_before
    assert _git(root, "status", "--porcelain=v1", "--ignored", "-uall") == before_status
    assert {
        p.relative_to(root): p.read_bytes()
        for p in root.rglob("*")
        if p.is_file() and ".git" not in p.relative_to(root).parts
    } == files_before
    assert not (tmp_path / "snapshots").exists()


def test_explicit_reference_id_returns_only_its_artifacts(tmp_path: Path) -> None:
    _fixture(tmp_path)
    source = DarwinDumpedSource(tmp_path)

    artifacts = source.get_artifacts("MacPro7,1")

    assert {item.artifact_class for item in artifacts} == {
        ArtifactClass.ACPI,
        ArtifactClass.PCI,
    }
    assert all(item.provenance.reference_id == "MacPro7,1" for item in artifacts)
    assert all("/" not in item.artifact_id for item in artifacts)
    assert source.get_artifacts("MacPro7,1", (ArtifactClass.PCI,)) == (
        next(item for item in artifacts if item.artifact_class is ArtifactClass.PCI),
    )
    with pytest.raises(ValueError, match="reference is not available"):
        source.get_artifacts("MacPro")


def test_index_cache_reuses_unchanged_hashes_and_rehashes_changed_file(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    _fixture(tmp_path)
    cache = tmp_path.parent / f"{tmp_path.name}-cache.json"
    calls = 0

    def count_digest(path: Path) -> str:
        nonlocal calls
        calls += 1
        return _file_digest(path)

    monkeypatch.setattr("platform_compiler.reference.indexer._file_digest", count_digest)
    source = DarwinDumpedSource(tmp_path, cache_path=cache)
    source.refresh_index()
    initial_calls = calls
    source.refresh_index()
    assert initial_calls == 4
    assert calls == initial_calls

    acpi_path = tmp_path / "MacPro/MacPro7,1/ACPI Tables/DSDT.aml"
    acpi_path.write_bytes(b"new-acpi")
    stat = acpi_path.stat()
    os.utime(acpi_path, ns=(stat.st_atime_ns, stat.st_mtime_ns + 1_000_000))
    source.refresh_index()
    assert calls == initial_calls + 1
    artifact = next(
        item
        for item in source.get_artifacts("MacPro7,1")
        if item.artifact_class is ArtifactClass.ACPI
    )
    assert artifact.content_sha256 == hashlib.sha256(b"new-acpi").hexdigest()


def test_index_cache_must_be_outside_source_checkout(tmp_path: Path) -> None:
    _fixture(tmp_path)
    with pytest.raises(ValueError, match="outside the source checkout"):
        DarwinDumpedSource(tmp_path, cache_path=tmp_path / "index.json")


def test_artifact_hashes_and_provenance_are_stable(tmp_path: Path) -> None:
    _fixture(tmp_path)
    source = DarwinDumpedSource(tmp_path)
    artifact = next(
        item
        for item in source.get_artifacts("MacPro7,1")
        if item.artifact_class is ArtifactClass.ACPI
    )

    assert artifact.content_sha256 == hashlib.sha256(b"raw-acpi").hexdigest()
    assert artifact.provenance.source == "possible947/DarwinDumped"
    assert artifact.provenance.revision == "working-tree"
    assert artifact.provenance.reference_id == "MacPro7,1"
    assert artifact.provenance.source_locator == "MacPro/MacPro7,1/ACPI Tables/DSDT.aml"
    assert artifact.provenance.content_sha256 == artifact.content_sha256
    assert artifact.size_bytes == len(b"raw-acpi")
    assert ReferenceArtifact.model_validate_json(artifact.model_dump_json()) == artifact


def test_adapter_does_not_index_symlinked_reference_directories(tmp_path: Path) -> None:
    root = tmp_path / "source"
    outside = tmp_path / "outside"
    _write(root, "Family/Model/file.bin", b"inside")
    _write(outside, "OtherModel/file.bin", b"outside")
    (root / "LinkedFamily").symlink_to(outside, target_is_directory=True)
    (root / "Family" / "LinkedModel").symlink_to(
        outside / "OtherModel", target_is_directory=True
    )
    source = DarwinDumpedSource(root)

    with pytest.raises(ValueError, match="reference is not available"):
        source.get_artifacts("LinkedModel")
    with pytest.raises(ValueError, match="reference is not available"):
        source.get_artifacts("OtherModel")
    assert source.get_artifacts("Model")[0].provenance.source_locator == "Family/Model/file.bin"


def test_snapshot_materialization_is_bounded_hash_verified_and_idempotent(
    tmp_path: Path,
) -> None:
    source_root = tmp_path / "DarwinDumped"
    _fixture(source_root)
    source = DarwinDumpedSource(source_root)
    workspace = tmp_path / "workspace"

    snapshot = source.materialize_snapshot(
        "MacPro7,1",
        workspace,
        (ArtifactClass.ACPI, ArtifactClass.PCI),
        max_artifacts=2,
        max_bytes_per_artifact=8,
    )

    assert snapshot.reference_id == "MacPro7,1"
    assert snapshot.omitted_artifact_count == 1
    assert len(snapshot.artifacts) == 1
    artifact = snapshot.artifacts[0]
    assert artifact.artifact_class is ArtifactClass.ACPI
    assert source.read_excerpt(artifact, 16) == (b"raw-acpi", False)
    assert (snapshot.path / "artifacts" / artifact.artifact_id).read_bytes() == b"raw-acpi"
    assert (snapshot.path / "manifest.json").is_file()
    manifest = json.loads((snapshot.path / "manifest.json").read_text())
    assert manifest["artifacts"][0]["provenance"] == artifact.provenance.model_dump()
    assert artifact.provenance.source_locator == "MacPro/MacPro7,1/ACPI Tables/DSDT.aml"
    assert snapshot.omitted_size_count == 1
    assert snapshot.omitted_count_limit_count == 0
    assert source.materialize_snapshot(
        "MacPro7,1",
        workspace,
        (ArtifactClass.ACPI, ArtifactClass.PCI),
        max_artifacts=2,
        max_bytes_per_artifact=8,
    ) == snapshot


def test_snapshot_artifact_count_limit_and_external_workspace(tmp_path: Path) -> None:
    source_root = tmp_path / "DarwinDumped"
    _fixture(source_root)
    source = DarwinDumpedSource(source_root)

    snapshot = source.materialize_snapshot(
        "MacPro7,1",
        tmp_path / "cache",
        max_artifacts=1,
        max_bytes_per_artifact=1024,
    )
    assert len(snapshot.artifacts) == 1
    assert snapshot.omitted_artifact_count == 1
    assert snapshot.omitted_size_count == 0
    assert snapshot.omitted_count_limit_count == 1
    with pytest.raises(ValueError, match="outside the source checkout"):
        source.materialize_snapshot("MacPro7,1", source_root / "snapshots")


def test_snapshot_filters_size_before_count_and_accounts_for_omissions(tmp_path: Path) -> None:
    root = tmp_path / "source"
    _write(root, "Family/Model/a.bin", b"oversized")
    _write(root, "Family/Model/b.bin", b"b")
    _write(root, "Family/Model/c.bin", b"c")
    _write(root, "Family/Model/d.bin", b"d")
    _write(root, "Family/Model/e.bin", b"oversized")
    source = DarwinDumpedSource(root)
    snapshot = source.materialize_snapshot(
        "Model", tmp_path / "snapshots", max_artifacts=2, max_bytes_per_artifact=1,
    )
    assert [a.provenance.source_locator for a in snapshot.artifacts] == [
        "Family/Model/b.bin", "Family/Model/c.bin",
    ]
    assert snapshot.omitted_artifact_count == 3
    assert snapshot.omitted_size_count == 2
    assert snapshot.omitted_count_limit_count == 1
    manifest = json.loads((snapshot.path / "manifest.json").read_text())
    assert manifest["omitted_artifact_count"] == 3
    assert manifest["omitted_size_count"] == 2
    assert manifest["omitted_count_limit_count"] == 1
    assert source.materialize_snapshot(
        "Model", tmp_path / "snapshots", max_artifacts=2, max_bytes_per_artifact=1,
    ) == snapshot


def test_stale_stat_cache_never_accepts_same_size_changed_bytes(tmp_path: Path) -> None:
    root = tmp_path / "source"
    path = _write(root, "Family/Model/file.bin", b"original")
    cache = tmp_path / "index.json"
    source = DarwinDumpedSource(root, cache_path=cache)
    artifact = source.get_artifacts("Model")[0]
    snapshot = source.materialize_snapshot("Model", tmp_path / "snapshots")
    stat = path.stat()
    path.write_bytes(b"modified")
    os.utime(path, ns=(stat.st_atime_ns, stat.st_mtime_ns))
    source.refresh_index()
    assert source.get_artifacts("Model")[0].content_sha256 == artifact.content_sha256
    with pytest.raises(ValueError, match="changed since indexing"):
        source.read_excerpt(artifact, 4)
    with pytest.raises(ValueError, match="changed since indexing"):
        source.materialize_snapshot("Model", tmp_path / "snapshots")
    with pytest.raises(ValueError, match="changed since indexing"):
        source.materialize_snapshot("Model", tmp_path / "new-snapshots")
    assert (snapshot.path / "artifacts" / artifact.artifact_id).read_bytes() == b"original"


def test_reference_evidence_cannot_be_observed_target() -> None:
    with pytest.raises(ValidationError, match="reference-platform evidence"):
        EvidenceRecord.model_validate({
            "identifier": "reference",
            "kind": EvidenceKind.REFERENCE_PLATFORM,
            "evidence_class": EvidenceClass.OBSERVED_TARGET,
            "provenance": {"source": "synthetic-reference", "reference": "fixture"},
            "summary": "Reference evidence",
        })


def test_changed_artifact_is_rejected_after_indexing(tmp_path: Path) -> None:
    _fixture(tmp_path)
    source = DarwinDumpedSource(tmp_path)
    artifact = next(
        item
        for item in source.get_artifacts("MacPro7,1")
        if item.artifact_class is ArtifactClass.PCI
    )
    _write(tmp_path, "MacPro/MacPro7,1/LSPCI/lspci.txt", b"tampered")

    with pytest.raises(ValueError, match="changed since indexing"):
        source.read_excerpt(artifact, 4)


def test_source_revision_is_pinned_until_explicit_refresh(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    _fixture(tmp_path)
    revision = "first-revision"

    def current_revision(_: Path) -> str:
        return revision

    monkeypatch.setattr("platform_compiler.reference.indexer._revision", current_revision)
    monkeypatch.setattr("platform_compiler.reference.darwin_dumped._revision", current_revision)
    source = DarwinDumpedSource(tmp_path)
    pinned_revision = source.get_artifacts("MacPro7,1")[0].provenance.revision
    revision = "second-revision"

    with pytest.raises(ValueError, match="revision changed"):
        source.get_artifacts("MacPro7,1")
    source.refresh_index()
    assert source.get_artifacts("MacPro7,1")[0].provenance.revision != pinned_revision


def test_local_source_configuration_operates_offline(
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
    assert source.get_artifacts("MacPro7,1")

    with pytest.raises(ValidationError):
        DarwinDumpedConfig.model_validate(
            {
                "enabled": True,
                "local_path": str(tmp_path),
                "network_runtime_access": True,
            }
        )
    assert create_darwin_dumped_source(DarwinDumpedConfig()) is None


def test_artifacts_cannot_be_materialized_from_another_source(tmp_path: Path) -> None:
    _fixture(tmp_path)
    source = DarwinDumpedSource(tmp_path)
    artifact = source.get_artifacts("MacPro7,1")[0]
    forged = artifact.model_copy(update={"artifact_id": "forged"})

    with pytest.raises(ValueError, match="does not belong"):
        source.read_excerpt(forged, 16)
