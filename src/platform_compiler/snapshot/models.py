"""One collection event, not a canonical platform model or an analysis."""

from __future__ import annotations

from datetime import datetime
from enum import StrEnum
from typing import Annotated, Literal

from pydantic import BaseModel, ConfigDict, Field

from platform_compiler.evidence.models import EvidenceClass, Provenance


class ObservationModel(BaseModel):
    model_config = ConfigDict(frozen=True, extra="forbid")


class CollectionStatus(StrEnum):
    SUCCESS = "success"
    PARTIAL = "partial"
    UNAVAILABLE = "unavailable"
    PERMISSION_DENIED = "permission_denied"
    UNSUPPORTED = "unsupported"
    FAILED = "failed"


class CollectionError(ObservationModel):
    source: str
    status: CollectionStatus
    message: str


class Capture(ObservationModel):
    capture_id: str
    evidence_class: Literal[EvidenceClass.OBSERVED_TARGET] = EvidenceClass.OBSERVED_TARGET
    provenance: Provenance
    status: CollectionStatus
    raw_path: str | None = None
    size_bytes: int | None = None
    content_sha256: str | None = None
    transformation: str | None = None
    error: str | None = None
    content: bytes | None = Field(default=None, exclude=True, repr=False)


class LogicalCPU(ObservationModel):
    cpu_id: int
    online: bool | None = None
    package_id: int | None = None
    core_id: int | None = None
    thread_siblings: tuple[int, ...] | None = None
    numa_nodes: tuple[int, ...] | None = None
    identity: dict[str, str] = Field(default_factory=dict)
    flags: tuple[str, ...] = ()


class CPUTopology(ObservationModel):
    kind: Literal["cpu"] = "cpu"
    architecture: str
    online_cpu_ids: tuple[int, ...] | None = None
    cpus: tuple[LogicalCPU, ...] = ()


class NUMANode(ObservationModel):
    node_id: int
    cpu_ids: tuple[int, ...] | None = None
    memory_kib: dict[str, int] = Field(default_factory=dict)
    distances: tuple[int, ...] | None = None


class NUMATopology(ObservationModel):
    kind: Literal["numa"] = "numa"
    nodes: tuple[NUMANode, ...] = ()


class MemoryOverview(ObservationModel):
    kind: Literal["memory"] = "memory"
    values: dict[str, int] = Field(default_factory=dict)


class PCIDevice(ObservationModel):
    bdf: str
    vendor_id: str | None = None
    device_id: str | None = None
    class_id: str | None = None
    driver: str | None = None
    driver_bound: bool | None = None
    sysfs_path: str | None = None
    parent_path: str | None = None
    numa_node: int | None = None
    local_cpu_ids: tuple[int, ...] | None = None
    resources: tuple[tuple[int, int, int], ...] | None = None
    runtime_pm: dict[str, str] = Field(default_factory=dict)


class PCITopology(ObservationModel):
    kind: Literal["pci"] = "pci"
    devices: tuple[PCIDevice, ...] = ()


class ACPITableHeader(ObservationModel):
    signature: str
    length: int
    revision: int
    oem_id: str
    oem_table_id: str
    oem_revision: int
    creator_id: str
    creator_revision: int


class ACPITable(ObservationModel):
    name: str
    source: str
    capture_id: str
    header: ACPITableHeader | None = None


class ACPIInventory(ObservationModel):
    kind: Literal["acpi"] = "acpi"
    tables: tuple[ACPITable, ...] = ()


class KernelEnvironment(ObservationModel):
    kind: Literal["kernel"] = "kernel"
    architecture: str
    release: str | None = None
    version: str | None = None
    command_line: str | None = None
    efi_runtime_interface: bool | None = None


Observation = Annotated[
    CPUTopology | NUMATopology | MemoryOverview | PCITopology
    | ACPIInventory | KernelEnvironment,
    Field(discriminator="kind"),
]


class CollectorResult(ObservationModel):
    name: str
    collector_version: str = "1"
    started_at: datetime
    finished_at: datetime
    status: CollectionStatus
    observations: Observation | None = None
    captures: tuple[Capture, ...] = ()
    errors: tuple[CollectionError, ...] = ()


class SystemSnapshot(ObservationModel):
    snapshot_id: str
    schema_version: Literal[1] = 1
    captured_at: datetime
    finished_at: datetime
    program_version: str
    architecture: str
    kernel_release: str | None
    kernel_version: str | None
    evidence_class: Literal[EvidenceClass.OBSERVED_TARGET] = EvidenceClass.OBSERVED_TARGET
    provenance: Provenance
    status: CollectionStatus
    collectors: tuple[CollectorResult, ...]
