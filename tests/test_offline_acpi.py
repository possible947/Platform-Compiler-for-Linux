from __future__ import annotations

import hashlib
import json
import os
import shutil
import stat
import sys
from pathlib import Path

import pytest
from pydantic import ValidationError

from platform_compiler.acpi import (
    ACPIDisassembly,
    DerivationStatus,
    Publication,
    ToolUnavailable,
    disassemble_snapshot,
    load_derivation,
    resolve_iasl,
    select_definition_blocks,
)
from platform_compiler.acpi.models import ExclusionReason
from platform_compiler.cli import main
from platform_compiler.evidence.models import (
    DerivedArtifact,
    EvidenceClass,
    SourceCapture,
    ToolInvocation,
)
from platform_compiler.snapshot import collect_snapshot
from platform_compiler.snapshot.collectors import ACPICollector, PCICollector
from platform_compiler.snapshot.models import PCITopology
from platform_compiler.snapshot.query import (
    pci_device,
    pci_devices_on_node,
    pci_upstream_path,
)
from platform_compiler.snapshot.reader import CollectionContext, KernelReader
from platform_compiler.snapshot.store import open_snapshot
from platform_compiler.workspace import Workspace

SNAPSHOT_ID = "fixture-snapshot"


def _write(root: Path, relative: str, content: str | bytes) -> Path:
    path = root / relative
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(content.encode("ascii") if isinstance(content, str) else content)
    return path


def _table(signature: bytes, body: bytes, table_id: bytes = b"TABLEID\x00") -> bytes:
    length = 36 + len(body)
    return (
        signature + length.to_bytes(4, "little") + b"\x02\x00" + b"OEMID\x00"
        + table_id + (1).to_bytes(4, "little") + b"INTL"
        + (0x20200925).to_bytes(4, "little") + body
    )


def _pci(sysfs: Path, path: str, node: int) -> None:
    device = sysfs / "devices" / path
    for field, value in {
        "vendor": "0x8086", "device": "0x1234", "class": "0x060400",
        "numa_node": str(node), "local_cpulist": "0",
        "resource": "0x0 0x0 0x0\n", "power/control": "on",
        "power/runtime_status": "active",
    }.items():
        _write(device, field, value)
    links = sysfs / "bus/pci/devices"
    links.mkdir(parents=True, exist_ok=True)
    (links / device.name).symlink_to(device, target_is_directory=True)


def _interfaces(tmp_path: Path, deny: str | None = None) -> CollectionContext:
    proc = tmp_path / "interfaces" / "proc"
    sysfs = tmp_path / "interfaces" / "sys"
    proc.mkdir(parents=True)
    _pci(sysfs, "pci0000:00/0000:00:01.0", 0)
    _pci(sysfs, "pci0000:00/0000:00:01.0/0000:01:00.0", 0)
    _pci(sysfs, "pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0", 0)
    _pci(sysfs, "pci0000:80/0000:80:00.0", 1)
    tables = sysfs / "firmware/acpi/tables"
    _write(tables, "DSDT", _table(b"DSDT", b"\x08ENTK\x0a\x01"))
    _write(tables, "SSDT1", _table(b"SSDT", b"\x10SSDT1"))
    _write(tables, "SSDT2", _table(b"SSDT", b"\x10SSDT2"))
    _write(tables, "SSDT10", _table(b"SSDT", b"\x10SSDT10"))
    _write(tables, "OEM1", _table(b"OEM1", b"\x10OEM", b"CPU EIST"))
    _write(tables, "APIC", _table(b"APIC", b"\x00\x00\xe0\xfe"))
    _write(tables, "FACS", b"FACS" + (64).to_bytes(4, "little") + bytes(56))
    _write(tables, "dynamic/SSDT3", _table(b"SSDT", b"\x10DYN"))
    reader = KernelReader(proc, sysfs)
    if deny is not None:
        read = reader.read

        def denied(interface: str) -> bytes:
            if interface.endswith("/" + deny):
                raise PermissionError("denied")
            return read(interface)

        reader.read = denied  # type: ignore[method-assign]
    return CollectionContext(reader, "fixture64")


def _snapshot(tmp_path: Path, deny: str | None = None) -> tuple[Workspace, Path]:
    workspace = Workspace.initialize(tmp_path / "workspace")
    _, path = collect_snapshot(
        workspace, context=_interfaces(tmp_path, deny),
        collectors=(PCICollector(), ACPICollector()), snapshot_id=SNAPSHOT_ID,
    )
    return workspace, path


@pytest.fixture
def stored(tmp_path: Path) -> tuple[Workspace, Path]:
    return _snapshot(tmp_path)


def _fake_iasl(tmp_path: Path, mode: str = "ok") -> Path:
    log = tmp_path / "iasl-calls.jsonl"
    script = tmp_path / "toolchain" / "iasl"
    script.parent.mkdir(exist_ok=True)
    script.write_text(f"""#!{sys.executable}
import hashlib, json, os, sys, uuid
mode = {mode!r}
if sys.argv[1:] == ["-v"]:
    print("\\nIntel ACPI Component Architecture")
    print("ASL+ Optimizing Compiler/Disassembler version 20991231")
    sys.exit(0)
with open({str(log)!r}, "a") as log:
    log.write(json.dumps({{"argv": sys.argv, "cwd": os.getcwd(),
                           "env": dict(os.environ)}}) + "\\n")
assert sys.argv[1] == "-da"
names = sys.argv[2:]
if mode == "slow":
    import time
    time.sleep(30)
if mode == "modify":
    open(names[0], "ab").write(b"X")
for index, name in enumerate(names):
    if mode == "fail" and index > 0:
        break
    data = open(name, "rb").read()
    text = "/* Disassembly of " + name + " */\\n// joint " + " ".join(names) + "\\n"
    text += "// " + hashlib.sha256(data).hexdigest() + "\\n"
    if mode == "random":
        text += "// " + uuid.uuid4().hex + "\\n"
    open(name.rsplit(".", 1)[0] + ".dsl", "w").write(text)
print("Disassembly completed")
if mode == "fail":
    print("Firmware Error (ACPI): AE_ALREADY_EXISTS", file=sys.stderr)
    sys.exit(255)
""")
    script.chmod(0o755)
    return script


def _calls(tmp_path: Path) -> list[dict]:
    log = tmp_path / "iasl-calls.jsonl"
    return [json.loads(line) for line in log.read_text().splitlines()] if log.exists() else []


def _tree(path: Path) -> dict[str, tuple]:
    result = {}
    for item in sorted(path.rglob("*")):
        info = item.lstat()
        result[item.relative_to(path).as_posix()] = (
            stat.S_IMODE(info.st_mode), info.st_size, info.st_mtime_ns,
            hashlib.sha256(item.read_bytes()).hexdigest() if item.is_file() else None,
        )
    return result


def _edit_manifest(path: Path, change) -> None:
    manifest = path / "manifest.json"
    data = json.loads(manifest.read_text())
    change(data)
    manifest.write_text(json.dumps(data))


def _acpi(data: dict) -> dict:
    return next(c for c in data["collectors"] if c["name"] == "acpi")


# Stored snapshot access


def test_open_snapshot_resolves_verified_captures(stored: tuple[Workspace, Path]) -> None:
    workspace, path = stored
    before = _tree(path)
    snapshot = open_snapshot(workspace, SNAPSHOT_ID)
    manifest = (path / "manifest.json").read_bytes()
    assert snapshot.manifest_sha256 == hashlib.sha256(manifest).hexdigest()
    assert snapshot.verify() == sum(1 for c in snapshot.captures() if c.raw_path)
    dsdt = next(c for c in snapshot.captures() if c.provenance.reference.endswith("/DSDT"))
    expected = (tmp := path.parent.parent.parent / "interfaces/sys/firmware/acpi/tables/DSDT")
    assert snapshot.read_capture(dsdt.capture_id) == tmp.read_bytes() == expected.read_bytes()
    with pytest.raises(ValueError, match="unknown capture"):
        snapshot.read_capture("acpi-99999")
    assert _tree(path) == before


@pytest.mark.parametrize("raw_path", ["/etc/passwd", "raw/../manifest.json", "../raw/x.bin",
                                      "raw/sub/x.bin", "raw/.."])
def test_open_snapshot_rejects_escaping_raw_paths(
    stored: tuple[Workspace, Path], raw_path: str,
) -> None:
    workspace, path = stored
    _edit_manifest(path, lambda d: _acpi(d)["captures"][1].update(raw_path=raw_path))
    with pytest.raises(ValueError, match="escapes raw evidence"):
        open_snapshot(workspace, SNAPSHOT_ID)


def test_read_capture_rejects_symlinked_raw_evidence(
    tmp_path: Path, stored: tuple[Workspace, Path],
) -> None:
    workspace, path = stored
    snapshot = open_snapshot(workspace, SNAPSHOT_ID)
    capture = next(c for c in snapshot.captures() if c.provenance.reference.endswith("/DSDT"))
    target = path / capture.raw_path
    outside = tmp_path / "outside.bin"
    outside.write_bytes(target.read_bytes())
    target.unlink()
    target.symlink_to(outside)
    with pytest.raises(ValueError, match="escapes raw evidence"):
        snapshot.read_capture(capture.capture_id)
    target.unlink()
    shutil.move(path / "raw", tmp_path / "moved-raw")
    (path / "raw").symlink_to(tmp_path / "moved-raw", target_is_directory=True)
    with pytest.raises(ValueError, match="not a directory"):
        snapshot.read_capture(capture.capture_id)


def test_open_snapshot_rejects_symlinked_snapshot_or_manifest(
    tmp_path: Path, stored: tuple[Workspace, Path],
) -> None:
    workspace, path = stored
    (path.parent / "alias").symlink_to(path, target_is_directory=True)
    with pytest.raises(ValueError, match="not a directory"):
        open_snapshot(workspace, "alias")
    moved = tmp_path / "manifest.json"
    shutil.move(path / "manifest.json", moved)
    (path / "manifest.json").symlink_to(moved)
    with pytest.raises(ValueError, match="unreadable"):
        open_snapshot(workspace, SNAPSHOT_ID)


@pytest.mark.parametrize("snapshot_id", ["../workspace", "a/b", "", ".hidden"])
def test_open_snapshot_rejects_invalid_identifiers(
    stored: tuple[Workspace, Path], snapshot_id: str,
) -> None:
    with pytest.raises(ValueError, match="invalid snapshot identifier"):
        open_snapshot(stored[0], snapshot_id)


def test_open_snapshot_rejects_duplicate_ids_and_hash_disagreement(
    stored: tuple[Workspace, Path],
) -> None:
    workspace, path = stored
    original = (path / "manifest.json").read_text()

    def duplicate(data: dict) -> None:
        captures = _acpi(data)["captures"]
        captures[2]["capture_id"] = captures[1]["capture_id"]

    _edit_manifest(path, duplicate)
    with pytest.raises(ValueError, match="duplicate capture identifier"):
        open_snapshot(workspace, SNAPSHOT_ID)
    (path / "manifest.json").write_text(original)
    _edit_manifest(path, lambda d: _acpi(d)["captures"][1]["provenance"].update(sha256="0" * 64))
    with pytest.raises(ValueError, match="hashes disagree"):
        open_snapshot(workspace, SNAPSHOT_ID)


@pytest.mark.parametrize("capture_id", ["../../../escape", "/tmp/escape", "acpi/00001", ""])
def test_open_snapshot_rejects_path_like_capture_ids(
    stored: tuple[Workspace, Path], capture_id: str,
) -> None:
    workspace, path = stored

    def rename(data: dict) -> None:
        _acpi(data)["captures"][1]["capture_id"] = capture_id

    _edit_manifest(path, rename)
    with pytest.raises(ValueError, match="invalid capture identifier"):
        open_snapshot(workspace, SNAPSHOT_ID)


def test_capture_content_mismatch_is_detected_before_returning_bytes(
    stored: tuple[Workspace, Path],
) -> None:
    workspace, path = stored
    snapshot = open_snapshot(workspace, SNAPSHOT_ID)
    capture = next(c for c in snapshot.captures() if c.provenance.reference.endswith("/DSDT"))
    raw = path / capture.raw_path
    raw.chmod(0o600)
    content = bytearray(raw.read_bytes())
    content[-1] ^= 0xFF
    raw.write_bytes(bytes(content))
    with pytest.raises(ValueError, match="integrity"):
        snapshot.read_capture(capture.capture_id)
    raw.write_bytes(bytes(content) + b"extra")
    with pytest.raises(ValueError, match="expected size"):
        snapshot.read_capture(capture.capture_id)


def test_open_snapshot_rejects_schema_incomplete_and_mismatched_snapshots(
    stored: tuple[Workspace, Path],
) -> None:
    workspace, path = stored
    original = (path / "manifest.json").read_text()
    _edit_manifest(path, lambda d: d.update(schema_version=2))
    with pytest.raises(ValueError, match="unsupported schema"):
        open_snapshot(workspace, SNAPSHOT_ID)
    (path / "manifest.json").write_text(original)
    _edit_manifest(path, lambda d: d.update(snapshot_id="other"))
    with pytest.raises(ValueError, match="does not match"):
        open_snapshot(workspace, SNAPSHOT_ID)
    (path / "manifest.json").unlink()
    with pytest.raises(ValueError, match="incomplete"):
        open_snapshot(workspace, SNAPSHOT_ID)
    with pytest.raises(ValueError, match="does not exist"):
        open_snapshot(workspace, "missing")


def test_unsuccessful_capture_has_no_raw_evidence(tmp_path: Path) -> None:
    workspace, _ = _snapshot(tmp_path, deny="SSDT2")
    snapshot = open_snapshot(workspace, SNAPSHOT_ID)
    denied = next(c for c in snapshot.captures() if c.provenance.reference.endswith("/SSDT2"))
    with pytest.raises(ValueError, match="permission_denied"):
        snapshot.read_capture(denied.capture_id)


# PCI query helpers


def test_pci_lookup_upstream_path_and_numa_filter(stored: tuple[Workspace, Path]) -> None:
    pci = open_snapshot(stored[0], SNAPSHOT_ID).observation(PCITopology)
    assert pci_device(pci, "0000:02:00.0").bdf == "0000:02:00.0"
    assert pci_device(pci, "0000:02:00.0") == pci_device(pci, "0000:02:00.0".upper())
    assert pci_device(pci, "0000:09:00.0") is None
    path = pci_upstream_path(pci, "0000:02:00.0")
    assert [d.bdf for d in path] == ["0000:02:00.0", "0000:01:00.0", "0000:00:01.0"]
    assert path[-1].parent_path == "/sys/devices/pci0000:00"
    assert [d.bdf for d in pci_upstream_path(pci, "0000:80:00.0")] == ["0000:80:00.0"]
    assert [d.bdf for d in pci_devices_on_node(pci, 1)] == ["0000:80:00.0"]
    assert len(pci_devices_on_node(pci, 0)) == 3
    assert pci_devices_on_node(pci, 7) == ()
    with pytest.raises(ValueError, match="not observed"):
        pci_upstream_path(pci, "0000:09:00.0")


# Definition-block selection


def test_definition_blocks_are_selected_by_signature_and_others_accounted(
    stored: tuple[Workspace, Path],
) -> None:
    inputs, excluded = select_definition_blocks(open_snapshot(stored[0], SNAPSHOT_ID))
    assert [b.table_name for b in inputs] == ["DSDT", "SSDT1", "SSDT2", "SSDT10"]
    assert all(b.staged_name == f"{b.capture_id}.dat" for b in inputs)
    reasons = {t.table_name: t.reason for t in excluded}
    assert reasons == {
        "APIC": ExclusionReason.NOT_A_BOOT_DEFINITION_BLOCK,
        "FACS": ExclusionReason.NOT_A_BOOT_DEFINITION_BLOCK,
        "OEM1": ExclusionReason.OEM_SPECIFIC_TABLE_DEFERRED,
        "SSDT3": ExclusionReason.DYNAMIC_DEFINITION_BLOCK_DEFERRED,
    }
    oem = next(t for t in excluded if t.table_name == "OEM1")
    assert oem.signature == "OEM1" and oem.content_sha256


@pytest.mark.parametrize("denied", ["DSDT", "SSDT2"])
def test_unavailable_required_definition_block_refuses_derivation(
    tmp_path: Path, denied: str,
) -> None:
    workspace, path = _snapshot(tmp_path, deny=denied)
    iasl = _fake_iasl(tmp_path)
    with pytest.raises(ValueError, match=f"{denied} is unavailable"):
        disassemble_snapshot(workspace, SNAPSHOT_ID, iasl=iasl)
    assert _calls(tmp_path) == []
    assert not (workspace.config.path / "derived").exists()


# Tool resolution and invocation contract


def test_iasl_resolution_order_and_missing_tool(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch,
) -> None:
    script = _fake_iasl(tmp_path)
    assert resolve_iasl(script.parent).path == script.resolve()
    assert resolve_iasl(script).version == "20991231"
    monkeypatch.setenv("PATH", str(script.parent))
    assert resolve_iasl().path == script.resolve()
    monkeypatch.setenv("PATH", str(tmp_path / "empty"))
    with pytest.raises(ToolUnavailable, match="not found on PATH"):
        resolve_iasl()
    with pytest.raises(ToolUnavailable, match="not an executable"):
        resolve_iasl(tmp_path / "missing-iasl")


def test_joint_disassembly_invocation_contract_and_provenance(
    tmp_path: Path, stored: tuple[Workspace, Path],
) -> None:
    workspace, snapshot_path = stored
    before = _tree(snapshot_path)
    iasl = _fake_iasl(tmp_path)
    outcome = disassemble_snapshot(workspace, SNAPSHOT_ID, iasl=iasl, timeout=30)
    record = outcome.record
    assert outcome.publication is Publication.PUBLISHED
    assert record.status is DerivationStatus.SUCCEEDED
    assert outcome.path == (
        workspace.config.path / "derived" / SNAPSHOT_ID / "acpi-disassembly"
        / record.derivation_id
    )
    [call] = _calls(tmp_path)
    names = [b.staged_name for b in record.inputs]
    assert call["argv"] == [str(iasl.resolve()), "-da", *names]
    assert call["env"].get("LC_ALL") == "C" and "PATH" not in call["env"]
    assert not Path(call["cwd"]).exists()
    invocation = record.invocation
    assert invocation.argv == (str(iasl.resolve()), "-da", *names)
    assert invocation.executable_sha256 == hashlib.sha256(iasl.read_bytes()).hexdigest()
    assert (invocation.version, invocation.exit_status, invocation.timed_out) == (
        "20991231", 0, False,
    )
    assert invocation.environment == {"LC_ALL": "C"}
    stdout = (outcome.path / "tool/stdout.txt").read_bytes()
    assert invocation.stdout_sha256 == hashlib.sha256(stdout).hexdigest() == record.stdout.sha256
    snapshot = open_snapshot(workspace, SNAPSHOT_ID)
    assert record.snapshot_manifest_sha256 == snapshot.manifest_sha256
    assert len(record.artifacts) == len(record.inputs) == 4
    for block, artifact in zip(record.inputs, record.artifacts):
        content = (outcome.path / artifact.artifact_path).read_bytes()
        assert artifact.artifact_path == f"outputs/{block.capture_id}.dsl"
        assert artifact.content_sha256 == hashlib.sha256(content).hexdigest()
        assert block.content_sha256.encode() in content
        assert artifact.subject_capture_id == block.capture_id
        assert [s.capture_id for s in artifact.derived_from] == [b.capture_id for b in record.inputs]
        assert artifact.derived_by == invocation
        assert artifact.source_evidence_class is EvidenceClass.OBSERVED_TARGET
    assert sorted(p.name for p in outcome.path.iterdir()) == ["derivation.json", "outputs", "tool"]
    assert not list(outcome.path.rglob("*.dat"))
    assert load_derivation(outcome.path) == record
    assert _tree(snapshot_path) == before


def test_derivation_identity_excludes_results_and_reruns_are_idempotent(
    tmp_path: Path, stored: tuple[Workspace, Path],
) -> None:
    workspace, snapshot_path = stored
    before = _tree(snapshot_path)
    iasl = _fake_iasl(tmp_path)
    first = disassemble_snapshot(workspace, SNAPSHOT_ID, iasl=iasl)
    published = _tree(first.path)
    second = disassemble_snapshot(workspace, SNAPSHOT_ID, iasl=iasl)
    assert second.publication is Publication.REPRODUCED
    assert second.record == first.record and second.path == first.path
    assert _tree(first.path) == published
    assert len(_calls(tmp_path)) == 2
    assert [p.name for p in first.path.parent.iterdir()] == [first.record.derivation_id]

    random = _fake_iasl(tmp_path, "random")
    assert random == iasl
    changed = disassemble_snapshot(workspace, SNAPSHOT_ID, iasl=random)
    assert changed.record.derivation_id != first.record.derivation_id
    again = disassemble_snapshot(workspace, SNAPSHOT_ID, iasl=random)
    assert again.publication is Publication.NONDETERMINISTIC
    assert again.record == changed.record
    assert again.differing_attempt.name.startswith(changed.record.derivation_id + ".attempt-")
    assert load_derivation(again.differing_attempt).artifacts != changed.record.artifacts
    assert _tree(snapshot_path) == before
    assert not [p for p in first.path.parent.iterdir() if p.name.startswith(".staging")]


def test_rerun_settings_outside_identity_do_not_imply_nondeterminism(
    tmp_path: Path, stored: tuple[Workspace, Path],
) -> None:
    workspace, _ = stored
    iasl = _fake_iasl(tmp_path)
    first = disassemble_snapshot(workspace, SNAPSHOT_ID, iasl=iasl, timeout=30)
    copy = tmp_path / "other-toolchain" / "iasl"
    copy.parent.mkdir()
    shutil.copy2(iasl, copy)
    second = disassemble_snapshot(workspace, SNAPSHOT_ID, iasl=copy, timeout=60)
    assert second.publication is Publication.REPRODUCED
    assert second.record == first.record


def test_timed_out_run_is_preserved_but_never_canonical(
    tmp_path: Path, stored: tuple[Workspace, Path],
) -> None:
    workspace, snapshot_path = stored
    before = _tree(snapshot_path)
    iasl = _fake_iasl(tmp_path, "slow")
    timed_out = disassemble_snapshot(workspace, SNAPSHOT_ID, iasl=iasl, timeout=0.5)
    record = timed_out.record
    assert timed_out.publication is Publication.TIMED_OUT
    assert record.status is DerivationStatus.FAILED and record.invocation.timed_out
    assert record.failure == "iasl timed out after 0.5 seconds"
    assert timed_out.path.name.startswith(record.derivation_id + ".timed-out-")
    assert load_derivation(timed_out.path) == record
    canonical = timed_out.path.parent / record.derivation_id
    assert not canonical.exists()
    assert _tree(snapshot_path) == before


def test_failed_joint_disassembly_preserves_diagnostics_without_fallback(
    tmp_path: Path, stored: tuple[Workspace, Path],
) -> None:
    workspace, snapshot_path = stored
    before = _tree(snapshot_path)
    outcome = disassemble_snapshot(workspace, SNAPSHOT_ID, iasl=_fake_iasl(tmp_path, "fail"))
    record = outcome.record
    assert record.status is DerivationStatus.FAILED
    assert record.failure == "iasl exited with status 255"
    assert record.artifacts == ()
    assert [d.path for d in record.diagnostics] == [f"diagnostics/{record.inputs[0].capture_id}.dsl"]
    assert b"AE_ALREADY_EXISTS" in (outcome.path / "tool/stderr.txt").read_bytes()
    assert len(_calls(tmp_path)) == 1
    assert all(call["argv"][1] == "-da" for call in _calls(tmp_path))
    assert load_derivation(outcome.path) == record
    assert _tree(snapshot_path) == before


def test_tool_that_modifies_its_input_is_rejected_without_publication(
    tmp_path: Path, stored: tuple[Workspace, Path],
) -> None:
    workspace, snapshot_path = stored
    before = _tree(snapshot_path)
    with pytest.raises(ValueError, match="modified its staged input"):
        disassemble_snapshot(workspace, SNAPSHOT_ID, iasl=_fake_iasl(tmp_path, "modify"))
    parent = workspace.config.path / "derived" / SNAPSHOT_ID / "acpi-disassembly"
    assert list(parent.iterdir()) == []
    assert _tree(snapshot_path) == before


def test_load_derivation_detects_tampering(
    tmp_path: Path, stored: tuple[Workspace, Path],
) -> None:
    outcome = disassemble_snapshot(stored[0], SNAPSHOT_ID, iasl=_fake_iasl(tmp_path))
    artifact = outcome.path / outcome.record.artifacts[0].artifact_path
    artifact.write_text("tampered")
    with pytest.raises(ValueError, match="integrity"):
        load_derivation(outcome.path)
    with pytest.raises(ValueError, match="integrity"):
        disassemble_snapshot(stored[0], SNAPSHOT_ID, iasl=_fake_iasl(tmp_path))


def test_derived_storage_rejects_symlinks(tmp_path: Path, stored: tuple[Workspace, Path]) -> None:
    workspace, _ = stored
    elsewhere = tmp_path / "elsewhere"
    elsewhere.mkdir()
    (workspace.config.path / "derived").symlink_to(elsewhere, target_is_directory=True)
    with pytest.raises(ValueError, match="symlink"):
        disassemble_snapshot(workspace, SNAPSHOT_ID, iasl=_fake_iasl(tmp_path))
    assert list(elsewhere.iterdir()) == []


# Trust boundary


def _invocation() -> ToolInvocation:
    return ToolInvocation(
        tool="iasl", executable="/opt/acpica/iasl", executable_sha256="a" * 64,
        version="20991231", argv=("/opt/acpica/iasl", "-da", "x.dat"),
        working_directory="staging", environment={"LC_ALL": "C"}, timeout_seconds=1,
        timed_out=False, exit_status=0, stdout_sha256="b" * 64, stderr_sha256="c" * 64,
    )


def test_derived_artifact_is_neither_raw_capture_nor_ai_hypothesis() -> None:
    source = SourceCapture(snapshot_id="s", capture_id="acpi-00001", content_sha256="d" * 64)
    artifact = DerivedArtifact(
        artifact_path="outputs/acpi-00001.dsl", size_bytes=1, content_sha256="e" * 64,
        derivation_id="f" * 64, subject_capture_id="acpi-00001",
        derived_from=(source,), derived_by=_invocation(),
    )
    assert DerivedArtifact.model_validate_json(artifact.model_dump_json()) == artifact
    assert artifact.source_evidence_class is EvidenceClass.OBSERVED_TARGET
    assert not hasattr(artifact, "evidence_class") and not hasattr(artifact, "confidence")
    common = dict(
        artifact_path="x", size_bytes=1, content_sha256="e" * 64, derivation_id="f" * 64,
        derived_by=_invocation(),
    )
    for invalid in (
        {"derived_from": ()},
        {"derived_from": (source,), "source_evidence_class": EvidenceClass.AI_HYPOTHESIS},
        {"derived_from": (source,), "source_evidence_class": EvidenceClass.REFERENCE_PLATFORM},
        {"derived_from": (source,), "subject_capture_id": "acpi-99999"},
        {"derived_from": (source,), "confidence": 0.9},
    ):
        with pytest.raises(ValidationError):
            DerivedArtifact(**common, **invalid)


def test_failed_derivation_record_cannot_carry_artifacts(
    tmp_path: Path, stored: tuple[Workspace, Path],
) -> None:
    record = disassemble_snapshot(stored[0], SNAPSHOT_ID, iasl=_fake_iasl(tmp_path)).record
    with pytest.raises(ValidationError):
        ACPIDisassembly.model_validate(
            record.model_dump() | {"status": "failed", "failure": "x"},
        )


# CLI


def test_cli_disassembles_by_snapshot_id(
    tmp_path: Path, stored: tuple[Workspace, Path], capsys: pytest.CaptureFixture[str],
) -> None:
    workspace = str(stored[0].config.path)
    iasl = str(_fake_iasl(tmp_path))
    assert main(["acpi", "disassemble", "--workspace", workspace,
                 "--snapshot", SNAPSHOT_ID, "--iasl", iasl]) == 0
    output = capsys.readouterr().out
    assert "Publication: published" in output and "Status: succeeded" in output
    assert "Inputs: DSDT, SSDT1, SSDT2, SSDT10" in output
    assert main(["acpi", "disassemble", "--workspace", workspace,
                 "--snapshot", SNAPSHOT_ID, "--iasl", iasl]) == 0
    assert "Publication: reproduced" in capsys.readouterr().out
    assert main(["acpi", "disassemble", "--workspace", workspace, "--snapshot",
                 SNAPSHOT_ID, "--iasl", str(_fake_iasl(tmp_path, "fail"))]) == 1
    assert "iasl exited with status 255" in capsys.readouterr().out
    with pytest.raises(SystemExit) as error:
        main(["acpi", "disassemble", "--workspace", workspace, "--snapshot", SNAPSHOT_ID,
              "--iasl", str(tmp_path / "missing")])
    assert error.value.code == 2


# Opt-in real snapshot integration


_REAL_WORKSPACE = os.environ.get("PLATFORM_COMPILER_REAL_WORKSPACE")
_REAL_SNAPSHOT = os.environ.get("PLATFORM_COMPILER_REAL_SNAPSHOT")


@pytest.mark.skipif(
    not (_REAL_WORKSPACE and _REAL_SNAPSHOT),
    reason="set PLATFORM_COMPILER_REAL_WORKSPACE and PLATFORM_COMPILER_REAL_SNAPSHOT",
)
def test_real_root_snapshot_joint_disassembly() -> None:
    from platform_compiler.snapshot.models import (
        ACPIInventory,
        CPUTopology,
        KernelEnvironment,
        NUMATopology,
    )

    workspace = Workspace.open(Path(_REAL_WORKSPACE).expanduser())
    snapshot_path = workspace.config.path / "snapshots" / _REAL_SNAPSHOT
    before = _tree(snapshot_path)
    stored_snapshot = open_snapshot(workspace, _REAL_SNAPSHOT)
    assert stored_snapshot.snapshot.status.value == "success"
    assert stored_snapshot.verify() == sum(
        1 for c in stored_snapshot.captures() if c.raw_path
    )
    cpu = stored_snapshot.observation(CPUTopology)
    assert len(cpu.cpus) == 80
    assert len({(c.package_id, c.core_id) for c in cpu.cpus}) == 40
    assert len({c.package_id for c in cpu.cpus}) == 2
    assert len(stored_snapshot.observation(NUMATopology).nodes) == 2
    pci = stored_snapshot.observation(PCITopology)
    assert len(pci.devices) == 302
    assert [d.bdf for d in pci_upstream_path(pci, "0000:b1:00.0")] == [
        "0000:b1:00.0", "0000:b0:00.0", "0000:af:00.0", "0000:ae:00.0",
    ]
    assert len(stored_snapshot.observation(ACPIInventory).tables) == 34
    assert stored_snapshot.observation(KernelEnvironment).release

    inputs, excluded = select_definition_blocks(stored_snapshot)
    assert [b.table_name for b in inputs] == ["DSDT", "SSDT1", "SSDT2", "SSDT3", "SSDT4"]
    assert {t.table_name for t in excluded
            if t.reason is ExclusionReason.OEM_SPECIFIC_TABLE_DEFERRED} == {
        "OEM1", "OEM2", "OEM4",
    }
    try:
        resolve_iasl(Path(os.environ["PLATFORM_COMPILER_IASL"])
                     if os.environ.get("PLATFORM_COMPILER_IASL") else None)
    except ToolUnavailable as error:
        pytest.skip(f"external ACPICA iasl boundary not available: {error}")
    iasl = os.environ.get("PLATFORM_COMPILER_IASL")
    first = disassemble_snapshot(
        workspace, _REAL_SNAPSHOT, iasl=Path(iasl) if iasl else None,
    )
    second = disassemble_snapshot(
        workspace, _REAL_SNAPSHOT, iasl=Path(iasl) if iasl else None,
    )
    assert first.record.derivation_id == second.record.derivation_id
    assert load_derivation(first.path) == first.record
    print(f"\nderivation {first.record.derivation_id} status={first.record.status.value} "
          f"failure={first.record.failure} first={first.publication.value} "
          f"second={second.publication.value}")
    assert second.publication in {Publication.REPRODUCED, Publication.NONDETERMINISTIC}
    if second.publication is Publication.NONDETERMINISTIC:
        print(f"nondeterministic output preserved at {second.differing_attempt}")
    assert _tree(snapshot_path) == before
