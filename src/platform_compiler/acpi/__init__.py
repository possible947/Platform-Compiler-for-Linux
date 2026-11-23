"""Deterministic offline derivations from captured ACPI evidence; no interpretation."""

from platform_compiler.acpi.disassembly import (
    DisassemblyOutcome,
    Publication,
    disassemble_snapshot,
    load_derivation,
    select_definition_blocks,
)
from platform_compiler.acpi.iasl import ToolUnavailable, resolve_iasl
from platform_compiler.acpi.models import ACPIDisassembly, DerivationStatus

__all__ = [
    "ACPIDisassembly",
    "DerivationStatus",
    "DisassemblyOutcome",
    "Publication",
    "ToolUnavailable",
    "disassemble_snapshot",
    "load_derivation",
    "resolve_iasl",
    "select_definition_blocks",
]
