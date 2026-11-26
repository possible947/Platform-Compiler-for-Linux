# Platform Compiler Architecture

This is the normative description of the current system. Platform Compiler
optimizes a specific Linux machine for defined workloads by measuring
hardware/system behavior, comparing policies, deriving requirements, and
materializing verified configuration. It is not a generic Linux optimizer or
benchmark suite.

## Control loop

```text
Target hardware
  -> Platform measurement
  -> Policy experiments
  -> Requirements
  -> Materialization
  -> Verification
  -> New measurements
```

The primary workflow is **measure -> compare policies/workload behavior ->
derive platform requirements -> materialize -> verify with the same measurement
system**. Measurements describe behavior; analysis attributes causes and
policy effects.

## Components and responsibilities

- **Platform Control Tester** verifies configured/control state through
  verified direct reads and OS observers. It answers whether intended settings
  are in effect; see [its component document](platform-control-tester.md).
- **Platform Analyzer/Recorder** measures shared-resource behavior under
  controlled workloads using Intel PCM and verified hardware interfaces; see
  [its component document](platform-analyzer.md).
- **Policy experiment/effect matrix** records profile sources, effective
  parameters, observed state, workload results, and confidence without
  converting correlation into causation prematurely.
- **Kernel Configurator** translates verified platform requirements into a
  required Kconfig capability set and `.config`.
- **System Configurator** materializes verified native Linux runtime/static
  settings.
- **TuneD profile materializer/generator** produces the target-specific TuneD
  profile from measured parameter/effect relationships.
- **Verification loop** reapplies a candidate, repeats the same analyzer
  scenarios, compares against the baseline, and accepts, revises, or rolls back.

The required outputs and transformation boundaries are specified in
[MATERIALIZATION.md](MATERIALIZATION.md).

## Coupled hardware domains

> **A CPU domain does not operate in isolation.**

CPU cores share package power and thermal limits with cache, memory
controllers, interconnect, and I/O/PCIe infrastructure. DMA and peripheral
activity also consume shared resources. Platform quality therefore cannot be
judged by CPU throughput or frequency alone.

Policy evaluation considers at least useful workload throughput,
memory/NUMA behavior, cache and shared-resource behavior where measurable,
I/O/PCIe behavior, system/peripheral responsiveness, package power, and
temperature. The target-level concept [Platform Readiness Cost](#platform-readiness-cost)
captures resources spent maintaining responsiveness/performance before or
alongside useful work.

## Platform Readiness Cost

**Platform Readiness Cost** is the package/system resource cost required to
maintain a selected responsiveness and performance state before or alongside
useful workload throughput. It is a platform-level concept, not merely CPU idle
power. Evaluate it alongside useful work, system responsiveness, power, and
thermal effects; it is not a universal scalar unless an experiment defines a
measurement method.

Machine-specific observed power values belong in
[target observations](targets/dual-xeon-6248/observations.md), not in this
normative definition.

## Evidence hierarchy

- **Observed is not declared:** a specification or configured value does not
  establish runtime behavior.
- **Target evidence is not reference evidence:** references suggest hypotheses
  and mechanisms, not target facts.
- **Specifications inform capability but do not override target observation.**
- **Measurement decides behavioral success:** analysis explains measured
  outcomes; it does not replace them.
- **A difference is not automatically a defect:** relevance to the target
  workload and requirements must be established.
- Preserve provenance, scope, units, uncertainty, and experimental conditions.

The measurement result itself does not attribute causes. Keep raw observation,
derived interpretation, and causal claim distinguishable.

## Runtime policy and scheduling

TuneD is the primary runtime policy framework. Existing profiles are policy
references/donors; a measured, target-specific custom profile is the goal.
Profile names alone do not establish which policy is better.

The stock Linux scheduler is retained. Use existing kernel/system mechanisms,
TuneD, CPU groups, affinity, NUMA placement, and priorities first. A custom
scheduler or sched_ext policy is not a current project goal. Reconsider
scheduling architecture only through a new accepted ADR backed by measured
evidence that native mechanisms cannot express required behavior.

## LLM role

LLMs are development/research assistants only. They may help investigate
evidence or generate hypotheses, but those hypotheses require independent
measurement and verification. No production LLM runtime, universal harness,
or autonomous tuning is required.

## ACPI role

ACPI is a valid platform evidence layer and a possible remediation layer when
measured requirements justify it. It is not the central optimization or
control model, and automatic DSDT/ACPI repair is not a project goal.

## Current target decision

For the first dual-socket Xeon Gold 6248 target, Hyper-Threading must be
disabled in firmware/BIOS. This is a hard target requirement, not a scheduler
workaround. The requirements and operator observations are separated in the
[target documents](targets/dual-xeon-6248/requirements.md).
