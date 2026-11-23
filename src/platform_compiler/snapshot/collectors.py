"""Fixed read-only Linux collectors. No commands, policy, or interpretation."""

from __future__ import annotations

import re

from platform_compiler.snapshot.models import (
    ACPIInventory,
    ACPITable,
    ACPITableHeader,
    CPUTopology,
    CollectorResult,
    KernelEnvironment,
    LogicalCPU,
    MemoryOverview,
    NUMANode,
    NUMATopology,
    PCIDevice,
    PCITopology,
)
from platform_compiler.snapshot.reader import (
    CaptureSession,
    CollectionContext,
    Collector,
    DeferredCapture,
)

_CPU_FIELDS = {
    "processor", "vendor_id", "cpu family", "model", "model name", "stepping",
    "microcode", "flags", "Features", "CPU implementer", "CPU architecture",
    "CPU variant", "CPU part", "CPU revision", "isa", "mvendorid", "marchid", "mimpid",
}


def _cpuinfo(content: bytes) -> bytes:
    blocks = []
    for block in content.decode("utf-8").split("\n\n"):
        lines = []
        for line in block.splitlines():
            key, separator, value = line.partition(":")
            if separator and key.strip() in _CPU_FIELDS:
                lines.append(f"{key.strip()}: {value.strip()}")
        if lines:
            blocks.append("\n".join(lines))
    return ("\n\n".join(blocks) + "\n").encode("utf-8")


class CPUCollector:
    name = "cpu"

    def collect(self, context: CollectionContext) -> CollectorResult:
        session = CaptureSession(self.name, context)
        interface = "/proc/cpuinfo"
        content = session.read(interface, _cpuinfo, "cpuinfo_field_allowlist")
        identities: dict[int, dict[str, str]] = {}
        if content is not None:
            for block in content.decode("utf-8").strip().split("\n\n"):
                fields = dict(line.split(": ", 1) for line in block.splitlines() if ": " in line)
                processor = fields.pop("processor", "")
                if processor.isdecimal():
                    identities[int(processor)] = fields
        root = "/sys/devices/system/cpu"
        names = session.entries(root, r"cpu\d+")
        online = session.cpu_list(f"{root}/online")
        ids = sorted(
            {int(name[3:]) for name in names or ()} | identities.keys()
        )
        cpus = []
        for cpu_id in ids:
            base = f"{root}/cpu{cpu_id}"
            node_names = session.entries(base, r"node\d+")
            identity = dict(identities.get(cpu_id, {}))
            flags = identity.pop("flags", identity.pop("Features", ""))
            cpus.append(LogicalCPU(
                cpu_id=cpu_id,
                online=cpu_id in online if online is not None else None,
                package_id=session.integer(f"{base}/topology/physical_package_id"),
                core_id=session.integer(f"{base}/topology/core_id"),
                thread_siblings=session.cpu_list(f"{base}/topology/thread_siblings_list"),
                numa_nodes=(
                    tuple(sorted(int(name[4:]) for name in node_names))
                    if node_names is not None else None
                ),
                identity=identity,
                flags=tuple(sorted(set(flags.split()))),
            ))
        return session.finish(CPUTopology(
            architecture=context.architecture, online_cpu_ids=online, cpus=tuple(cpus),
        ))


def _node_memory(value: str) -> dict[str, int]:
    result = {}
    for line in value.splitlines():
        match = re.fullmatch(r"Node\s+\d+\s+(MemTotal|MemFree|MemUsed):\s+(\d+)\s+kB", line)
        if match:
            result[match[1]] = int(match[2])
    if "MemTotal" not in result:
        raise ValueError("missing node memory total")
    return result


class NUMACollector:
    name = "numa"

    def collect(self, context: CollectionContext) -> CollectorResult:
        session = CaptureSession(self.name, context)
        root = "/sys/devices/system/node"
        names = session.entries(root, r"node\d+")
        nodes = []
        for name in sorted(names or (), key=lambda value: int(value[4:])):
            base = f"{root}/{name}"
            memory = session.parse(base + "/meminfo", session.text(base + "/meminfo"), _node_memory)
            distance = session.parse(
                base + "/distance", session.text(base + "/distance"),
                lambda text: tuple(int(value) for value in text.split()),
            )
            nodes.append(NUMANode(
                node_id=int(name[4:]), cpu_ids=session.cpu_list(base + "/cpulist"),
                memory_kib=memory or {}, distances=distance,
            ))
        return session.finish(NUMATopology(nodes=tuple(nodes)))


def _memory(value: str) -> dict[str, int]:
    result = {}
    for line in value.splitlines():
        match = re.fullmatch(r"(\w+):\s+(\d+)(?:\s+(kB))?", line)
        if match:
            key = match[1] + ("_kib" if match[3] else "")
            result[key] = int(match[2])
    if "MemTotal_kib" not in result:
        raise ValueError("missing memory total")
    return result


class MemoryCollector:
    name = "memory"

    def collect(self, context: CollectionContext) -> CollectorResult:
        session = CaptureSession(self.name, context)
        source = "/proc/meminfo"
        values = session.parse(source, session.text(source), _memory)
        return session.finish(MemoryOverview(values=values or {}))


def _resources(value: str) -> tuple[tuple[int, int, int], ...]:
    result = []
    for line in value.splitlines():
        fields = line.split()
        if len(fields) != 3:
            raise ValueError("invalid PCI resource entry")
        result.append(tuple(int(field, 16) for field in fields))
    return tuple(result)


class PCICollector:
    name = "pci"

    def collect(self, context: CollectionContext) -> CollectorResult:
        session = CaptureSession(self.name, context)
        root = "/sys/bus/pci/devices"
        names = session.entries(root, r"[0-9a-fA-F]{4,8}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}\.[0-7]")
        devices = []
        for name in names or ():
            base = f"{root}/{name}"

            def canonical() -> bytes:
                return context.reader.canonical(base).encode("ascii")

            def driver() -> bytes:
                # An absent link is an observation: no driver is bound.
                if not context.reader.exists(base + "/driver"):
                    return b""
                return context.reader.canonical(base + "/driver").rsplit("/", 1)[-1].encode("ascii")

            canonical_bytes = session.capture(base, canonical, "canonical_sysfs_path")
            path = canonical_bytes.decode("ascii") if canonical_bytes is not None else None
            driver_bytes = session.capture(
                base + "/driver", driver, "driver_link_basename_empty_if_absent",
            )
            identifiers = {}
            for field in ("vendor", "device", "class"):
                interface = f"{base}/{field}"
                value = session.text(interface)
                identifiers[field] = session.parse(
                    interface, value, lambda text: _hex_id(text),
                )
            pm = {}
            for field in ("control", "runtime_status"):
                value = session.text(f"{base}/power/{field}")
                if value is not None:
                    pm[field] = value
            devices.append(PCIDevice(
                bdf=name,
                vendor_id=identifiers["vendor"], device_id=identifiers["device"],
                class_id=identifiers["class"],
                driver=(driver_bytes.decode("ascii") or None) if driver_bytes is not None else None,
                driver_bound=bool(driver_bytes) if driver_bytes is not None else None,
                sysfs_path=path,
                parent_path=path.rsplit("/", 1)[0] if path else None,
                numa_node=session.integer(base + "/numa_node"),
                local_cpu_ids=session.cpu_list(base + "/local_cpulist"),
                resources=session.parse(
                    base + "/resource", session.text(base + "/resource"), _resources,
                ),
                runtime_pm=pm,
            ))
        return session.finish(PCITopology(devices=tuple(devices)))


def _hex_id(value: str) -> str:
    if not re.fullmatch(r"0x[0-9a-fA-F]{4,8}", value):
        raise ValueError("invalid PCI ID")
    return value.lower()


class IRQCollector:
    name = "irq"

    def collect(self, context: CollectionContext) -> CollectorResult:
        session = CaptureSession(self.name, context)
        session.read("/proc/interrupts")
        return session.finish()


# License-bearing tables can contain product keys; never read their bodies.
_DEFERRED_ACPI = {"MSDM", "SLIC"}
# FACS does not use the common 36-byte system description table header.
_HEADERLESS_ACPI = {"FACS"}


def _acpi_header(content: bytes, signature: str) -> ACPITableHeader:
    if (
        len(content) < 36
        or content[:4] != signature.encode("ascii")
        or int.from_bytes(content[4:8], "little") != len(content)
    ):
        raise ValueError("invalid ACPI table header")

    def text(field: bytes) -> str:
        return field.decode("latin-1").rstrip("\x00 ")

    return ACPITableHeader(
        signature=signature,
        length=len(content),
        revision=content[8],
        oem_id=text(content[10:16]),
        oem_table_id=text(content[16:24]),
        oem_revision=int.from_bytes(content[24:28], "little"),
        creator_id=text(content[28:32]),
        creator_revision=int.from_bytes(content[32:36], "little"),
    )


class ACPICollector:
    name = "acpi"

    def collect(self, context: CollectionContext) -> CollectorResult:
        session = CaptureSession(self.name, context)
        tables = []
        for root in ("/sys/firmware/acpi/tables", "/sys/firmware/acpi/tables/dynamic"):
            names = session.entries(root, r"[A-Z0-9_]{4}\d*")
            for name in names or ():
                interface = f"{root}/{name}"
                signature = name[:4]
                header = None
                if signature in _DEFERRED_ACPI:
                    def deferred() -> bytes:
                        context.reader.probe(interface)
                        raise DeferredCapture("license-bearing table body deferred by privacy policy")
                    session.capture(interface, deferred, "acpi_body_deferred_privacy")
                    capture_id = session.captures[-1].capture_id
                else:
                    content = session.read(interface)
                    capture_id = session.captures[-1].capture_id
                    if signature not in _HEADERLESS_ACPI:
                        header = session.parse(
                            interface, content,
                            lambda value: _acpi_header(value, signature),
                        )
                tables.append(ACPITable(
                    name=name, source=interface, capture_id=capture_id, header=header,
                ))
        return session.finish(ACPIInventory(tables=tuple(tables)))


# Values of these boot parameters identify disks, hosts, networks or credentials.
_SENSITIVE_BOOT_KEY = re.compile(
    r"(?:^|[._-])(?:root|resume|cryptdevice|luks|lvm|uuid|partuuid|label|ip|nfsroot|"
    r"netroot|iscsi|bootif|ifname|hostname|host|user|username|pass|passwd|password|"
    r"secret|token|key|auth|credential|credentials|machine_id|serial|mac|ds|"
    r"ignition|url)(?:$|[._-])",
    re.IGNORECASE,
)
_IDENTIFYING_VALUE = re.compile(
    r"[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}"
    r"|(?:[0-9a-f]{2}[:-]){5}[0-9a-f]{2}|[0-9a-f]{16,}|@|://",
    re.IGNORECASE,
)
_BOOT_FLAG = re.compile(r"[A-Za-z0-9_.\-]+")


def _cmdline(content: bytes) -> bytes:
    """Keep parameter names; redact values that may identify the machine or user."""
    result = []
    for token in content.decode("utf-8").split():
        key, separator, value = token.partition("=")
        if not separator:
            result.append(
                token if _BOOT_FLAG.fullmatch(token) and not _IDENTIFYING_VALUE.search(token)
                else "[redacted]"
            )
        elif not _BOOT_FLAG.fullmatch(key):
            result.append("[redacted]")
        elif _SENSITIVE_BOOT_KEY.search(key) or _IDENTIFYING_VALUE.search(value):
            result.append(f"{key}=[redacted]")
        else:
            result.append(token)
    return (" ".join(result) + "\n").encode("utf-8")


class KernelCollector:
    name = "kernel"

    def collect(self, context: CollectionContext) -> CollectorResult:
        session = CaptureSession(self.name, context)
        session.capture("uname.machine", lambda: context.architecture.encode("ascii"))
        release = session.text("/proc/sys/kernel/osrelease")
        version = session.text("/proc/sys/kernel/version")
        command = session.read(
            "/proc/cmdline", _cmdline, "kernel_cmdline_identifying_values_redacted",
        )
        efi = session.capture(
            "/sys/firmware/efi",
            lambda: b"present" if context.reader.exists("/sys/firmware/efi") else b"absent",
            "existence_check",
        )
        return session.finish(KernelEnvironment(
            architecture=context.architecture, release=release, version=version,
            command_line=command.decode("utf-8").strip() if command is not None else None,
            efi_runtime_interface=efi == b"present" if efi is not None else None,
        ))


def default_collectors() -> tuple[Collector, ...]:
    return (
        CPUCollector(), NUMACollector(), MemoryCollector(), PCICollector(),
        IRQCollector(), ACPICollector(), KernelCollector(),
    )
