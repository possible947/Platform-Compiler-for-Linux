# ADR: Step 1 Agent Execution Contract

- **Status:** Proposed baseline
- **Decision Type:** Stage execution architecture
- **Project:** Platform Compiler for Linux
- **Applies to:** Step 1 — Platform Specification

## 1. Context

Step 1 must answer one question only:

> **What exactly is this physical platform, and what capabilities do its components expose?**

The normative preparation protocol deliberately isolates Step 1 from user problem reports, goals, preferred fixes, and diagnosis. Step 1 is a technical platform passport, not a tuning or repair pass.

In practice, Step 1 will initially be executed through a lightweight agent harness. The model is expected to perform most of the investigative work itself: inspect the host read-only, inspect captured ACPI artifacts, use shell tools, create deterministic helper scripts, use the repository-local Python environment, and research authoritative technical sources when the execution environment permits it.

A generic repository-wide agent instruction file is not used to define this role. Step 1 must be activated explicitly, so that unrelated development agents do not inherit platform-audit behavior.

## 2. Decision

Step 1 uses a three-part prompt package located in:

```text
prompts/step_1/
```

The package consists of:

```text
ADR-STEP-1-EXECUTION.md
PROMPT.md
HANDOFF.md
OUTPUT-CONTRACT.md
README.md
```

`HANDOFF.md` is the short text intended to be pasted into the agent input field.

`HANDOFF.md` assigns the role and instructs the agent to load and execute `PROMPT.md`.

`PROMPT.md` is the executable Step 1 instruction. It requires the agent to read the normative project documents in `docs/` before investigation and then perform the Step 1 audit.

`OUTPUT-CONTRACT.md` defines the durable result expected from the run.

The documents in `docs/` remain architectural and normative sources. The Step 1 prompt package does not duplicate them wholesale.

## 3. Authority order

For Step 1 execution, instructions are interpreted in this order:

1. explicit safety and execution restrictions of the runtime/harness;
2. `docs/platform-preparation-protocol.md`;
3. this ADR for Step 1 execution mechanics;
4. `PROMPT.md` for the concrete Step 1 procedure;
5. `OUTPUT-CONTRACT.md` for output requirements;
6. the user's run-specific message, provided it does not violate the isolation rules.

If older architecture documents describe a heavier inference orchestration layer, they remain useful design history but do not require Step 1 to implement that layer before the protocol can be exercised.

## 4. Step 1 isolation is mandatory

Step 1 MUST NOT read, request, infer from, or be steered by:

```text
problems.md
goals.md
known target defects
preferred fixes
expected root causes
operator tuning recipes
materialization plans
```

If such information is present in the working directory, the agent must ignore it for Step 1.

The agent may record contradictions discovered independently, but MUST NOT classify them as the cause of a user problem.

## 5. Agent execution model

The Step 1 agent is an investigator with read-only authority over the target platform.

It MAY:

- read host hardware and firmware information;
- read `/proc`, `/sys`, read-only `debugfs` information when already available and safe;
- inspect kernel-exposed hardware identity needed for platform specification;
- inspect captured ACPI tables;
- run read-only identification and inventory commands;
- create temporary analysis files outside authoritative source evidence;
- create and use repository-local `.venv` as permitted by the preparation protocol;
- install Python analysis packages into `.venv` when the execution environment permits it;
- write deterministic Python helpers for parsing, normalization and arithmetic;
- consult authoritative technical sources when network/research tools are available;
- state that a requested property is unknown when it cannot be established.

It MUST NOT:

- alter firmware or NVRAM;
- write PCI configuration space or MSRs;
- change CPU frequency, power, scheduler, NUMA, IRQ, ASPM, runtime-PM or kernel policy;
- load or unload drivers solely for investigation;
- change sysctl/sysfs values;
- install system packages without explicit operator authorization;
- run stress tests or workload experiments as part of Step 1;
- generate or apply DSDT/SSDT corrections;
- diagnose the user's reported problems;
- recommend remediation.

When a command's read-only nature is uncertain, the agent must not run it merely to complete a field.

## 6. Deterministic work before inference

If a result can be parsed or calculated deterministically, the agent should use a deterministic tool or Python helper and reason from its result.

Examples:

- CPU/core/thread topology;
- NUMA membership and distance matrices;
- PCI paths;
- ACPI table inventory and hashes;
- unit conversion;
- cache hierarchy;
- normalized identifiers;
- link capability/current-state extraction;
- file hashes;
- source provenance.

The model must not replace a missing observation with a plausible value from model memory.

## 7. Source policy

For externally documented capabilities, the preferred source order is:

1. primary component/vendor technical documentation;
2. official specification;
3. Linux kernel documentation/source for Linux-visible interfaces;
4. reliable secondary technical documentation when primary information is insufficient.

Reference-platform material is not target evidence.

Step 1 may consult reference material only when the preparation protocol explicitly permits it and only to describe a reference implementation. It must never use similarity to fill an unknown target value.

## 8. ACPI boundary

Step 1 inventories and describes ACPI as platform evidence.

It may establish:

- table inventory;
- signatures, revisions, OEM/compiler metadata;
- hashes;
- successful deterministic disassembly where useful;
- namespace/device identity needed to describe the platform;
- presence of relevant data tables such as SRAT, SLIT, DMAR, MCFG, APIC and HPET.

Step 1 does not decide that an ACPI construct is defective merely because it differs from a specification example or reference platform.

Semantic defect diagnosis belongs to Step 3 unless a structural fact is required simply to state what the platform exposes.

## 9. Current state versus capability

Step 1 may record a current hardware-exposed state when it is required to describe the platform, but it must not drift into Step 2 policy analysis.

For example:

- PCIe maximum link capability is Step 1 data.
- Current negotiated link width/speed may be recorded as an observation.
- Why Linux selected a particular link/power policy is Step 2/3 work.

Likewise:

- HWP capability belongs to Step 1.
- Current EPP policy belongs to Step 2.

## 10. Unknowns and contradictions

Unknown is a valid result.

Use distinct states where applicable:

```text
known
unknown
unavailable
not_applicable
not_collected
conflicting_sources
```

Contradictions must be preserved instead of silently resolved.

## 11. Output

Step 1 produces durable artifacts defined by `OUTPUT-CONTRACT.md`.

At minimum:

```text
report.json
report.md
sources.json
run.json
```

No private chain-of-thought is requested or stored.

## 12. Completion condition

Step 1 is complete when the agent has produced the best evidence-supported platform specification obtainable under the run's permissions and has explicitly recorded unknowns, unavailable evidence, contradictions and limitations.

Completeness does not mean every questionnaire field contains a value.

It means every material field is either supported by evidence or explicitly classified as unresolved.
