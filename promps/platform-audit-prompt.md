# Platform Audit Prompt

## Purpose

This prompt executes **Step 1 — Platform Specification** of the Platform Compiler Preparation Protocol.

The purpose of this step is to answer one question only:

> **What exactly is this physical platform, how is it assembled, and what capabilities do its components expose?**

This is a platform audit and specification pass. It is **not** a diagnosis pass and it is **not** a tuning pass.

---

## Required protocol

Before doing any work, read and obey:

- `docs/platform-preparation-protocol.md`
- `prompts/platform-preparation/platform-audit-report-template.md`

Treat `docs/platform-preparation-protocol.md` as normative when this prompt is ambiguous.

Do not modify either document during the audit.

---

## Strict stage isolation

This is Step 1.

You MUST NOT read or use:

- `problems.md`;
- `goals.md`;
- previous developer hypotheses about root causes;
- proposed fixes;
- reference-platform conclusions intended for later diagnostic stages;
- previous AI diagnoses of this machine.

If these are present in the workspace or repository, ignore them.

The goal is to describe the platform without bias from known complaints or desired solutions.

---

## Allowed inputs

You MAY use:

1. read-only information from the current physical system;
2. existing Platform Compiler snapshots and their manifests;
3. existing captured raw evidence;
4. captured ACPI tables and deterministic ACPI disassembly artifacts;
5. standard read-only Linux hardware interfaces;
6. existing local hardware-identification tools when they do not alter the system;
7. authoritative public technical sources;
8. vendor documentation and datasheets;
9. official specifications;
10. Linux kernel documentation/source when necessary to identify exposed hardware capability.

Do not install software merely to improve the report unless the developer explicitly authorizes it.

Do not change firmware, boot parameters, kernel parameters, runtime policy, governors, affinities, power limits, device state, ACPI state, or system configuration.

---

## Evidence rules

For every material claim, distinguish its basis.

Use these evidence classes:

- `observed_target` — directly observed on this machine;
- `deterministic_derived` — reproducibly derived from target evidence;
- `external_authoritative` — vendor/specification/kernel documentation;
- `external_secondary` — reliable secondary technical source;
- `unknown` — not established reliably;
- `conflicting` — available sources disagree.

Do not convert documentation about what a component *should* support into an observation that the target actually uses or exposes that capability.

Do not convert an LLM inference into observed evidence.

If a fact cannot be established reliably, report it as unknown and state what was checked.

Do not guess missing values.

---

## External research rules

Use external research where it materially improves identification or capability information.

Prefer sources in this order:

1. processor/component manufacturer documentation;
2. official standards/specifications;
3. Linux kernel documentation/source for kernel-visible interfaces;
4. motherboard/platform vendor material;
5. reliable secondary technical material.

Record every external source actually used in the report.

For externally sourced values, record enough source identity to find the source again.

Do not copy marketing claims as engineering facts without qualification.

---

# Audit tasks

## A. Establish platform identity

Determine, where reliably possible:

- system architecture;
- motherboard/platform identity;
- chipset/platform generation;
- BIOS/firmware identity and version;
- UEFI state;
- ACPI revision and table inventory;
- relevant DMI/SMBIOS platform identity;
- whether observed identity fields appear internally consistent.

Do not diagnose suspicious identity or firmware origin in this step. Record inconsistencies only as audit observations.

---

## B. Build the CPU specification

Identify the processors precisely enough for later power/performance analysis.

Record:

### Identity and topology

- exact CPU model;
- family/model/stepping where available;
- microarchitecture/platform generation;
- socket count;
- physical cores per socket;
- logical CPUs;
- SMT topology;
- CPU-to-socket mapping;
- CPU-to-NUMA mapping.

### Frequency capability

Research and record, where authoritative data exists:

- nominal/base frequency;
- maximum turbo capability;
- turbo/frequency envelope by number of active cores when available;
- documented all-core turbo/frequency behavior when available;
- relevant AVX/AVX2/AVX-512 frequency behavior when documented;
- uncore/domain frequency capabilities when authoritative information exists.

The report must include a dedicated **CPU frequency capability table**.

Do not invent intermediate turbo bins if an authoritative table cannot be found.

### Power and thermal capability

Record where reliably available:

- nominal TDP;
- documented package power behavior/limits;
- relevant configurable power-limit capability;
- thermal limit/TjMax where authoritative;
- package/core/uncore/DRAM power domains when relevant.

### CPU performance-control capability

Record capability, not current Linux policy:

- Turbo Boost;
- EIST/P-state support;
- HWP support;
- CPPC capability where relevant;
- relevant performance-control interfaces;
- idle-state capability at a useful summary level.

### CPU structure

Record:

- cache hierarchy;
- LLC relationship;
- socket interconnect/UPI topology and capability where available;
- memory-controller/channel topology where available.

---

## C. Build the memory specification

Determine:

- total installed memory;
- memory per NUMA node;
- memory-controller topology;
- channel topology;
- populated channels where knowable;
- DIMM identity/specification where safely available;
- current module speed/capability when distinguishable;
- documented theoretical bandwidth information where it can be established without speculation.

Keep installed configuration separate from theoretical processor/platform capability.

---

## D. Build the NUMA specification

Record:

- NUMA node count;
- CPU membership per node;
- memory per node;
- distance matrix;
- socket-to-node relationship;
- important PCI/I/O locality relationships that can be established deterministically.

---

## E. Build the PCIe and I/O specification

Describe platform I/O architecture rather than dumping raw `lspci` output.

Record:

- PCI domains/root complexes/root buses;
- host bridges and important upstream bridges;
- major PCIe endpoints;
- GPUs;
- NVMe/storage controllers;
- network controllers;
- USB and external-I/O controllers where relevant;
- device BDF;
- vendor/device identity;
- device NUMA locality where known;
- PCIe maximum link capability;
- currently negotiated link characteristics when observable;
- major upstream path for important endpoints;
- IOMMU capability/topology where observable;
- relevant DMA/remapping capability.

A raw inventory may be referenced as evidence, but the report must contain a concise architectural summary.

---

## F. Build the firmware/ACPI inventory

This stage inventories ACPI and firmware interfaces only.

Record:

- DSDT;
- boot SSDTs;
- additional AML-bearing tables;
- SRAT;
- SLIT;
- DMAR;
- MCFG;
- APIC;
- HPET;
- FADT/FACP;
- other tables relevant to topology, resources, power, I/O or processor control.

For each relevant table record, where available:

- signature/name;
- OEM ID;
- OEM table ID;
- revision;
- length;
- captured state;
- capture/evidence reference;
- deterministic derived representation, if one already exists.

Do NOT determine whether the table is defective.

Do NOT recommend ACPI patches.

Do NOT compare the target against MacPro7,1 or another reference platform in this step.

---

## G. Establish important component capability summaries

For major components that are likely to matter later, write a concise capability summary.

Examples include:

- CPU package;
- memory subsystem;
- root PCIe/IIO topology;
- GPUs;
- high-speed storage;
- high-speed networking;
- external-I/O controller complex;
- interrupt/IOMMU architecture.

Do not turn this into diagnosis or tuning advice.

---

## H. Resolve contradictions and unknowns conservatively

When local evidence and external sources disagree:

1. preserve both values;
2. label the conflict;
3. state the source of each value;
4. do not silently choose whichever value seems more plausible.

When a value is unavailable:

- record it as `unknown`, `unavailable`, `not_collected`, or `not_applicable` as appropriate;
- note what source/interface was checked;
- identify whether the missing value is likely to matter to later stages.

---

# Prohibited analysis

This stage MUST NOT:

- diagnose performance problems;
- interpret user complaints;
- read `problems.md`;
- read `goals.md`;
- propose Linux tuning;
- recommend governors;
- recommend scheduler changes;
- recommend NUMA policy;
- recommend kernel parameters;
- recommend kernel config changes;
- recommend ACPI changes;
- classify ACPI methods as broken merely because they look unusual;
- infer a donor motherboard/firmware origin;
- use Hackintosh/macOS history to bias the audit;
- propose a materialization plan.

If something looks suspicious, record the underlying fact neutrally and leave interpretation for Step 3.

---

# Required outputs

Use the report structure defined in:

`prompts/platform-preparation/platform-audit-report-template.md`

Write the completed audit only under the preparation workspace for this case.

Preferred output set:

```text
<workspace>/preparation/<case-id>/step-01-platform-specification/
    report.md
    report.json
    sources.json
    run.json
```

If the current harness cannot safely produce all four files, `report.md` is mandatory and must contain the complete audit in the prescribed structure. Record the missing machine-readable artifacts explicitly rather than pretending they were created.

Do not write target-specific audit output into the Git repository.

---

# Report quality requirements

The final report must be useful as a frozen input to later stages without requiring the next agent to repeat basic hardware research.

It must:

- be specific to the actual target machine;
- distinguish installed state from theoretical capability;
- distinguish target observation from external specification;
- contain sources;
- contain unknowns;
- contain conflicts;
- contain the CPU frequency capability table;
- contain enough topology information for later CPU/NUMA/PCI/ACPI analysis;
- avoid problem diagnosis and tuning recommendations.

Do not optimize report length at the expense of useful specification data.

Do not include private chain-of-thought.

---

# Completion checklist

Before finishing, verify:

- [ ] `docs/platform-preparation-protocol.md` was read.
- [ ] The report template was followed.
- [ ] `problems.md` was not used.
- [ ] `goals.md` was not used.
- [ ] CPU identity/topology is documented.
- [ ] CPU frequency capability table is present.
- [ ] CPU power/thermal capability is documented or explicitly unknown.
- [ ] Memory/NUMA topology is documented.
- [ ] PCIe/I/O architecture is documented.
- [ ] Firmware/ACPI inventory is documented without diagnosis.
- [ ] Important unknowns are explicit.
- [ ] Conflicting sources are explicit.
- [ ] External claims have sources.
- [ ] Installed state and theoretical capability are separated.
- [ ] No fixes or tuning advice are present.
- [ ] Output was written only to the approved external workspace location.

Finish after writing the Step 1 artifacts.

Do not start Step 2.
