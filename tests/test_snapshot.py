from __future__ import annotations

import errno
import hashlib
import json
import os
import socket
import subprocess
import sys
from functools import partial
from pathlib import Path

import pytest
from pydantic import ValidationError

from platform_compiler.cli import main
from platform_compiler.evidence.models import EvidenceClass
from platform_compiler.snapshot import CollectionStatus, SystemSnapshot, collect_snapshot
from platform_compiler.snapshot.collectors import (
    ACPICollector,
    CPUCollector,
    IRQCollector,
    MemoryCollector,
    NUMACollector,
    PCICollector,
)
from platform_compiler.snapshot.reader import CollectionContext, KernelReader, parse_cpu_list
from platform_compiler.workspace import Workspace


def _write(root: Path, relative: str, content: str | bytes) -> Path:
    path = root / relative
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(content.encode("ascii") if isinstance(content, str) else content)
    return path


@pytest.fixture
def context(tmp_path: Path) -> CollectionContext:
    proc = tmp_path / "interfaces" / "proc"
    sysfs = tmp_path / "interfaces" / "sys"
    _write(proc, "cpuinfo", "\n\n".join(
        f"processor: {cpu}\nvendor_id: FixtureVendor\ncpu family: 6\nmodel: 85\n"
        "flags: smt sse avx\nSerial: PRIVATE_SERIAL\n"
        "Hardware: PRIVATE_HARDWARE_ID"
        for cpu in (0, 1, 2)
    ))
    _write(sysfs, "devices/system/cpu/online", "0-1\n")
    for cpu in (0, 1, 2):
        base = f"devices/system/cpu/cpu{cpu}"
        node = 0 if cpu < 2 else 2
        (sysfs / base / f"node{node}").mkdir(parents=True)
        _write(sysfs, f"{base}/topology/physical_package_id", "0" if cpu < 2 else "1")
        _write(sysfs, f"{base}/topology/core_id", "0")
        _write(sysfs, f"{base}/topology/thread_siblings_list", "0-1" if cpu < 2 else "2")
    for node in (0, 2):
        base = f"devices/system/node/node{node}"
        _write(sysfs, f"{base}/cpulist", "0-1" if node == 0 else "2")
        _write(sysfs, f"{base}/meminfo",
               f"Node {node} MemTotal: 1024 kB\nNode {node} MemFree: 512 kB\n")
        _write(sysfs, f"{base}/distance", "10 21" if node == 0 else "21 10")
    _write(proc, "meminfo", "MemTotal: 2048 kB\nMemFree: 1024 kB\n"
           "HugePages_Total: 4\nHugePages_Free: 3\nHugepagesize: 2048 kB\n")
    pci = sysfs / "devices/pci0000:00/0000:00:01.0/0000:01:00.0"
    for field, value in {
        "vendor": "0x1234", "device": "0xabcd", "class": "0x030000",
        "numa_node": "2", "local_cpulist": "2",
        "resource": "0x00001000 0x00001fff 0x00000200\n0x0 0x0 0x0\n",
        "power/control": "auto", "power/runtime_status": "suspended",
        "config": "DO_NOT_READ_PCI_CONFIG",
        "resource0": "DO_NOT_MAP_BAR",
    }.items():
        _write(pci, field, value)
    devices = sysfs / "bus/pci/devices"
    devices.mkdir(parents=True)
    (devices / "0000:01:00.0").symlink_to(pci, target_is_directory=True)
    driver = sysfs / "bus/pci/drivers/fixture_driver"
    driver.mkdir(parents=True)
    (pci / "driver").symlink_to(driver, target_is_directory=True)
    _write(proc, "interrupts", "           CPU0       CPU1\n"
           " 24:          1          2   PCI-MSI fixture_irq\n")
    tables = sysfs / "firmware/acpi/tables"
    (tables / "dynamic").mkdir(parents=True)
    header = b"APIC" + (44).to_bytes(4, "little") + b"\x01\xab"
    _write(tables, "APIC", header + b"PRIVATE_OEM_HEADER".ljust(26, b"_") + bytes(8))
    _write(tables, "DSDT", b"PRIVATE_AML_SERIAL")
    _write(tables, "MSDM", b"PRIVATE_LICENSE_KEY")
    _write(proc, "sys/kernel/osrelease", "6.12-fixture")
    _write(proc, "sys/kernel/version", "#1 SMP fixture-build")
    _write(proc, "cmdline", "ro quiet numa_balancing=0 root=UUID=PRIVATE_UUID "
           "password=PRIVATE_PASSWORD username=PRIVATE_USER hostname=PRIVATE_HOST "
           "ip=PRIVATE_MAC api_key=PRIVATE_API_KEY unknown-bare-secret\n")
    for path in ("sys/kernel/hostname", "sys/kernel/random/boot_id", "version",
                 "self/environ", "self/status"):
        _write(proc, path, "PRIVATE_DO_NOT_COLLECT")
    _write(sysfs, "class/net/eth0/address", "PRIVATE_MAC")
    _write(sysfs, "class/dmi/id/product_serial", "PRIVATE_SERIAL")
    return CollectionContext(KernelReader(proc, sysfs), "fixture64")


def _workspace(tmp_path: Path) -> Workspace:
    return Workspace.initialize(tmp_path / "workspace")


def test_cpu_topology_retains_linux_ids_and_relationships(context: CollectionContext) -> None:
    result = CPUCollector().collect(context)
    assert result.status == CollectionStatus.SUCCESS
    topology = result.observations
    assert topology.architecture == "fixture64"
    assert topology.online_cpu_ids == (0, 1)
    assert [cpu.cpu_id for cpu in topology.cpus] == [0, 1, 2]
    assert [cpu.online for cpu in topology.cpus] == [True, True, False]
    assert topology.cpus[0].package_id == 0
    assert topology.cpus[0].core_id == 0
    assert topology.cpus[0].thread_siblings == (0, 1)
    assert topology.cpus[2].package_id == 1
    assert topology.cpus[2].numa_nodes == (2,)
    assert topology.cpus[0].identity == {
        "vendor_id": "FixtureVendor", "cpu family": "6", "model": "85",
    }
    assert topology.cpus[0].flags == ("avx", "smt", "sse")


@pytest.mark.parametrize("value", ["3-1", "-1", "x", "1--2", "0-999999999"])
def test_cpu_list_rejects_malformed_or_unbounded_ranges(value: str) -> None:
    with pytest.raises(ValueError):
        parse_cpu_list(value)


def test_numa_and_memory_parse_without_policy(context: CollectionContext) -> None:
    result = NUMACollector().collect(context)
    assert result.status == CollectionStatus.SUCCESS
    nodes = result.observations.nodes
    assert [node.node_id for node in nodes] == [0, 2]
    assert nodes[0].cpu_ids == (0, 1)
    assert nodes[1].cpu_ids == (2,)
    assert nodes[0].memory_kib == {"MemTotal": 1024, "MemFree": 512}
    assert nodes[0].distances == (10, 21)
    assert nodes[1].distances == (21, 10)
    memory = MemoryCollector().collect(context)
    assert memory.observations.values["MemTotal_kib"] == 2048
    assert memory.observations.values["HugePages_Total"] == 4
    assert memory.observations.values["Hugepagesize_kib"] == 2048


def test_pci_sysfs_topology_resources_and_pm_are_observations(context: CollectionContext) -> None:
    result = PCICollector().collect(context)
    assert result.status == CollectionStatus.SUCCESS
    device, = result.observations.devices
    assert device.bdf == "0000:01:00.0"
    assert (device.vendor_id, device.device_id, device.class_id) == (
        "0x1234", "0xabcd", "0x030000",
    )
    assert device.driver == "fixture_driver"
    assert device.sysfs_path == "/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0"
    assert device.parent_path == "/sys/devices/pci0000:00/0000:00:01.0"
    assert device.numa_node == 2
    assert device.local_cpu_ids == (2,)
    assert device.resources == ((0x1000, 0x1fff, 0x200), (0, 0, 0))
    assert device.runtime_pm == {"control": "auto", "runtime_status": "suspended"}


def test_malformed_fields_are_reported_without_discarding_other_observations(
    context: CollectionContext,
) -> None:
    _write(context.reader.sys_root, "devices/system/cpu/online", "not-a-cpu-list")
    cpu = CPUCollector().collect(context)
    assert cpu.status == CollectionStatus.PARTIAL
    assert cpu.observations.online_cpu_ids is None
    assert len(cpu.observations.cpus) == 3
    assert cpu.errors[0].source == "/sys/devices/system/cpu/online"
    base = "devices/pci0000:00/0000:00:01.0/0000:01:00.0"
    _write(context.reader.sys_root, f"{base}/resource", "invalid entry")
    pci = PCICollector().collect(context)
    assert pci.status == CollectionStatus.PARTIAL
    assert pci.observations.devices[0].resources is None
    assert pci.observations.devices[0].vendor_id == "0x1234"
    _write(context.reader.sys_root, "devices/system/node/node0/meminfo", "invalid")
    numa = NUMACollector().collect(context)
    assert numa.status == CollectionStatus.PARTIAL
    assert numa.observations.nodes[0].memory_kib == {}
    assert numa.observations.nodes[1].memory_kib["MemTotal"] == 1024


@pytest.mark.parametrize(
    ("error", "status"),
    [
        (FileNotFoundError(), CollectionStatus.UNAVAILABLE),
        (PermissionError(), CollectionStatus.PERMISSION_DENIED),
        (OSError(errno.EOPNOTSUPP, "unsupported"), CollectionStatus.UNSUPPORTED),
        (OSError(errno.EIO, "PRIVATE_ERROR_DETAILS"), CollectionStatus.FAILED),
    ],
)
def test_interface_failures_are_explicit(
    context: CollectionContext, monkeypatch: pytest.MonkeyPatch,
    error: OSError, status: CollectionStatus,
) -> None:
    def fail(_: str) -> bytes:
        raise error
    monkeypatch.setattr(context.reader, "read", fail)
    result = IRQCollector().collect(context)
    assert result.status == status
    capture, = result.captures
    assert capture.status == status
    assert capture.content is None and capture.content_sha256 is None
    assert "PRIVATE_ERROR_DETAILS" not in result.model_dump_json()


def test_missing_interfaces_produce_an_explicit_unusable_snapshot(tmp_path: Path) -> None:
    context = CollectionContext(KernelReader(tmp_path / "proc", tmp_path / "sys"), "fixture64")
    snapshot, path = collect_snapshot(_workspace(tmp_path), context=context)
    assert snapshot.status == CollectionStatus.FAILED
    assert len(snapshot.collectors) == 7
    assert all(result.errors for result in snapshot.collectors)
    assert (path / "manifest.json").is_file()


def test_partial_snapshot_hashes_manifest_and_privacy(
    tmp_path: Path, context: CollectionContext,
) -> None:
    snapshot, path = collect_snapshot(_workspace(tmp_path), context=context)
    assert snapshot.status == CollectionStatus.PARTIAL
    assert snapshot.evidence_class == EvidenceClass.OBSERVED_TARGET
    assert snapshot.kernel_release == "6.12-fixture"
    assert snapshot.kernel_version == "#1 SMP fixture-build"
    assert snapshot.captured_at.tzinfo is not None
    assert snapshot.finished_at >= snapshot.captured_at
    manifest = (path / "manifest.json").read_bytes()
    restored = SystemSnapshot.model_validate_json(manifest)
    assert restored.model_dump() == snapshot.model_dump()
    assert restored.provenance.reference == snapshot.snapshot_id
    persisted = []
    for result in snapshot.collectors:
        for capture in result.captures:
            assert capture.provenance.observed_at is not None
            if capture.status == CollectionStatus.SUCCESS:
                content = (path / capture.raw_path).read_bytes()
                persisted.append(content)
                assert capture.content_sha256 == hashlib.sha256(content).hexdigest()
                assert capture.provenance.sha256 == capture.content_sha256
                assert capture.size_bytes == len(content)
            else:
                assert capture.raw_path is None
                assert capture.error
    everything = manifest + b"".join(persisted)
    assert b"PRIVATE_" not in everything
    assert b"unknown-bare-secret" not in everything
    assert b"DO_NOT_READ" not in everything and b"DO_NOT_MAP" not in everything
    assert b"root=UUID" not in everything
    assert b"ro quiet numa_balancing=0" in everything
    assert str(tmp_path).encode() not in everything
    assert "hostname" not in json.loads(manifest)
    assert (path.stat().st_mode & 0o777) == 0o700
    assert ((path / "manifest.json").stat().st_mode & 0o777) == 0o600


def test_acpi_inventory_and_permission_denied_body_are_retained(
    context: CollectionContext, monkeypatch: pytest.MonkeyPatch,
) -> None:
    probe = context.reader.probe

    def denied(interface: str) -> None:
        if interface.endswith("/DSDT"):
            raise PermissionError("PRIVATE_PATH")
        probe(interface)

    monkeypatch.setattr(context.reader, "probe", denied)
    result = ACPICollector().collect(context)
    assert result.status == CollectionStatus.PARTIAL
    assert [table.name for table in result.observations.tables] == ["APIC", "DSDT", "MSDM"]
    captures = {capture.provenance.reference.rsplit("/", 1)[-1]: capture for capture in result.captures}
    assert captures["DSDT"].status == CollectionStatus.PERMISSION_DENIED
    assert captures["MSDM"].status == CollectionStatus.UNSUPPORTED
    assert captures["APIC"].content[10:36] == bytes(26)
    assert captures["APIC"].transformation == "acpi_header_identifiers_redacted"


def test_one_collector_crashing_does_not_destroy_other_results(
    tmp_path: Path, context: CollectionContext,
) -> None:
    class BrokenCollector:
        name = "broken"

        def collect(self, context: CollectionContext):
            raise RuntimeError("PRIVATE_EXCEPTION_DETAILS")

    snapshot, path = collect_snapshot(
        _workspace(tmp_path), context=context,
        collectors=(BrokenCollector(), IRQCollector()),
    )
    assert snapshot.status == CollectionStatus.PARTIAL
    assert [result.status for result in snapshot.collectors] == [
        CollectionStatus.FAILED, CollectionStatus.SUCCESS,
    ]
    assert "PRIVATE_EXCEPTION_DETAILS" not in (path / "manifest.json").read_text()


def test_completed_snapshot_cannot_be_overwritten(
    tmp_path: Path, context: CollectionContext,
) -> None:
    workspace = _workspace(tmp_path)
    snapshot, path = collect_snapshot(workspace, context=context, snapshot_id="fixed-event")
    before = {p.relative_to(path): p.read_bytes() for p in path.rglob("*") if p.is_file()}
    with pytest.raises(FileExistsError):
        collect_snapshot(workspace, context=context, snapshot_id=snapshot.snapshot_id)
    assert {p.relative_to(path): p.read_bytes() for p in path.rglob("*") if p.is_file()} == before


def test_capture_hash_disagreement_never_publishes_manifest(
    tmp_path: Path, context: CollectionContext,
) -> None:
    class CorruptCollector:
        name = "corrupt"

        def collect(self, context: CollectionContext):
            result = IRQCollector().collect(context)
            bad = result.captures[0].model_copy(update={"content": b"changed"})
            return result.model_copy(update={"captures": (bad,)})

    workspace = _workspace(tmp_path)
    with pytest.raises(ValueError, match="does not match"):
        collect_snapshot(
            workspace, context=context, collectors=(CorruptCollector(),), snapshot_id="corrupt",
        )
    assert not (workspace.config.path / "snapshots/corrupt/manifest.json").exists()


def test_manifest_publication_failure_leaves_no_completed_snapshot(
    tmp_path: Path, context: CollectionContext, monkeypatch: pytest.MonkeyPatch,
) -> None:
    def fail_link(*args, **kwargs):
        raise OSError("synthetic storage failure")

    monkeypatch.setattr("platform_compiler.snapshot.service.os.link", fail_link)
    workspace = _workspace(tmp_path)
    with pytest.raises(OSError, match="storage failure"):
        collect_snapshot(
            workspace, context=context, collectors=(IRQCollector(),), snapshot_id="incomplete",
        )
    assert not (workspace.config.path / "snapshots/incomplete/manifest.json").exists()
    with pytest.raises(FileExistsError):
        collect_snapshot(workspace, context=context, snapshot_id="incomplete")


def test_oversized_raw_interface_fails_explicitly(context: CollectionContext) -> None:
    _write(context.reader.proc_root, "interrupts", b"x" * (8 * 1024 * 1024 + 1))
    result = IRQCollector().collect(context)
    assert result.status == CollectionStatus.FAILED
    assert result.captures[0].content is None
    assert result.errors[0].message == "capture exceeds 8 MiB limit"


@pytest.mark.parametrize("identifier", ["../escape", "/absolute", "", ".", "a/b"])
def test_snapshot_identifier_cannot_escape_workspace(
    tmp_path: Path, context: CollectionContext, identifier: str,
) -> None:
    workspace = _workspace(tmp_path)
    with pytest.raises(ValueError, match="snapshot identifier"):
        collect_snapshot(workspace, context=context, snapshot_id=identifier)
    assert list(workspace.config.path.iterdir()) == []


def test_workspace_repository_and_symlink_boundaries(
    tmp_path: Path, context: CollectionContext,
) -> None:
    repository = tmp_path / "repository"
    (repository / ".git").mkdir(parents=True)
    workspace = Workspace.initialize(repository / "workspace")
    with pytest.raises(ValueError, match="outside Git"):
        collect_snapshot(workspace, context=context)
    assert list(workspace.config.path.iterdir()) == []
    workspace = _workspace(tmp_path)
    outside = tmp_path / "outside"
    outside.mkdir()
    (workspace.config.path / "snapshots").symlink_to(outside, target_is_directory=True)
    with pytest.raises(ValueError, match="symlink"):
        collect_snapshot(workspace, context=context)
    assert list(outside.iterdir()) == []


def test_kernel_reader_refuses_escaping_links_and_paths(
    tmp_path: Path, context: CollectionContext,
) -> None:
    outside = _write(tmp_path, "outside", "PRIVATE")
    (context.reader.proc_root / "escape").symlink_to(outside)
    for interface in ("/proc/escape", "/proc/../outside", "/etc/passwd"):
        with pytest.raises(ValueError):
            context.reader.read(interface)


def test_collection_writes_only_in_workspace_and_uses_no_commands_or_network(
    tmp_path: Path, context: CollectionContext, monkeypatch: pytest.MonkeyPatch,
) -> None:
    workspace = _workspace(tmp_path)
    active = True
    writes = []
    violations = []
    authorized_fds = set()
    original_open = os.open

    def tracked_open(path, flags, *args, **kwargs):
        fd = original_open(path, flags, *args, **kwargs)
        if flags & (os.O_WRONLY | os.O_RDWR):
            authorized_fds.add(fd)
        return fd

    def denied(*args, **kwargs):
        violations.append("command or network attempt")
        raise AssertionError("commands and network are forbidden")

    monkeypatch.setattr(subprocess, "run", denied)
    monkeypatch.setattr(subprocess, "Popen", denied)
    monkeypatch.setattr(socket, "create_connection", denied)
    monkeypatch.setattr(socket.socket, "connect", denied)
    monkeypatch.setattr(socket.socket, "connect_ex", denied)
    monkeypatch.setattr(os, "open", tracked_open)

    def audit(event, args):
        if not active:
            return
        paths = ()
        if event == "open" and args[2] & (os.O_WRONLY | os.O_RDWR | os.O_CREAT | os.O_TRUNC):
            paths = (args[0],)
        elif event in {"os.mkdir", "os.remove", "os.rmdir", "os.chmod"}:
            paths = (args[0],)
        elif event in {"os.rename", "os.link", "os.symlink"}:
            paths = args[:2]
        for value in paths:
            if isinstance(value, int):
                if value not in authorized_fds:
                    violations.append("unapproved file descriptor")
                assert value in authorized_fds
                continue
            path = Path(value).resolve()
            if not path.is_relative_to(workspace.config.path):
                violations.append(f"outside workspace: {event}")
            assert path.is_relative_to(workspace.config.path), f"write outside workspace: {event}"
            writes.append(path)

    sys.addaudithook(audit)
    try:
        snapshot, path = collect_snapshot(workspace, context=context)
    finally:
        active = False
    assert snapshot.status == CollectionStatus.PARTIAL
    assert path / "manifest.json" in writes
    assert not violations


def test_privacy_excluded_interfaces_are_not_read(
    tmp_path: Path, context: CollectionContext, monkeypatch: pytest.MonkeyPatch,
) -> None:
    reads = []
    original_read = context.reader.read

    def recorded_read(interface: str) -> bytes:
        reads.append(interface)
        return original_read(interface)

    monkeypatch.setattr(context.reader, "read", recorded_read)
    collect_snapshot(_workspace(tmp_path), context=context)
    assert "/proc/cpuinfo" in reads and "/proc/cmdline" in reads
    assert not any(
        name in interface for interface in reads
        for name in ("/DSDT", "/MSDM", "/config", "/resource0", "/dmi/",
                     "/class/net/", "/hostname", "/boot_id", "/self/", "/proc/version")
    )


def test_snapshot_evidence_class_cannot_be_reference(
    tmp_path: Path, context: CollectionContext,
) -> None:
    snapshot, _ = collect_snapshot(_workspace(tmp_path), context=context)
    document = snapshot.model_dump()
    document["evidence_class"] = EvidenceClass.REFERENCE_PLATFORM
    with pytest.raises(ValidationError):
        SystemSnapshot.model_validate(document)


def test_cli_collects_fixture_snapshot_and_reports_partial_success(
    tmp_path: Path, context: CollectionContext, monkeypatch: pytest.MonkeyPatch,
    capsys: pytest.CaptureFixture[str],
) -> None:
    monkeypatch.setattr(
        "platform_compiler.snapshot.collect_snapshot", partial(collect_snapshot, context=context),
    )
    workspace = _workspace(tmp_path)
    assert main(["snapshot", "collect", "--workspace", str(workspace.config.path)]) == 0
    output = capsys.readouterr().out
    assert "Snapshot " in output
    assert "Successful collectors: cpu, numa, memory, pci, irq, kernel" in output
    assert "acpi (partial)" in output
    assert "FixtureVendor" not in output
    assert len(list((workspace.config.path / "snapshots").glob("*/manifest.json"))) == 1


def test_cli_reports_entirely_unusable_and_invalid_workspace(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch,
) -> None:
    context = CollectionContext(KernelReader(tmp_path / "proc", tmp_path / "sys"), "fixture64")
    monkeypatch.setattr(
        "platform_compiler.snapshot.collect_snapshot", partial(collect_snapshot, context=context),
    )
    workspace = _workspace(tmp_path)
    assert main(["snapshot", "collect", "--workspace", str(workspace.config.path)]) == 1
    with pytest.raises(SystemExit) as error:
        main(["snapshot", "collect", "--workspace", str(tmp_path / "missing")])
    assert error.value.code == 2
