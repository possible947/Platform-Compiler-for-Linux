# Dual Xeon Gold 6248 Target Requirements

This document records **requirements**, not measured outcomes. See
[observations](observations.md) for empirical operator measurements and
[experiments](experiments.md) for unresolved investigations.

## Platform requirements

- Hyper-Threading **must be disabled in firmware/BIOS** for target 1. This is a
  hard requirement, not a scheduler workaround.
- The current materialization objective is a custom kernel configuration,
  system configuration, and custom TuneD profile.
- Retain the stock Linux scheduler. Use native mechanisms, CPU groups,
  priorities, affinity, and NUMA placement as justified by evidence.
- Preserve useful CPU workload performance without unacceptable degradation
  of memory, I/O, or overall system/peripheral responsiveness.
- Treat CPU, memory, cache/interconnect, and I/O/PCIe as coupled platform
  resources competing within package/system power and thermal limits.
- Evaluate policy using useful workload throughput together with
  memory/NUMA behavior, shared-resource behavior where measurable, I/O,
  responsiveness, power, and temperature.
- Evaluate combined CPU+I/O load; CPU-only results are insufficient for
  accepting a platform policy.
- Derive the target TuneD profile from effective parameters and measured
  effects, not by blindly merging profile files.

The existing target inventory describes the captured platform topology in
[`preparation/x11d-16d-dual-xeon-g6248/step-01-platform-specification/report.md`](../../../preparation/x11d-16d-dual-xeon-g6248/step-01-platform-specification/report.md).
It is evidence for observed inventory, not a current policy specification.
