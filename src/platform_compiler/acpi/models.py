"""Derivation record for one joint iASL disassembly of captured AML definition blocks."""

from __future__ import annotations

from enum import StrEnum
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field, model_validator

from platform_compiler.evidence.models import DerivedArtifact, ToolInvocation

DERIVATION_SCHEMA_VERSION = 1


class _Model(BaseModel):
    model_config = ConfigDict(frozen=True, extra="forbid")


class DerivationStatus(StrEnum):
    SUCCEEDED = "succeeded"
    FAILED = "failed"


class ExclusionReason(StrEnum):
    # OEM-specific ("OEMx") tables may carry AML that firmware loads at run time.
    OEM_SPECIFIC_TABLE_DEFERRED = "oem_specific_table_deferred"
    DYNAMIC_DEFINITION_BLOCK_DEFERRED = "dynamic_definition_block_deferred"
    NOT_A_BOOT_DEFINITION_BLOCK = "not_a_boot_definition_block"


class DefinitionBlockInput(_Model):
    table_name: str
    signature: Literal["DSDT", "SSDT"]
    oem_id: str
    oem_table_id: str
    source: str
    capture_id: str
    content_sha256: str
    size_bytes: int = Field(ge=36)
    staged_name: str


class ExcludedTable(_Model):
    table_name: str
    signature: str | None
    source: str
    capture_id: str
    capture_status: str
    content_sha256: str | None
    reason: ExclusionReason


class FileDigest(_Model):
    path: str
    size_bytes: int = Field(ge=0)
    sha256: str


class ACPIDisassembly(_Model):
    """Manifest of a derivation; artifacts exist only when the derivation succeeded."""

    derivation_schema_version: Literal[1] = DERIVATION_SCHEMA_VERSION
    kind: Literal["acpi_joint_disassembly"] = "acpi_joint_disassembly"
    derivation_id: str
    snapshot_id: str
    snapshot_manifest_sha256: str
    status: DerivationStatus
    failure: str | None = None
    inputs: tuple[DefinitionBlockInput, ...] = Field(min_length=1)
    excluded_tables: tuple[ExcludedTable, ...] = ()
    invocation: ToolInvocation
    stdout: FileDigest
    stderr: FileDigest
    artifacts: tuple[DerivedArtifact, ...] = ()
    diagnostics: tuple[FileDigest, ...] = ()

    @model_validator(mode="after")
    def status_is_consistent(self) -> ACPIDisassembly:
        if self.status is DerivationStatus.SUCCEEDED:
            if self.failure is not None or len(self.artifacts) != len(self.inputs):
                raise ValueError("a succeeded derivation has one artifact per input")
        elif self.failure is None or self.artifacts:
            raise ValueError("a failed derivation has a failure and no artifacts")
        return self
