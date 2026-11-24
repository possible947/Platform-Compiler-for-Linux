# Platform Audit Report Template v2

# Step 1 Platform Specification

Status: `<candidate | complete_with_unknowns>`
Case: `<case-id>`
Questionnaire version: `platform-audit-questionnaire/v1`

## 1. Executive platform passport
Summarize only accepted questionnaire facts: platform identity, CPU topology/capability, memory/NUMA architecture, PCIe/I/O architecture, firmware/ACPI inventory. No diagnosis.

## 2. Platform identity
Render `SYS.*`.

## 3. CPU
### 3.1 Identity/topology
Render `CPU.001–017`.
### 3.2 Frequency capability
Render `CPU.020–029`; include a table for active-core/turbo information only when supported by sources.
### 3.3 Power/thermal/control capability
Render `CPU.030–045`.
### 3.4 Cache/interconnect
Render `CPU.050–056`.

## 4. Memory
Render `MEM.*`, explicitly separating kernel-usable memory, physically installed/EDAC capacity, configured state, and documented CPU capability.

## 5. NUMA
Render `NUMA.*`; preserve raw matrix and normalized values.

## 6. PCIe / I/O
Render `PCI.*` and one compact table per major endpoint containing BDF, ID, NUMA node, path, max/current link state, and evidence disposition.

## 7. IOMMU / DMA remapping
Render `IOMMU.*`, strictly separating firmware/hardware capability from kernel-visible activation/state.

## 8. Firmware / ACPI structural inventory
Render `ACPI.*`, `ACPI.CPU.*`, and `ACPI.PCI.*`. Inventory only. Do not label firmware behavior good/bad.

## 9. Mandatory cross-checks
For every `CHECK.*`, show result, side A, side B, and evidence refs. Inconsistency is a handoff fact, not a diagnosis.

## 10. Contradictions and conflicts
List every `inconsistent` check and every `conflicting` questionnaire field.

## 11. Unknown / unavailable / not applicable
For every required unresolved field show acquisition attempts and why no value was accepted.

## 12. Source basis
List exact local evidence refs and exact external URLs/document identifiers actually used.

## 13. Limitations
State privilege, network, tooling, live-vs-captured verification, and point-in-time limitations.

## 14. Step 2 handoff
List stable specification facts, unresolved fields that must remain unresolved, and evidence artifacts likely useful to Step 2. Do not recommend what Step 2 should conclude or change.

## Final statement
Confirm questionnaire completion status and that Step 2/3/4 work was not performed.
