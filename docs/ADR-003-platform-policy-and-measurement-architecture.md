# ADR-003: Platform Policy and Measurement Architecture

- **Status:** Accepted
- **Decision type:** Architecture

## Context

Platform Compiler's earlier proposed production architecture centered on
preparation workflows, production LLM inference, ACPI transformation, and a
custom topology-aware scheduler. The current target instead requires a
measured platform optimization loop with concrete configuration outputs and
policy evaluation across CPU, memory, I/O, power, and responsiveness.

## Decision

1. For target 1, Hyper-Threading **must be disabled in firmware/BIOS**. This is
   a hard platform requirement, not a scheduler workaround.
2. Retain the stock Linux scheduler. Prefer native Linux mechanisms, CPU
   groups, affinity, NUMA placement, and priorities. A custom scheduler is out
   of scope unless new measured evidence and an accepted ADR justify it.
3. Use TuneD as the primary runtime policy framework. Existing profiles are
   measured references/donors; derive a target-specific custom profile rather
   than blindly merging profiles.
4. The mandatory materialization results are a custom kernel configuration,
   system configuration, and custom TuneD profile.
5. The Platform Analyzer/Recorder is a hardware-centered compiled C/C++
   program. Its implementation direction uses the included Intel PCM library
   and verified direct hardware interfaces where required. It measures; it is
   not a Python monitor, LLM component, tuner, or causal-analysis engine.
6. Required analyzer scenarios are IDLE, CPU, I/O, and CPU+I/O. CPU+I/O is
   mandatory because CPU-oriented policies can degrade NVMe, peripherals, and
   system responsiveness.
7. Treat CPU cores as part of a shared package/platform system that includes
   cache, memory controllers, interconnect, PCIe/I/O, and DMA activity, under
   finite power and thermal limits.
8. Judge profile quality by useful workload behavior and collateral platform
   cost, including memory/NUMA, shared resources, I/O, responsiveness, power,
   and thermal effects - not CPU throughput alone.
9. Production LLM orchestration, autonomous LLM tuning, and a custom scheduler
   are removed from current goals. LLMs remain development/research tools.

## Rationale

The first target's operator measurements show that CPU behavior and peripheral
responsiveness can trade off under load. A valid policy must therefore be
evaluated under isolated and combined resource pressure. A custom kernel
configuration and system configuration are needed alongside TuneD to express
verified platform requirements beyond profile parameters.

Disabling HT in firmware is an explicit target constraint supported by the
target's operator observations; it must not be recast as a scheduling policy.
Keeping the stock scheduler avoids adding an unproven scheduling mechanism
before native controls are measured. TuneD provides the current runtime policy
framework while leaving profile derivation evidence-driven.

## Consequences

- The previous LLM/preparation/scheduler architecture is historical and is
  retained under `docs/legacy/`, not normative.
- Old preparation prompts are deleted rather than archived; prompts would
  otherwise remain a competing instructional source of truth.
- The analyzer and Control Tester have distinct responsibilities: workload
  behavior measurement versus configured-state verification.
- Target measurements and requirements are kept in separate documents.
- Future architecture changes require new evidence and a new accepted ADR.

## References

- [Current architecture](ARCHITECTURE.md)
- [Target requirements](targets/dual-xeon-6248/requirements.md)
- [Target observations](targets/dual-xeon-6248/observations.md)
- [Materialization](MATERIALIZATION.md)
