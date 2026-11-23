"""Fixed read-only Linux collectors. No commands, policy, or interpretation."""

from __future__ import annotations

import re

from platform_compiler.snapshot.models import (
    ACPIInventory,
    ACPITable,
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
    for block in content.decode("ascii").split("\n\n"):
        lines = []
        for line in block.splitlines():
            key, separator, value = line.partition(":")
            if separator and key.strip() in _CPU_FIELDS:
                lines.append(f"{key.strip()}: {value.strip()}")
        if lines:
            blocks.append("\n".join(lines))
    return ("\n\n".join(blocks) + "\n").encode("ascii")


class CPUCollector:
    name = "cpu"

    def collect(self, context: CollectionContext) -> CollectorResult:
        session = CaptureSession(self.name, context)
        interface = "/proc/cpuinfo"
        content = session.read(interface, _cpuinfo, "cpuinfo_field_allowlist")
        identities: dict[int, dict[str, str]] = {}
        if content is not None:
            for block in content.decode("ascii").strip().split("\n\n"):
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
                return context.reader.canonical(base + "/driver").rsplit("/", 1)[-1].encode("ascii")

            canonical_bytes = session.capture(base, canonical, "canonical_sysfs_path")
            path = canonical_bytes.decode("ascii") if canonical_bytes is not None else None
            driver_bytes = session.capture(base + "/driver", driver, "driver_link_basename")
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
                driver=driver_bytes.decode("ascii") if driver_bytes is not None else None,
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


_STRUCTURAL_ACPI = {"APIC", "SRAT", "SLIT", "MCFG", "HPET"}


def _acpi_structural(content: bytes, signature: str) -> bytes:
    if (
        len(content) < 36
        or content[:4] != signature.encode("ascii")
        or int.from_bytes(content[4:8], "little") != len(content)
    ):
        raise ValueError("invalid ACPI table header")
    # OEM/compiler identity fields can contain identifiers; do not retain them.
    return content[:10] + bytes(26) + content[36:]


class ACPICollector:
    name = "acpi"

    def collect(self, context: CollectionContext) -> CollectorResult:
        session = CaptureSession(self.name, context)
        tables = []
        for root in ("/sys/firmware/acpi/tables", "/sys/firmware/acpi/tables/dynamic"):
            names = session.entries(root, r"[A-Z0-9_]{4}\d*")
            for name in names or ():
                interface = f"{root}/{name}"
                if name[:4] in _STRUCTURAL_ACPI:
                    session.read(
                        interface,
                        lambda content: _acpi_structural(content, name[:4]),
                        "acpi_header_identifiers_redacted",
                    )
                else:
                    def deferred() -> bytes:
                        context.reader.probe(interface)
                        raise DeferredCapture("table body deferred by default privacy policy")
                    session.capture(interface, deferred, "acpi_body_deferred_privacy")
                tables.append(ACPITable(
                    name=name, source=interface, capture_id=session.captures[-1].capture_id,
                ))
        return session.finish(ACPIInventory(tables=tuple(tables)))


_BOOT_FLAGS = {
    "ro", "rw", "quiet", "splash", "noapic", "nolapic", "nohz", "nosmt",
    "numa_balancing", "transparent_hugepage", "iommu", "intel_iommu", "amd_iommu",
    "maxcpus", "nr_cpus", "mitigations", "preempt", "irqaffinity", "isolcpus",
    "nohz_full", "rcu_nocbs", "pcie_aspm",
}
_BOOT_VALUES = re.compile(
    r"(?:[0-9,-]+|on|off|auto|force|pt|soft|strict|relaxed|full|full,nosmt|"
    r"none|voluntary|dynamic|always|madvise|never|performance|powersave|default|"
    r"domain|managed_irq|nohz)(?:,(?:domain|managed_irq|nohz|[0-9-]+))*"
)


def _cmdline(content: bytes) -> bytes:
    result = []
    for token in content.decode("ascii").split():
        key, separator, value = token.partition("=")
        permitted = key in _BOOT_FLAGS and (
            (not separator and key in {"ro", "rw", "quiet", "splash", "noapic", "nolapic", "nosmt"})
            or bool(separator and _BOOT_VALUES.fullmatch(value))
        )
        result.append(token if permitted else "[redacted]")
    return (" ".join(result) + "\n").encode("ascii")


class KernelCollector:
    name = "kernel"

    def collect(self, context: CollectionContext) -> CollectorResult:
        session = CaptureSession(self.name, context)
        session.capture("uname.machine", lambda: context.architecture.encode("ascii"))
        release = session.text("/proc/sys/kernel/osrelease")
        version = session.text("/proc/sys/kernel/version")
        command = session.read("/proc/cmdline", _cmdline, "kernel_cmdline_allowlist")
        return session.finish(KernelEnvironment(
            architecture=context.architecture, release=release, version=version,
            command_line=command.decode("ascii").strip() if command is not None else None,
        ))


def default_collectors() -> tuple[Collector, ...]:
    return (
        CPUCollector(), NUMACollector(), MemoryCollector(), PCICollector(),
        IRQCollector(), ACPICollector(), KernelCollector(),
    )
