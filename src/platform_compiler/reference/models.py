from __future__ import annotations

from enum import StrEnum
from pathlib import Path

from pydantic import BaseModel, ConfigDict, Field


class ArtifactClass(StrEnum):
    ACPI = "acpi"
    DMI = "dmi"
    PCI = "pci"
    IOREGISTRY = "ioregistry"
    CPU = "cpu"
    MEMORY = "memory"
    DEVICE_PROPERTIES = "device_properties"
    POWER = "power"
    RTC = "rtc"
    NVRAM = "nvram"
    SMC = "smc"
    KERNEL = "kernel"
    BOOT = "boot"
    SYSTEM_PROFILER = "system_profiler"
    OTHER = "other"


class ArtifactProvenance(BaseModel):
    model_config = ConfigDict(frozen=True)

    source: str
    revision: str
    reference_id: str
    content_sha256: str


class ReferenceArtifact(BaseModel):
    model_config = ConfigDict(frozen=True)

    artifact_id: str
    artifact_class: ArtifactClass
    size_bytes: int = Field(ge=0)
    content_sha256: str
    provenance: ArtifactProvenance


class ReferenceSnapshot(BaseModel):
    model_config = ConfigDict(frozen=True)

    reference_id: str
    source: str
    revision: str
    path: Path
    artifacts: tuple[ReferenceArtifact, ...]
    omitted_artifact_count: int = 0
