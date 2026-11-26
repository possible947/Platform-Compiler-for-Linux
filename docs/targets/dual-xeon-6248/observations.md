# Dual Xeon Gold 6248 Target Observations

The values below are approximate developer/operator measurements on the
specific target in referenced experiments. They are not universal properties
of Intel CPUs, Linux, or the named TuneD profiles. Test conditions, workload,
measurement tooling, and profile state may differ; repeat measurements under a
controlled common protocol before drawing causal conclusions.

## Observation history

The operator reports approximately three months of observation using Ubuntu
and Fedora, system tools, and a purpose-built CPU monitor using the Intel PCM
library. The monitor source and its integration have not been evaluated in
this repository. A Hackintosh installation using macOS 12 and identifying as
MacPro7,1 was also prepared, run, and briefly tested as a comparison.

The operator cannot provide the original measurement data for these
observations. The descriptions and approximate values in this document are
operator-reported evidence, not reproducible measurement artifacts; the
specific operating conditions and tools for each value are not established.
The macOS comparison does not establish a cause or an equivalent controlled
Linux/macOS workload comparison.

## Hyper-Threading disabled

The operator reports that disabling HT in firmware restores or substantially
improves expected CPU operating steps in tested inference workloads:

- Referenced non-AVX-512 CPU inference: approximately ratio 32 / 3200 MHz.
- Referenced AVX-512 CPU inference: approximately ratio 25 / 2500 MHz.
- Referenced socket power: approximately 125/130 W.
- Temperature: below approximately 55 C using the developer's
  hardware-oriented monitor.
- Socket loading was observed to be more even.

These observations support the separate hard BIOS requirement; they are not a
general scheduling rule or a guarantee for other workloads.

The stored platform inventory reports HT enabled (two threads per core, 80
logical CPUs) in its point-in-time capture. That inventory is a separate
platform-state snapshot, not evidence that the required HT-off state is
currently applied; see the linked [inventory report](../../../preparation/x11d-16d-dual-xeon-g6248/step-01-platform-specification/report.md).

## TuneD profile observations

| Profile/reference | Target observation |
| --- | --- |
| `hpc-compute` | Idle approximately 70-75 W per socket. Under heavy CPU load, package power reached approximately 160 W/socket with die temperature around 60 C. Observed/configured behavior disabled automatic NUMA balancing / unwanted memory migration. The system remained more usable under saturation than with `accelerator-performance`, though some multimedia work could still fail or starve. |
| `accelerator-performance` | Idle approximately 45-55 W/socket. CPU-inference comparison showed higher operating points, including approximately 3500/2800 MHz. Severe collateral degradation under CPU saturation included poor NVMe throughput and UI responsiveness. |
| Target-installed Intel C-state-oriented performance profile | Idle approximately 35-37 W/socket. Observed CPU performance was modestly lower than `hpc-compute`, with better observed peripheral/system balance. Candidate reference/donor for peripheral and platform-efficiency behavior. Exact profile name is target-local and not asserted here. |

These are observed associations, not proven parameter-level causes. Profile
inheritance and effective settings must be expanded; see
[TuneD policy research](../../tuned-policy-research.md).

## NUMA and memory

The stored target inventory reports two NUMA nodes with memory on both nodes.
It is a topology capture, not a controlled comparison of inference speed,
power, or thermal behavior under explicit NUMA placement. No quantitative
NUMA-related performance claim is promoted here without a measurement artifact
establishing that result. Characterize explicit placement in the target
[experiment backlog](experiments.md).

## Operator-described storage and workload context

The operator describes Btrfs on SSDs and XFS on rotating disks. The current
inexpensive 1 TB NVMe holds projects, LLM model files, and temporary video
processing files. A future Intel Optane NVMe is intended to replace it; the
operator expects sustained read/write speed independent of drive occupancy
and sees little need to cache it for these uses. The replacement and expected
behavior are not measurements of the current target or a verified cache
policy.

An atypical workload uses segment encoders that read ProRes and write raw
HEVC. The operator proposes this workload, alongside uneven memory topology,
as a candidate explanation for memory and I/O behavior. These are hypotheses
to investigate, not established causes.

## Evidence artifact

The available captured inventory is
[`report.md`](../../../preparation/x11d-16d-dual-xeon-g6248/step-01-platform-specification/report.md),
with machine-readable questionnaire, report, sources, and run metadata beside
it. The inventory was captured separately from the operator measurements
above; do not infer those measurements from the inventory.

The inventory is a candidate with unresolved fields, not a fully verified
platform specification. Its Markdown report and JSON summary report 26
unavailable items, while the Markdown unresolved list and run metadata also
refer to 25; `required_unavailable` in the run metadata may be a different
count. The timestamps in the Markdown report, JSON report, and run metadata
differ, without an explanation in the stored artifacts. The report lists
CPU.032 (TjMax) both as derived and as unavailable. It also labels several
firmware cross-checks consistent while stating that ACPI table contents were
unreadable; those cross-checks need their independent source evidence verified.
The repository includes source descriptions but not the corresponding raw
captures. Do not treat these affected claims as independently verified until
their provenance and status are resolved.
