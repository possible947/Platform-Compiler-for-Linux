# Historical ADR-002: Canonical ACPI and Reference Platform Policy

> **Status:** Superseded historical proposal. ACPI remains a possible evidence
> and remediation layer, not the current optimization architecture. See
> `docs/ARCHITECTURE.md` and ADR-003.

- **Status:** Proposed / Initial Implementation Baseline
- **Decision Type:** Architecture
- **Project:** Platform Compiler for Linux
- **Version:** 0.1
- **Related:** ADR-001, LLM Inference and Runtime Investigation Architecture

## 1. Context

Platform Compiler targets a specific physical machine rather than a portable hardware class. The production Linux environment is generated for that machine and may be regenerated after a material firmware or hardware change.

The project therefore does not treat OEM ACPI tables as immutable truth. It treats them as one implementation of the platform description that must be reconciled with:

- the physical hardware actually present;
- observed runtime behavior;
- Linux kernel and driver behavior;
- applicable ACPI and PCI contracts;
- empirically verified corrections;
- a selected reference-platform implementation.

The objective is not to make a PC emulate a Mac and not to apply Hackintosh recipes blindly. macOS, OpenCore/Hackintosh practice, and Apple platform dumps are used because they provide a practical reference corpus for ACPI engineering, OS-personality selection, resource normalization, and machine-specific platform description.

For the initial dual-socket Cascade Lake target, the project uses a complete MacPro7,1 dump as its primary reference. This selection is based on project-specific platform similarity and prior successful use of that reference during DSDT adaptation. These are project facts supplied by the platform owner and are not generalized to unrelated machines.

Linux itself supports replacing or adding ACPI tables through its ACPI table-upgrade mechanism when the corresponding kernel options are enabled. The kernel documentation explicitly describes this facility as a way to test and work around buggy firmware tables without modifying the underlying platform firmware. [1]

ACPICA provides the compiler/disassembler, AML interpreter, namespace and resource functionality, and user-space tools required for table extraction, compilation, disassembly, and sandbox execution. [2][3]

---

## 2. Decision

Platform Compiler will generate a **Canonical Platform ACPI** for the target machine.

The canonical ACPI environment is a verified, machine-specific platform description derived from:

```text
Physical target hardware
        +
OEM ACPI tables
        +
Observed runtime behavior
        +
Primary reference platform
        +
Optional component references
        +
Linux behavior
        +
Applicable specifications
        +
Verified project knowledge
        |
        v
Canonical Platform ACPI
```

The canonical ACPI environment may replace OEM ACPI semantics where a change is justified and verified.

The generated ACPI is a build artifact of Platform Compiler. It is not the authoritative source model and it is not permanently flashed into motherboard firmware.

---

## 3. Core Principles

### 3.1 Hardware reality is authoritative for physical facts

Reference-platform firmware must never override facts established for the target machine.

Examples of target-owned facts include:

- installed devices;
- PCI configuration-space topology;
- BARs and resource windows;
- CPU/socket/NUMA topology;
- interrupt routing evidence;
- actual operation regions and register addresses;
- target firmware dependencies;
- experimentally observed behavior.

Reference implementations may contribute semantics and implementation patterns, but not unverified target constants.

### 3.2 OEM ACPI is an input, not a contract of perfection

The OEM DSDT/SSDT set is preserved as raw evidence but may contain:

- invalid or contradictory resource ranges;
- unnecessary legacy resources;
- broken or ambiguous method behavior;
- inappropriate OS-dependent branches;
- incomplete device representation;
- platform-specific workarounds that are irrelevant to the production environment.

The project investigates these conditions rather than assuming either correctness or incorrectness in advance.

### 3.3 Canonical ACPI is production-path oriented

The project does not attempt to make every dormant firmware branch aesthetically perfect.

A defect is modified only when it affects:

- the selected production OS-personality path;
- a required platform device;
- required resources;
- required power/runtime behavior;
- the production workload;
- a dependency of a verified correction.

An irrelevant, unreachable defect may remain documented and unchanged.

### 3.4 No change is better than an unnecessary change

A technically valid transformation is not accepted merely because it makes the source cleaner.

Every accepted semantic change requires a reason tied to target behavior or a required target invariant.

### 3.5 Reference platforms provide semantic patterns

A reference ACPI implementation is used to answer questions such as:

- How is this hardware responsibility represented?
- Which device owns this method?
- How are resources expressed?
- How is a PEG/GPU relationship represented?
- How are HPET, RTC, LPC, IRQ, CPU, or socket responsibilities organized?
- How is OS-dependent behavior structured?

It is not used as a source of hardware constants unless those constants independently match the target machine.

### 3.6 Eliminate firmware-derived quirks at the source when verified

When an operating-system workaround exists only because the platform description is incorrect, Platform Compiler should prefer correcting the platform description so that the workaround becomes unnecessary.

This principle does not imply removing every Linux quirk. It applies only when the root cause is understood, target semantics are established, and the canonical ACPI makes the workaround unnecessary.

---

## 4. Canonical ACPI Scope for Version 1

Version 1 deliberately limits ACPI transformation to a small set of high-value concerns.

```yaml
canonical_acpi_v1:
  resource_ranges:
    verify: true
    correct_verified_errors: true

  legacy_irq:
    analyze: true
    release_verified_unused_claims: true

  hpet:
    normalize_resources: true
    add_required_verified_methods: true

  rtc:
    normalize_resources: true
    release_verified_unused_resources: true

  lpc:
    normalize_required_path: true

  os_personality:
    analyze_reachable_paths: true
    prefer_verified_unix_or_bsd_path: true

  gpu:
    analyze_endpoint_and_upstream_path: true
    preserve_physical_pci_enumeration: true
    normalize_verified_acpi_semantics: true

  everything_else:
    preserve_unless_required_dependency: true
```

This scope is intentionally narrow. Platform Compiler is not a general-purpose ACPI beautifier.

---

## 5. Reference Platform Library

Platform Compiler maintains a **Reference Platform Library** containing complete platform artifacts available to the project.

Conceptually:

```text
references/
├── macpro7_1/
│   ├── raw/
│   │   ├── DSDT
│   │   ├── SSDTs
│   │   └── additional captured artifacts
│   ├── normalized/
│   └── semantic_patterns/
│
├── other_reference_platform/
│   └── ...
│
└── verified_target_cases/
    └── ...
```

The exact repository layout is not frozen by this ADR.

### 5.1 Primary reference

Each supported target platform may select one primary reference.

For the initial target:

```yaml
reference:
  primary: MacPro7,1
  selection_basis:
    - closest available project reference for the target platform
    - previously used successfully for target DSDT adaptation
    - complete reference dump is available to the project
```

These are project-specific evidence statements, not universal claims about platform equivalence.

### 5.2 Component references

A target may use additional component references when another known platform contains a better-matched implementation of a specific subsystem.

Examples:

```text
Primary platform reference       -> platform-wide semantics
Component HPET reference         -> HPET organization
Component GPU reference          -> PEG/GFX representation
Component CPU reference          -> CPU/socket organization
```

Component references never override verified target hardware facts.

### 5.3 Reference selection

Reference selection should use a small set of architecture-relevant characteristics rather than exhaustive hardware identity.

Candidate dimensions include:

- CPU generation/family;
- socket topology;
- memory topology class;
- platform/chipset class;
- PCIe topology class;
- GPU arrangement;
- relevant power-management architecture.

The initial implementation may use deterministic scoring. LLM reasoning may explain semantic differences after selection but should not be the sole authority choosing a reference platform.

---

## 6. Joint ACPI Namespace Requirement

DSDT must not be analyzed in isolation when SSDTs contribute required symbols or behavior.

The analysis unit is the effective ACPI namespace assembled from the target's relevant tables.

```text
DSDT
 +
SSDT set
 +
other relevant definition blocks
        |
        v
Joint Namespace
```

Unresolved objects are classified only after the relevant table set has been considered.

The production-path namespace must resolve every required object used by the canonical platform description.

---

## 7. Compilation and Structural Gates

Canonical production ACPI must pass deterministic structural validation before runtime validation.

### 7.1 Mandatory gate

```text
iASL compilation errors = 0
```

A production ACPI artifact is not accepted when the compiler reports an error.

Warnings and remarks require classification. They are not silently converted into errors and are not silently ignored.

### 7.2 Required production-path properties

For required and reachable objects, Platform Compiler should establish:

```text
required namespace objects resolve
required resources are defined
known target resource conflicts are absent
required methods compile
required method dependencies resolve
required operation regions are understood
expected devices remain present
unexpected semantic deltas are absent
```

### 7.3 Round-trip validation

Where useful, the project should perform ASL -> AML -> DSL -> AML validation and compare the resulting semantics/artifacts. ACPICA project guidance explicitly lists an ASL/AML/DSL round trip as a basic validation workflow for table compiler/disassembler changes. [3]

---

## 8. Resource Range Policy

Resource correction is a primary Version 1 use case.

Linux documentation states that ACPI `_CRS` describes resources consumed by devices and that PCI host-bridge `_CRS` must describe the address space it consumes, including windows forwarded downstream. [4]

Platform Compiler therefore treats resource descriptions as a graph rather than independent text fragments.

```text
Physical resource
      |
PCI configuration and topology
      |
OEM ACPI resource description
      |
Runtime ownership/behavior
      |
Reference implementation
      |
Canonical resource description
```

A range may be changed only when target evidence establishes that the OEM representation is incorrect or unsuitable for the verified production semantics.

---

## 9. Legacy IRQ Policy

Legacy IRQ claims are analyzed as shared resource relationships, not as isolated device attributes.

Typical resource cluster:

```text
HPET
RTC
legacy timer resources
interrupt controller representation
related ACPI methods
related IRQ claims
```

The canonical ACPI may release an IRQ or legacy resource only when the target machine's required runtime behavior and dependencies remain valid.

No global rule such as "always remove IRQ X" is permitted.

---

## 10. HPET Policy

HPET normalization is a first-class Version 1 transformation.

The project may:

- normalize the HPET device's resource description;
- correct verified IRQ/resource relationships;
- add project-required HPET methods whose semantics are established for the target;
- compare target semantics against the selected reference platform;
- validate resulting runtime behavior.

HPET transformation is performed as part of the timer/IRQ resource cluster and not as an isolated textual patch.

---

## 11. RTC Policy

RTC normalization may:

- correct target resource descriptions;
- remove verified unnecessary claims;
- preserve required I/O ranges;
- preserve required wake/timekeeping behavior;
- reconcile RTC behavior with HPET/legacy-timer changes.

RTC changes must be evaluated together with the timer/IRQ resource cluster.

---

## 12. LPC Policy

The canonical ACPI may normalize the LPC-related namespace and required methods when the target hardware actually contains the associated functionality and the path is required by the production environment.

The goal is not to synthesize a generic LPC device. The goal is to make the target's required LPC-related platform semantics explicit and valid.

---

## 13. OS-Personality Policy

### 13.1 Rationale

Linux documentation explains that stock Linux commonly reports compatibility with Windows `_OSI` strings because many OEM systems were primarily tested on Windows paths and alternate firmware paths can expose BIOS bugs. [5]

Platform Compiler addresses a different environment:

```text
one target machine
one canonicalized ACPI environment
one machine-specific Linux production environment
```

The project therefore does not require the stock Linux strategy to remain the canonical production policy after the alternate path has been explicitly analyzed, corrected, and verified.

### 13.2 Preferred behavior

If the target OEM ACPI contains a UNIX/BSD or otherwise suitable non-Windows path, Platform Compiler may select that path as the production personality only after its reachable semantics have been analyzed and validated.

The policy is:

```text
Find suitable target personality already represented in ACPI
        |
Analyze all reachable methods and dependencies
        |
Correct required production-path defects
        |
Verify namespace/resources/runtime behavior
        |
Select that personality at boot
```

The mere presence of a UNIX/BSD string is not sufficient evidence.

### 13.3 Windows-specific paths

Windows-specific branches that are unreachable under the verified production personality do not need cosmetic repair.

They remain raw firmware evidence and may be documented as dormant defects.

---

## 14. PCI and GPU Policy

### 14.1 Two related representations

Platform Compiler distinguishes:

```text
PCI configuration-space topology
    -> physical/enumeration truth

ACPI device topology
    -> platform semantics and firmware-described behavior
```

Linux can discover ordinary PCI endpoints through standard PCI enumeration, while ACPI may additionally describe devices for platform functions such as power management, hotplug, or interrupt routing. [4]

Canonical ACPI must not fabricate the disappearance of physically enumerated bridges.

### 14.2 GPU endpoint normalization

For GPU configurations involving intermediate bridges, virtual bridge representations, or unusual slot topology, Platform Compiler may normalize ACPI semantics around the verified GPU endpoint and its platform role.

The goals are:

- preserve real PCI enumeration;
- preserve required bridge windows and bus ranges;
- identify the real GPU endpoint;
- analyze the entire upstream PCIe path;
- associate platform semantics with the verified object that owns them;
- avoid treating an unrelated intermediate bridge as the semantic GPU endpoint;
- reconcile ACPI power methods with Linux runtime/device behavior.

Conceptually:

```yaml
gpu_endpoint:
  preserve_pci_enumeration: true
  preserve_bridge_resources: true
  identify_verified_endpoint: true
  analyze_upstream_path: true
  normalize_acpi_platform_semantics: true
```

### 14.3 Runtime power management is separate from naming

Renaming or restructuring an ACPI GPU object is accepted only when it changes or clarifies verified semantics.

If a GPU problem is caused by Linux runtime-PM or PCIe link policy rather than ACPI representation, Platform Compiler must generate an appropriate Linux runtime policy instead of forcing DSDT to solve the wrong layer.

---

## 15. Runtime Investigation Requirement

Canonical ACPI generation is not purely static.

ADR-001 defines the LLM-assisted runtime investigator. ADR-002 requires ACPI transformations to consume its evidence where runtime semantics are relevant.

Possible evidence includes:

- ACPICA method traces;
- AML opcode traces;
- kernel ACPI diagnostics;
- PCI resource state;
- device runtime-PM state;
- upstream PCI bridge state;
- IRQ activity;
- driver behavior;
- NUMA/device locality;
- controlled A/B measurements.

The LLM may request additional observations, but it cannot itself promote a correction to verified status.

---

## 16. Transformation Workflow

The canonical workflow is:

```text
Capture OEM ACPI
      |
      v
Assemble joint namespace
      |
      v
Capture target hardware/resources
      |
      v
Select primary reference
      |
      v
Runtime investigation
      |
      v
Classify reachable defects
      |
      v
Generate targeted correction
      |
      v
iASL structural validation
      |
      v
Sandbox/semantic validation
      |
      v
Blind semantic diff review
      |
      v
Controlled runtime verification
      |
   +--+--+
   |     |
 reject  verified
           |
           v
 Canonical Platform ACPI
```

---

## 17. Correction Record

Every accepted correction should be stored with its evidence.

Conceptual record:

```yaml
correction:
  id: "..."
  class: "resource_range | irq | hpet | rtc | lpc | osi | gpu | other"

  target:
    platform_id: "..."
    firmware_id: "..."
    source_table_hashes: []

  problem:
    observed: "..."
    reachability: DEFECTIVE_REACHABLE

  evidence:
    static: []
    runtime: []
    references: []

  semantic_change:
    objects: []
    description: "..."

  preservation_constraints: []

  verification:
    compile: passed
    semantic: passed
    runtime: passed

  provenance:
    tool_versions: {}
    model_records: []
```

The correction record, not the patch alone, is the reusable knowledge unit.

---

## 18. Firmware and Platform Invalidation

Canonical ACPI belongs to a specific verified platform state.

Relevant changes may invalidate previous evidence, including:

- firmware update;
- DSDT/SSDT hash change;
- CPU/socket topology change;
- memory topology change;
- material PCIe topology change;
- replacement of a device whose ACPI/resource semantics were part of a correction.

Invalidation does not automatically imply every correction is wrong. It means affected evidence must be re-established before regeneration.

Binary or textual corrections are never silently applied to a changed source table solely because the motherboard model is the same.

---

## 19. Delivery Policy

### 19.1 No firmware flashing requirement

Canonical ACPI is delivered through the controlled boot environment. Permanent modification of motherboard firmware is not required.

The Linux ACPI table-upgrade mechanism provides an official path for replacing or adding ACPI tables via initrd when the relevant kernel options are enabled. [1]

### 19.2 Boot implementation is replaceable

The exact mechanism used to deliver the verified ACPI environment may evolve.

Possible implementation choices belong to the boot architecture, not to the semantic definition of Canonical Platform ACPI.

The invariant is:

```text
OEM firmware remains recoverable
Canonical ACPI is reproducible
Canonical ACPI is bound to verified platform evidence
```

---

## 20. Recovery Policy

The recovery path remains simple:

```text
standard distribution kernel/environment
```

Recovery does not depend on Canonical Platform ACPI being valid.

The production environment may be highly machine-specific; recovery remains conventional.

---

## 21. LLM Responsibilities

The LLM subsystem may:

- analyze target ACPI and runtime evidence;
- compare target and reference semantics;
- identify relevant differences;
- propose localized or coherent multi-object corrections;
- generate ASL;
- explain required dependencies;
- request additional evidence;
- define expected semantic changes;
- propose verification requirements.

The LLM subsystem may not:

- mark its correction verified;
- silently copy target-independent constants from a reference platform;
- install modified ACPI directly into production;
- bypass compilation or runtime verification;
- repair unreachable code solely for cleanliness.

---

## 22. Deterministic Verifier Responsibilities

The verifier owns acceptance gates.

At minimum it should evaluate, as applicable:

```text
source-table identity
joint namespace completeness
compiler errors
classified warnings
resource ownership
resource overlap
expected-device presence
expected semantic delta
unexpected semantic delta
sandbox execution results
runtime diagnostics
runtime method behavior
PCI enumeration stability
required device functionality
```

A model cannot override a failed mandatory gate.

---

## 23. Evidence Hierarchy

ADR-002 does not define one universal total order among evidence sources. Instead it assigns authority by question.

### Physical facts

Prefer direct target-machine evidence.

### ACPI semantics

Use target tables, runtime execution, specifications, Linux behavior, and reference implementations together.

### Expected runtime behavior

Use reproducible target observations and controlled A/B results.

### Implementation pattern

Use verified reference platforms and prior verified project corrections.

### Acceptance

Use deterministic gates plus controlled runtime verification.

---

## 24. Consequences

### 24.1 Positive

- ACPI becomes a controlled machine-specific build artifact.
- Known firmware defects can be corrected once at the platform-description layer.
- Manual DSDT adaptation is reduced.
- Reference dumps become structured engineering assets rather than informal examples.
- Runtime evidence can distinguish meaningful defects from dormant ones.
- Windows-specific compatibility paths do not need to dominate a canonical Linux-only environment when a different path is fully verified.
- GPU/PCIe peculiarities can be analyzed as endpoint plus upstream-path semantics without falsifying physical PCI enumeration.
- Accepted corrections remain reproducible and attributable.

### 24.2 Negative

- ACPI validation becomes part of the trusted build pipeline.
- Firmware updates can invalidate verified work.
- Reference-platform comparison requires careful separation of semantics from hardware constants.
- Runtime validation increases implementation complexity.
- Incorrect resource or power-method transformations can make a production image unusable, which makes mandatory verification essential.

These costs are accepted because Canonical Platform ACPI is intended to remove machine-specific firmware ambiguity before the production kernel and runtime policies are generated.

---

## 25. Rejected Alternatives

### 25.1 Treat OEM DSDT as immutable

Rejected because the project explicitly targets machine-specific firmware normalization and has verified use cases requiring ACPI correction.

### 25.2 Apply generic Hackintosh patch sets

Rejected because the project uses Hackintosh/OpenCore knowledge as engineering reference, not as an unconditional recipe database.

### 25.3 Copy the MacPro7,1 DSDT wholesale

Rejected. The reference platform supplies semantic patterns; target hardware supplies physical facts and constants.

### 25.4 Keep all Windows compatibility behavior by default

Rejected as a canonical requirement. Windows-specific paths may remain as raw firmware behavior, but the production personality is selected from the path verified for the canonical environment.

### 25.5 Remove or hide physically enumerated PCI bridges

Rejected. PCI configuration-space topology remains physical/enumeration truth.

### 25.6 Fix every warning or dormant bug

Rejected. Production relevance and reachability control repair scope.

### 25.7 Flash modified ACPI into motherboard firmware

Rejected as a normal delivery mechanism. Canonical ACPI belongs to the reproducible boot environment.

### 25.8 Let the LLM accept its own DSDT

Rejected. Generation and verification are separate trust domains.

---

## 26. Open Questions

ADR-002 intentionally does not freeze:

- final on-disk Reference Platform Library layout;
- reference-selection scoring algorithm;
- final Canonical ACPI metadata schema;
- exact UNIX/BSD personality-selection implementation;
- the final set and semantics of required HPET methods;
- final RTC normalization rules;
- final LPC transformation rules;
- GPU endpoint normalization rules by hardware family;
- exact runtime-PM policy boundary between ACPI and Linux runtime configuration;
- warning-classification policy for iASL;
- exact sandbox test suite;
- exact boot-time ACPI delivery mechanism;
- mandatory runtime tests for each correction class.

These require platform evidence and later implementation ADRs.

---

## 27. Decision Summary

Platform Compiler adopts **Canonical Platform ACPI** as the verified firmware-description layer visible to the production Linux environment.

For the initial platform:

```text
Primary ACPI semantic reference
    -> MacPro7,1 project dump

Physical truth
    -> target machine

Runtime truth
    -> measured and traced target behavior

Compiler and ACPI tooling
    -> ACPICA / iASL / AcpiExec

Transformation intelligence
    -> ADR-001 LLM runtime investigator and repair roles

Acceptance
    -> deterministic verification + controlled runtime validation

Delivery
    -> reproducible boot-time ACPI replacement/augmentation

Recovery
    -> standard distribution environment
```

Version 1 focuses on:

```text
resource ranges
legacy IRQ ownership
HPET
RTC
LPC
verified UNIX/BSD-oriented production personality
PCI/GPU endpoint and upstream-path semantics
```

The defining invariant is:

> **Canonical Platform ACPI describes the verified target machine and its production execution path. Reference platforms teach the system how a responsibility may be expressed; only target evidence determines what the target machine actually is.**

---

## References

1. Linux Kernel documentation, *Upgrading ACPI tables via initrd*.
2. Intel, *Overview of ACPI Component Architecture (ACPICA)*.
3. ACPICA project, *Getting Started* and validation guidance.
4. Linux Kernel documentation, *ACPI considerations for PCI host bridges*.
5. Linux Kernel documentation, *ACPI _OSI and _REV methods*.
