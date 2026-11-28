# Platform Analyzer / Recorder

The Platform Analyzer/Recorder is the hardware-centered measurement component
for controlled platform-policy experiments. The first implementation stage is
complete for Linux CPU/RAPL and restricted PCM core measurements. The compiled
C++ recorder, tested PCM version, target results, and remaining stages are
described in the [analyzer README](../analyzer/README.md). Further measurement
domains require verification on the target; the first stage does not implement
the full measurement plan below.

Hardware performance-counter access may require privileges; agents do not
perform privileged operations, and root operations are performed manually by
the user.

The analyzer is not Python-based, an LLM component, or a tuner. It captures
measurements; later analysis attributes causes and policy effects.

**Invariant:** The Platform Analyzer is a hardware-resource recorder, not a
performance analyzer. Encoder fps, inference tokens/s and NVMe MB/s are external
experiment metadata supplied by the user; they are never calculated or interpreted
as bottlenecks by the recorder.

## Experiment orchestration

A separate planned orchestration role can automatically run an explicitly
defined workload, coordinate measurement, and collect its result and errors.
It may use command-line applications or a workload library through an
appropriate integration. It does not select or apply platform policies or
attribute causes. Launch only the workloads and write to the working/output
locations explicitly specified for the experiment; do not delete user data
or perform privileged setup autonomously.
Record the relevant state and measurements before, during, and after the
workload as supported by each source.

The target video encoder is a predictable source of CPU, memory, and I/O
load. Its library accepts a working directory, input file, and preset and
manages its own NUMA and CPU affinity settings. The experiment must not
override those settings. Output-file or encoding-quality verification is not
an analyzer task.

Use the operator's existing CPU monitor as a reference for measurement sources
and proven techniques, including counter ownership, conflicts, permissions,
and overhead; it is not an analyzer runtime dependency. Inspect the encoder
library and compare its integration with process isolation; neither
integration is assumed to exist.
See the [target experiments](targets/dual-xeon-6248/experiments.md).

## Required scenarios

- **IDLE** - baseline readiness and resource cost without the target workload.
- **CPU** - CPU-focused workload behavior.
- **I/O** - I/O-focused workload behavior.
- **CPU+I/O** - combined CPU and I/O pressure. This scenario is mandatory
  because CPU-performance policies can degrade NVMe, peripheral, and overall
  system responsiveness.

For the Memory / UPI / IIO contention experiment, use only these stable labels:

- `idle`
- `cpu`
- `gpu`
- `cpu-gpu`

The analyzer does not start or stop any workload. The user starts and stabilizes
it before the fixed measurement window.

Use controlled, repeatable workloads and record their relevant outcome metrics.
The same scenarios and workload definitions must be reused for policy
verification.

## Measurement domains

Depending on the available PCM version, target support, and verified interfaces,
the measurement plan covers:

- CPU core and package behavior;
- memory bandwidth and locality;
- cache/shared-resource behavior;
- local and remote NUMA behavior;
- interconnect;
- IIO/PCIe traffic;
- energy and power;
- C-state/residency where meaningful;
- workload outcome metrics supplied by or associated with the experiment.

Intel PCM is capable of exposing CPU performance/energy, memory bandwidth,
NUMA local/remote accesses, cache-related metrics, PCIe/IIO traffic, and
interconnect-related metrics. The selected version's actual APIs and tools are
the implementation source of truth; capabilities outside the implemented core
scope must be verified before use. Unsupported metrics must not be invented.

## Output boundary

The planned experiment artifacts should retain:

- scenario and run identity, workload parameters and relevant input identity,
  component versions, and the encoder preset and library version where used;
- target and effective system/policy state, experiment conditions, and
  observation and workload start/end times;
- raw measurements with source, timestamps, values, units, availability,
  errors, and provenance; and
- workload completion status, duration, and errors, plus derived summaries
  kept separate from raw data.

Record unavailable information explicitly, rather than fabricating it.
Experiment artifacts can contain sensitive paths or other identifying data;
keep them local and review them before sharing. The analyzer implements versioned schemas for its current limited scope.
For the Memory / UPI / IIO mode, `resource.json` records:

- scenario and measurement interval;
- platform identity and PCM version;
- per-socket DRAM read/write bandwidth;
- per-controller and per-channel DRAM traffic where supported;
- per-socket local/remote memory bytes and, when supported, local-request ratio;
- per-socket/per-link incoming and outgoing UPI traffic and reliable utilization;
- IIO stack traffic and inbound/outbound DMA direction;
- relevant GPU PCI/BDF mapping where topology and device identity agree;
- selected per-socket L3 misses/hits and hit ratio where available;
- optional external workload metadata and explicit limitations.

The fixed metric set is reused without scenario-dependent selection. The user
may supply throughput values as metadata, but the artifact does not calculate
or score application performance.

The resource mode provides a deterministic four-run comparison through
`analyzer compare --idle ... --cpu ... --gpu ... --cpu-gpu ... --output ...`.
It compares each fixed metric across runs and adds `cpu-gpu` minus
`cpu + gpu` for `S3` versus `S1 + S2`. It reports absolute deltas and ratios,
not bottleneck conclusions.

The agent never invokes `sudo`, `su`, `pkexec`, or another privilege escalation
mechanism. If root is required for PCM, the exact command is shown to the user;
the user performs the privileged run and may later provide the resulting artifact.

Example unprivileged/privileged command forms:

```sh
analyzer/build/analyzer record --scenario idle --duration 60 --output <s0-output>
sudo -- analyzer/build/analyzer record --scenario idle --duration 60 --output <s0-output>
sudo -- analyzer/build/analyzer record --scenario cpu --duration 60 --output <s1-output>
sudo -- analyzer/build/analyzer record --scenario gpu --duration 60 --output <s2-output>
sudo -- analyzer/build/analyzer record --scenario cpu-gpu --duration 60 --output <s3-output>

analyzer/build/analyzer compare --idle <s0-output>/resource.json --cpu <s1-output>/resource.json --gpu <s2-output>/resource.json --cpu-gpu <s3-output>/resource.json --output <comparison-output>/resource-delta.json
```

The actual output paths remain under the user's chosen local workspace. The
first unprivileged form may report MSR/PCM access unavailable; it must not
attempt to obtain privileges. Exact privileged examples for the resource mode:

```sh
sudo env PCM_KEEP_NMI_WATCHDOG=1 analyzer/build/analyzer record --scenario idle --duration 60 --output /home/viktor/LLM/analyzer-experiments/resource-s0
sudo env PCM_KEEP_NMI_WATCHDOG=1 analyzer/build/analyzer record --scenario cpu --duration 60 --output /home/viktor/LLM/analyzer-experiments/resource-s1
sudo env PCM_KEEP_NMI_WATCHDOG=1 analyzer/build/analyzer record --scenario gpu --duration 60 --output /home/viktor/LLM/analyzer-experiments/resource-s2
sudo env PCM_KEEP_NMI_WATCHDOG=1 analyzer/build/analyzer record --scenario cpu-gpu --duration 60 --output /home/viktor/LLM/analyzer-experiments/resource-s3

analyzer/build/analyzer compare --idle /home/viktor/LLM/analyzer-experiments/resource-s0/resource.json --cpu /home/viktor/LLM/analyzer-experiments/resource-s1/resource.json --gpu /home/viktor/LLM/analyzer-experiments/resource-s2/resource.json --cpu-gpu /home/viktor/LLM/analyzer-experiments/resource-s3/resource.json --output /home/viktor/LLM/analyzer-experiments/resource-delta.json
```

The capability audit and exact source/API mapping are maintained in
[`analyzer/CAPABILITY-AUDIT.md`](../analyzer/CAPABILITY-AUDIT.md).

> **Analyzer measures. Later analysis attributes causes and policy effects.**

## Relationship to the Control Tester

The [Platform Control Tester](platform-control-tester.md) checks configured
state through direct reads and OS observers. The Analyzer measures shared
resource behavior under controlled workloads. Neither role substitutes for
the other.
