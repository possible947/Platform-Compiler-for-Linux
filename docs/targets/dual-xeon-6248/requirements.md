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

## Memory and storage objectives

- Adapt memory policy to the target's uneven memory topology and access costs.
  Investigate prioritizing faster memory for suitable workloads and using
  slower memory appropriately, based on measured locality and capacity; do not
  assume fixed tiers or a placement policy before characterization.
- Minimize memory use that does not help the target workloads, including
  avoidable storage-cache and read-ahead pressure, while preserving useful
  performance, responsiveness, and data integrity.
- Investigate reducing or avoiding read and write caching for SSD workloads
  where measurement supports it, limiting excessive read-ahead, and tuning
  block I/O parameters for memory efficiency. Distinguish application,
  filesystem, kernel, and device caching and use only controls applicable to
  the measured layer; do not assume all caching can or should be disabled.
- Consider filesystem mount options and `/etc/fstab` where justified. Account
  for the target's Btrfs SSDs and XFS rotating disks separately, and verify
  effective settings, workload effects, and safe rollback.
- Evaluate the planned Intel Optane NVMe separately after installation, using
  its actual device and workload behavior rather than transferring results
  from the current NVMe.
- Consider both uneven memory and atypical streaming video workloads as
  candidate explanations for memory and I/O behavior. In particular, include
  segment encoders reading ProRes and writing raw HEVC in the investigation.
  Neither is an established cause without controlled evidence.

The existing target inventory describes the captured platform topology in
[`preparation/x11d-16d-dual-xeon-g6248/step-01-platform-specification/report.md`](../../../preparation/x11d-16d-dual-xeon-g6248/step-01-platform-specification/report.md).
It is evidence for observed inventory, not a current policy specification.
