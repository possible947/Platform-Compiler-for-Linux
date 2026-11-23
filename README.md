# Platform Compiler for Linux

> **Status:** Architecture specification / project README  
> **Architecture version:** 0.1

## Overview

**Platform Compiler** is an LLM-assisted, evidence-driven system for constructing a verified, machine-specific Linux execution environment from the actual hardware platform, firmware, and intended workload.

The project does **not** start from an existing Linux kernel configuration and attempt to tune it. Instead, it discovers and models the physical machine, reconciles firmware descriptions with observable hardware and operating-system expectations, and generates the kernel configuration, kernel image, ACPI corrections, boot environment, and runtime resource policies as build artifacts.

The production environment is intentionally **non-portable**. It is compiled for one physical system, one relevant firmware state, one hardware topology, and one workload profile. A material platform change invalidates the affected model and requires regeneration of the corresponding artifacts.

The project therefore treats Linux kernel construction as the **final compilation stage of a platform model**, not as the starting point of system configuration.

---

## 1. Project Goals

Platform Compiler is intended to:

1. Build a canonical, evidence-backed model of a specific physical machine.
2. Detect inconsistencies between hardware reality, firmware descriptions, and Linux expectations.
3. Use LLM reasoning to analyze complex ACPI/AML and platform-specific behavior that cannot reasonably be represented as a finite rule database.
4. Apply only corrections whose applicability to the target platform has been verified.
5. Generate a Linux kernel configuration from the verified platform model rather than inheriting a generic distribution configuration.
6. Compile the kernel specifically for the installed CPU and platform, with no production portability requirement.
7. Generate workload-specific CPU, NUMA, memory, interrupt, and I/O policies.
8. Boot through UEFI without requiring GRUB in the production path.
9. Preserve the distribution's standard kernel as the simple recovery environment.
10. Make all generated artifacts reproducible from stored platform evidence, policies, and source versions.

---

## 2. Non-Goals

The project is explicitly **not** intended to:

- produce a universal Linux kernel;
- preserve binary portability across different machines;
- create a new Linux distribution;
- reproduce macOS behavior by emulating Apple-specific devices;
- blindly apply Hackintosh patches;
- modify motherboard firmware permanently;
- treat an LLM response as evidence of correctness;
- maintain a catalog of unconditional `board -> patch` recipes;
- optimize benchmark scores without linking changes to a defined workload and verified platform behavior.

---

## 3. Fundamental Architecture

```text
                 PHYSICAL MACHINE
                        +
                  OEM FIRMWARE
                        +
                  WORKLOAD MODEL
                        |
                        v
              Hardware/Firmware Scan
                        |
                        v
             Canonical Platform Model
                        |
              +---------+---------+
              |                   |
              v                   v
        ACPI Analysis       Workload Analysis
              |                   |
              +---------+---------+
                        |
                        v
          LLM-Assisted Semantic Analysis
                        +
            Deterministic Verification
                        |
                        v
              VERIFIED PLATFORM MODEL
                        |
       +----------------+----------------+
       |                |                |
       v                v                v
 ACPI Artifacts    Kernel Artifacts   Runtime Policy
       |                |                |
       +----------------+----------------+
                        |
                        v
                 Production Image
```

The central artifact is the **Canonical Platform Model**. Kernel configuration, ACPI output, and runtime tuning are downstream products.

---

## 4. Architectural Principles

### 4.1 The physical machine is the primary input

The target system is a concrete physical machine, not an abstract x86-64 compatibility class.

The platform identity may include:

- CPU vendor, family, model, and stepping;
- microcode state;
- socket/core/thread topology;
- cache topology;
- NUMA topology;
- motherboard identity;
- firmware revision;
- ACPI table identities and hashes;
- memory topology;
- PCI/PCIe topology;
- storage controllers and devices;
- network controllers;
- IOMMU topology;
- interrupt topology;
- other devices relevant to the selected workload.

A material change invalidates only the model components and generated artifacts affected by that change.

### 4.2 Production portability is deliberately zero

A production kernel is built for the target platform and is not required to boot on another machine.

If a significant hardware component is replaced, firmware changes materially, or topology changes, regeneration is expected behavior.

Portability belongs to the distribution recovery kernel, not to the production kernel.

### 4.3 Kernel configuration is an output artifact

The kernel `.config` is generated from the verified platform model.

```text
Canonical Platform Model
          +
     Workload Model
          |
          v
     Kconfig Resolver
          |
          v
       .config
          |
          v
      Kernel Build
```

A Fedora, Ubuntu, or other distribution kernel configuration may be used for comparison, dependency research, or recovery, but it is not the authoritative input to production kernel generation.

### 4.4 Hardware evidence has priority over assumptions

No single software representation is automatically authoritative.

The system compares three major views:

```text
Hardware Reality
       ^
       |
       v
Firmware Description
       ^
       |
       v
Linux Interpretation
```

Contradictions between these views are first-class analysis targets.

### 4.5 ACPI is an engineering description of the platform

DSDT and SSDT content is treated as executable platform description, not as immutable vendor truth.

Relevant objects include, but are not limited to:

- `_HID` / `_CID`;
- `_ADR`;
- `_CRS`;
- `_PRS`;
- `_SRS`;
- `_PRT`;
- `_STA`;
- `_DSM`;
- `OperationRegion` and `Field` definitions;
- interrupt descriptions;
- timer descriptions;
- power-management methods;
- PCI resource descriptions;
- dependencies between AML methods and devices.

A correction is legitimate only when its behavior on the target platform is established by evidence and verification.

### 4.6 ACPI corrections are machine-specific

Corrections belong to an identified firmware/platform state, not merely to a motherboard marketing name.

A firmware update that changes relevant ACPI tables invalidates the corresponding verified correction evidence until the new tables are analyzed.

The project must not silently apply a previous binary patch to a different DSDT merely because the motherboard model is unchanged.

### 4.7 Hackintosh experience is engineering knowledge, not policy

The Hackintosh/OpenCore ecosystem is treated as an important body of practical ACPI engineering experience.

Useful material includes:

- AML analysis techniques;
- resource-reconciliation techniques;
- methods of correcting defective table semantics;
- known classes of firmware errors;
- high-quality ACPI implementations;
- proven approaches to timer, IRQ, power, and resource-description problems.

The project does **not** inherit macOS-specific requirements such as synthetic Apple devices, cosmetic namespace changes, or patches whose only purpose is satisfying macOS expectations.

### 4.8 Apple ACPI may be used as a reference implementation

Suitable Mac Pro and iMac Pro ACPI implementations may be used as high-quality reference material where the underlying hardware architecture and method semantics are relevant.

A method or design may be reused when its applicability to the target platform is established by analysis of:

- inputs;
- outputs;
- namespace dependencies;
- called methods;
- hardware resources;
- register access;
- side effects;
- expected operating-system contract.

The objective is to reuse a verified engineering solution, not to make a PC appear to be a Mac.

### 4.9 Resources are analyzed as graphs and clusters

A device cannot always be understood in isolation.

The system therefore models resource relationships across devices and methods.

Example timer cluster:

```text
Legacy Timer Resource Cluster
    |
    +-- HPET
    +-- RTC
    +-- PIT / timer resources
    +-- IRQ resources
    +-- IOAPIC relationships
    +-- legacy interrupt routing
    +-- related AML methods
```

Equivalent clusters may be built for PCIe, storage, networking, IOMMU, GPU, USB, NUMA, and power-management domains.

This allows the system to identify a resource conflict whose visible symptom occurs on a different device from its actual cause.

### 4.10 LLM reasoning is a core subsystem

A finite rule engine is insufficient for the intended scope of platform analysis.

An engineering-grade LLM may be used to:

- interpret AML;
- correlate kernel diagnostics with ACPI code;
- construct failure hypotheses;
- analyze method dependencies;
- inspect resource conflicts;
- compare OEM and reference implementations;
- analyze relevant Linux driver behavior;
- propose semantically minimal corrections;
- explain the evidence supporting a correction;
- propose verification conditions.

The model may use external API-based inference or an appropriate local inference backend.

### 4.11 The LLM is never the source of truth

LLM output is a proposal.

```text
LLM proposal
     |
     v
Deterministic checks
     |
     v
Evidence validation
     |
     v
Accepted or rejected
```

A plausible explanation, syntactically valid ASL, or high model confidence is not sufficient for acceptance.

### 4.12 Only verified solutions reach production

There is no automated "experimental candidate" production state.

The analysis subsystem may generate and evaluate hypotheses internally. A modification enters the production model only after satisfying the project's verification requirements.

The bootable environments are conceptually simple:

1. **Production**: machine-specific verified environment.
2. **Recovery**: standard unmodified distribution kernel/environment.

### 4.13 Corrections carry evidence

A verified correction is not merely a patch. It is a structured engineering record:

```text
Observed Problem
       +
Supporting Evidence
       +
Identified Mechanism
       +
Correction
       +
Preservation Constraints
       +
Verification Results
```

Previous corrections form an evidence-backed knowledge corpus for future LLM analysis, not an unconditional patch database.

### 4.14 Minimal changes are preferred, not worshipped

A local patch is preferable when it completely corrects the identified problem.

However, if several interdependent devices or methods must be changed to make a resource cluster semantically correct, the system may perform the larger coherent correction.

The governing requirement is **verified semantic correctness**, not the smallest textual diff.

### 4.15 Firmware is not permanently modified

The project does not require flashing a modified DSDT into motherboard firmware.

Corrections are applied in the controlled boot environment so that the OEM firmware remains recoverable and unchanged.

### 4.16 The production boot path is UEFI-native

GRUB is not a required component of the production design.

The intended architecture is:

```text
UEFI Firmware
      |
      v
Platform Boot Environment
      |
      v
Verified ACPI Environment
      |
      v
Machine-Specific Linux Image
```

The exact implementation of the early boot and ACPI delivery layer is a replaceable implementation detail and must not become part of the canonical hardware model.

### 4.17 Platform and workload descriptions are separate

The **Canonical Platform Model** answers:

> What is this machine?

The **Workload Model** answers:

> How will this machine be used?

A single physical platform may therefore support multiple workload profiles without losing the identity of the underlying hardware.

### 4.18 Runtime resource policy is compiled, not manually tuned

Runtime policy is generated from the combination of platform and workload knowledge.

Potential outputs include:

- CPU placement policy;
- socket utilization policy;
- SMT policy;
- NUMA placement;
- memory allocation policy;
- huge-page / THP policy;
- memory reclaim and writeback policy;
- IRQ affinity;
- I/O scheduling policy;
- queue parameters;
- cgroup/cpuset configuration;
- CPU performance and power-management policy.

There is deliberately no universal set of "best sysctl values."

### 4.19 Native CPU optimization is expected

Because the production image is deliberately machine-specific, the kernel may be compiled for the actual installed processor rather than a portable x86 baseline.

Native compiler optimization is one consequence of the architecture, not a substitute for platform modeling or workload-aware resource management.

### 4.20 Generated artifacts must be reproducible

The following should be reproducible from recorded inputs and versions:

- corrected ACPI tables;
- kernel `.config`;
- kernel image;
- initramfs or equivalent boot payload;
- kernel command line;
- runtime configuration;
- resource-management policies.

The authoritative state is therefore the verified model and its evidence, not the generated files themselves.

---

## 5. Canonical Platform Model

The Canonical Platform Model is the central internal representation of the project.

A possible high-level structure is:

```yaml
platform:
  identity: {}
  cpu:
    topology: {}
    capabilities: {}
    cache: {}
    microcode: {}
  memory:
    topology: {}
  numa:
    nodes: []
    distances: []
  pci:
    hierarchy: []
    devices: []
    resources: []
  interrupts: {}
  iommu: {}
  timers: {}
  storage: []
  network: []
  graphics: []
  firmware:
    identity: {}
    acpi_tables: []
  acpi:
    namespace: {}
    resources: {}
    dependency_graph: {}
  verified_corrections: []
```

This format is illustrative, not yet a finalized schema.

The model should distinguish:

- raw observations;
- derived facts;
- hypotheses;
- verified facts;
- corrections;
- provenance;
- verification state.

---

## 6. Workload Model

The Workload Model describes operational intent independently of platform identity.

Example dimensions may include:

```yaml
workload:
  class: workstation
  priorities:
    throughput: high
    latency: medium
    determinism: medium
  cpu:
    placement: topology-aware
    smt: workload-dependent
  memory:
    numa_locality: high
    hugepages: workload-dependent
  io:
    profile: high-throughput
  isolation:
    dedicated_cpu_sets: []
```

The schema should describe intent and constraints rather than hard-code Linux tuning values wherever possible.

---

## 7. LLM-Assisted ACPI Analysis

The LLM should receive structured evidence rather than an unqualified request to "fix the DSDT."

Relevant context may include:

- complete ACPI table dump;
- jointly disassembled DSDT/SSDT namespace;
- compiler diagnostics;
- kernel ACPI diagnostics;
- PCI topology and resources;
- interrupt information;
- IOMMU topology;
- CPU and NUMA topology;
- relevant driver source or documented driver expectations;
- reference ACPI implementations;
- previously verified repair records;
- applicable specifications and constraints.

A conceptual analysis request is:

> Identify contradictions between observed hardware, firmware description, and operating-system expectations. Explain the failure mechanism and propose the smallest semantically complete correction whose assumptions can be verified on this target platform.

The system should prefer structured LLM output containing:

- diagnosis;
- affected objects;
- evidence references;
- inferred mechanism;
- assumptions;
- proposed semantic changes;
- preservation constraints;
- verification requirements.

---

## 8. Verification Model

A correction becomes part of the Canonical Platform Model only when the required evidence supports it.

Verification should occur in multiple stages.

### 8.1 Structural verification

Examples:

- ASL/AML compilation succeeds;
- namespace structure remains valid;
- dependencies resolve;
- no unintended object disappearance occurs;
- generated AML can be compared with its intended source transformation.

### 8.2 Semantic verification

Examples:

- resource ranges correspond to established hardware facts;
- interrupt assignments do not introduce unexplained conflicts;
- relevant method inputs and outputs satisfy their expected contracts;
- register accesses and `OperationRegion` dependencies are understood;
- changes to one resource are reconciled with the complete resource cluster.

### 8.3 Execution-oriented verification

Where applicable, AML behavior should be exercised in an ACPICA-compatible analysis environment before production acceptance.

### 8.4 System verification

The resulting platform description must be reconciled with the behavior of the real target machine and the relevant operating-system components.

The definition of "verified" must ultimately be expressed as explicit machine-readable acceptance criteria for each correction class.

---

## 9. Knowledge Base

The project knowledge base stores **verified mechanisms and solutions**, not folklore.

A conceptual record:

```yaml
trigger:
  platform_identity: {}
  firmware_identity: {}
  observed_symptoms: []

mechanism:
  affected_objects: []
  resource_cluster: null
  explanation: ""

correction:
  semantic_changes: []
  preservation_constraints: []

verification:
  checks: []
  results: []

provenance:
  references: []
  model: {}
  toolchain: {}
```

For a different machine, previous records are evidence and reasoning examples. They are not automatically executable recipes.

---

## 10. Kernel Generation

Once the platform model is verified, kernel requirements can be derived deterministically where possible.

```text
Verified devices
      |
      v
Required kernel subsystems
      |
      v
Required drivers/features
      |
      v
Kconfig dependency resolution
      |
      v
Machine-specific .config
      |
      v
Native compilation
```

The production kernel should include what the platform and workload require, rather than carrying broad support for unrelated hardware solely for portability.

Diagnostic or observability features may still be retained when their value to verification and maintenance justifies them.

---

## 11. Runtime Policy Generation

Kernel specialization alone is not the performance objective.

The system should generate policies informed by actual topology, including CPU/socket/NUMA placement and the locality of I/O resources.

The logical input is:

```text
Canonical Platform Model
           x
      Workload Model
           |
           v
     Runtime Policy
```

This subsystem is responsible for turning topology knowledge into resource-management behavior rather than relying entirely on generic distribution defaults.

---

## 12. Boot and Recovery Model

The normal system should expose two conceptual paths:

### Production

The verified, machine-specific Platform Compiler output.

### Recovery

The ordinary distribution kernel and environment.

Recovery is intentionally simple. It is not another specialized Platform Compiler artifact.

---

## 13. Rebuild and Invalidation Model

Platform changes should trigger targeted invalidation.

Conceptually:

```text
Observed Change
      |
      v
Affected Model Nodes
      |
      v
Invalidate Dependent Evidence
      |
      v
Re-analyze
      |
      v
Regenerate Dependent Artifacts
```

Examples of potentially significant changes include:

- CPU replacement;
- firmware update;
- NUMA topology change;
- memory topology change;
- PCIe topology change;
- storage or network controller replacement;
- changes to relevant ACPI tables.

The dependency graph, not a blanket "reinstall everything" rule, should determine what requires revalidation and rebuilding.

---

## 14. Trust Model

Platform Compiler follows an evidence hierarchy rather than trusting one component absolutely.

### Evidence sources

- directly observable hardware state;
- firmware/ACPI content;
- formal specifications;
- Linux subsystem and driver behavior;
- deterministic analysis tools;
- verified historical repair records;
- high-quality reference implementations;
- LLM reasoning.

### Trust rule

LLM reasoning and reference implementations may explain or propose a solution, but acceptance requires independently testable evidence relevant to the exact target machine.

---

## 15. Security and Privacy Considerations

When external LLM APIs are used, platform evidence should be sanitized before transmission where identifiers are not required for technical analysis.

Candidates for removal or pseudonymization include:

- system serial numbers;
- SMBIOS UUIDs;
- MAC addresses;
- host names;
- user names;
- unrelated log content;
- credentials and API secrets.

LLM access must not imply unrestricted authority over firmware, boot configuration, or production deployment.

---

## 16. Suggested Component Boundaries

A practical implementation may eventually consist of components resembling:

```text
platform-scanner
    Collects raw hardware and firmware evidence.

platform-model
    Builds and stores the canonical hardware/resource graph.

acpi-analyzer
    Parses ACPI, constructs namespace/resource dependencies,
    and correlates them with hardware observations.

llm-engine
    Performs bounded semantic analysis and produces structured proposals.

verifier
    Applies deterministic structural, semantic, and execution checks.

knowledge-base
    Stores verified mechanisms, corrections, evidence, and provenance.

workload-model
    Describes intended system behavior and performance priorities.

kconfig-resolver
    Converts verified hardware requirements into kernel configuration.

kernel-builder
    Builds the machine-specific kernel and associated artifacts.

policy-compiler
    Generates CPU, NUMA, memory, IRQ, and I/O runtime policy.

boot-builder
    Produces the UEFI-native production boot environment.
```

These are logical boundaries, not a commitment to a particular programming language, process model, or repository layout.

---

## 17. Design Invariant

Every major implementation decision should be tested against the following invariant:

> **Does this decision improve the system's ability to derive a verified Linux execution environment from the actual target hardware and workload, or does it merely introduce another generic assumption?**

If it introduces an unnecessary generic assumption, it is probably contrary to the architecture.

---

## 18. Project Definition

**Platform Compiler** is an LLM-assisted, evidence-driven system that constructs a verified canonical model of a specific physical computer and its firmware, reconciles hardware reality with firmware descriptions and operating-system expectations, and compiles that model together with a workload specification into a non-portable, machine-specific Linux execution environment.

Its principal output is not a kernel configuration file.

Its principal output is a **verified platform implementation**, of which the kernel configuration and kernel binary are generated components.

## Development

Create and activate a virtual environment, then install the project and its test
dependencies:

```sh
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -e '.[dev]'
pytest
platform-compiler --help
platform-compiler version
platform-compiler workspace init /path/to/local/workspace
```

Machine-specific evidence, local state, and generated artifacts belong in an
external workspace, not in this Git checkout. See the [developer guide](DEVELOPER_README.md)
and the [inference](ADR-001-LLM-Inference-Architecture.md) and
[canonical ACPI](ADR-002-Canonical-ACPI-and-Reference-Platform-Policy.md) ADRs.

---

## 19. Current Architecture Status

This document defines the project's architectural principles. It intentionally does not yet freeze:

- the Canonical Platform Model schema;
- the LLM provider or model family;
- the internal RPC/API design;
- the implementation language;
- the persistent database format;
- the exact UEFI loader implementation;
- the final verification policy for each ACPI correction class;
- the repository structure.

Those decisions should be derived from, and remain subordinate to, the principles defined above.
