# Platform Compiler

Platform Compiler is a machine-specific Linux platform optimization and
materialization system. It uses measured behavior of a real target platform and
real workloads to derive and verify platform configuration.

## What it produces

- Custom Linux kernel configuration
- Target-specific system configuration
- Custom TuneD profile

## Current workflow

```text
Measure
  -> Compare policies / workload behavior
  -> Derive platform requirements
  -> Materialize
  -> Verify with the same measurement system
```

The first target is a dual-socket Xeon Gold 6248 system with explicit
machine-specific requirements. See the [target requirements](docs/targets/dual-xeon-6248/requirements.md)
and [observations](docs/targets/dual-xeon-6248/observations.md).

## Current non-goals

- Custom scheduler; the stock Linux scheduler and native resource controls are
  retained.
- Production LLM runtime or universal LLM harness.
- Generic Linux optimizer or autonomous tuning.
- Benchmark suite or leaderboard as the project goal.
- Automatic ACPI/DSDT repair.

LLMs may assist development and research, but are not part of the production
runtime architecture. ACPI remains a platform evidence and possible
remediation layer, not the center of the optimization model.

## Documentation

- [Architecture](docs/ARCHITECTURE.md) - normative current system model and
  evidence rules.
- [ADR-003](docs/ADR-003-platform-policy-and-measurement-architecture.md) -
  accepted policy and measurement decisions.
- [Materialization](docs/MATERIALIZATION.md) - required outputs and verification
  loop.
- [TuneD policy research](docs/tuned-policy-research.md) - profile comparison
  and experimental method.
- [Platform Analyzer](docs/platform-analyzer.md) - workload measurement role.
- [Platform Control Tester](docs/platform-control-tester.md) - configured-state
  verification role.
- [Dual Xeon Gold 6248 target](docs/targets/dual-xeon-6248/requirements.md) -
  requirements, [observations](docs/targets/dual-xeon-6248/observations.md),
  and [experiments](docs/targets/dual-xeon-6248/experiments.md).
- [Local reference artifact access](docs/reference-platforms.md) - explicit,
  hash-verified reference retrieval boundary.
- [Current system snapshots](docs/current-system-snapshots.md) - behavior and
  limits of the read-only snapshot collector.

Historical architecture documents are retained separately under `docs/legacy/`
and are not current implementation guidance.
