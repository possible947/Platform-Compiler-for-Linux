# TuneD Policy Research

TuneD is the primary runtime policy framework. Existing profiles are policy
references and donors; the goal is a measured custom profile for the target
machine.

The project explicitly rejects the question:

> Which TuneD profile is best?

The research question is:

> Which effective parameter or parameter family changes which hardware/system
> state, and what measurable effect does that state have on CPU, memory, I/O,
> responsiveness, power, and thermal behavior?

## Profiles of interest

- The target-installed Intel C-state-oriented performance profile. Its exact
  installed name is target-local and is not assumed here.
- `hpc-compute`.
- `accelerator-performance`.
- `throughput-performance` as a negative/reference case where useful.

These profiles expose different readiness, performance, and peripheral
tradeoffs; they are not a linear ranking.

## Analysis pipeline

```text
profile source
  -> resolve inheritance
  -> effective configured parameters
  -> effective OS/hardware state
  -> controlled workload measurements
  -> parameter/effect matrix
  -> isolated A/B validation
  -> target custom profile
```

Comparing only top-level `tuned.conf` files is insufficient. Resolve inherited
profiles and plugins, expand their effective parameters, and record the
observed system/hardware state. Then compare controlled measurements across
IDLE, CPU, I/O, and CPU+I/O scenarios.

## Effect dimensions

For each parameter or parameter family, investigate:

- CPU operating state and useful throughput;
- memory/NUMA behavior;
- cache, interconnect, and other shared-resource effects;
- I/O/NVMe/PCIe behavior;
- system/peripheral responsiveness;
- package power and Platform Readiness Cost;
- temperature.

Record configuration, effective state, measured outcomes, context, and
uncertainty separately. A correlation is a hypothesis, not an established
causal effect. Use isolated A/B tests to validate attribution before encoding
it in the custom profile.

## Target comparisons

Compare the target-installed Intel C-state-oriented performance profile,
`hpc-compute`, `accelerator-performance`, and `throughput-performance` under
the same workload and measurement protocol where feasible. Preserve profile
identity and effective inheritance. Do not rank profiles from one metric or
copy settings without an understood requirement and verification method.
