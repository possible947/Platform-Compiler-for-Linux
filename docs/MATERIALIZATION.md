# Materialization

Platform Compiler turns verified target requirements into three mandatory
outputs:

```text
Kernel configuration
  + System configuration
  + Custom TuneD profile
```

Materialization is not speculative tuning. Inputs must identify the target,
workload, evidence, requirement, and verification criteria. Exact kernel
symbols and runtime values remain unset until evidence establishes them.

## Kernel configuration

The Kernel Configurator transforms verified platform requirements into the
required Kconfig capability set and `.config`. A custom kernel configuration
is mandatory for the current optimization architecture. This document does
not prescribe symbols before project evidence establishes them.

## System configuration

The System Configurator may materialize verified target-specific static or
runtime policy through native mechanisms, including:

- NUMA and memory policy;
- CPU groups, priorities, and affinity where required;
- IRQ and device locality;
- PCIe/I/O policy;
- sysctl settings and boot parameters;
- service/systemd configuration;
- other verified kernel or system mechanisms.

Only settings with a defined requirement and verification method should be
materialized.

## Custom TuneD profile

The TuneD materializer creates the target-specific profile from measured
parameter/effect relationships. It may use inheritance and overrides where
appropriate. The result is not a blind merge of existing profiles: effective
parameters, resulting state, and workload effects must be measured.

## Verification loop

```text
materialize
  -> apply
  -> run the same Platform Analyzer scenarios
  -> compare with baseline
  -> accept / revise / rollback
```

The Platform Control Tester separately verifies that intended configured
state is in effect. Behavioral acceptance still requires analyzer measurements
and workload outcomes. Preserve the baseline, candidate configuration,
scenario, and provenance for each comparison.
