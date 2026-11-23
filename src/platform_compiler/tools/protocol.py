from __future__ import annotations

from enum import StrEnum
from typing import Protocol

from pydantic import BaseModel, ConfigDict


class ToolCategory(StrEnum):
    PLATFORM_TOPOLOGY = "platform_topology"
    ACPI_CAPTURE = "acpi_capture"
    ACPI_NAMESPACE_ANALYSIS = "acpi_namespace_analysis"
    ACPI_COMPILATION = "acpi_compilation"
    ACPI_SANDBOX = "acpi_sandbox"
    ACPI_METHOD_TRACE = "acpi_method_trace"
    ACPI_CORRECTION_RECORD = "acpi_correction_record"
    PCI_INSPECTION = "pci_inspection"
    IRQ_INSPECTION = "irq_inspection"
    NUMA_INSPECTION = "numa_inspection"
    KERNEL_LOG_INSPECTION = "kernel_log_inspection"
    KERNEL_SOURCE_INSPECTION = "kernel_source_inspection"
    RUNTIME_PM_INSPECTION = "runtime_pm_inspection"
    REFERENCE_PLATFORM_LOOKUP = "reference_platform_lookup"
    SPECIFICATION_RETRIEVAL = "specification_retrieval"
    WEB_RETRIEVAL = "web_retrieval"
    OFFLINE_COMPILATION = "offline_compilation"
    SANDBOX_VERIFICATION = "sandbox_verification"
    REFERENCE_COMPARISON = "reference_comparison"


class ToolRequest(BaseModel):
    model_config = ConfigDict(frozen=True)

    category: ToolCategory
    operation: str
    arguments: dict[str, str | int | bool]


class ToolResult(BaseModel):
    model_config = ConfigDict(frozen=True)

    summary: str
    evidence_ids: tuple[str, ...] = ()


class SemanticTool(Protocol):
    """Narrow semantic-operation interface, never an unrestricted shell."""

    def execute(self, request: ToolRequest) -> ToolResult:
        ...
