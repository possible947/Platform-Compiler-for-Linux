# Platform Analyzer / Recorder

The Platform Analyzer/Recorder is the hardware-centered measurement component
for controlled platform-policy experiments. Its v4 batch recorder combines
Linux CPU/RAPL, PCM core counters, memory/NUMA, UPI, IIO/DMA, GPU topology, and
supported L3 observations in one scenario artifact. Its `record` command also
provides narrowly scoped llama.cpp orchestration so the actual workload
boundaries delimit each resource observation.

Hardware performance-counter access may require privileges. Agents do not
perform privileged operations; the user runs the root command manually, and
the recorder drops launched workloads to the invoking `SUDO_UID`/`SUDO_GID`.

The analyzer is not Python-based, an LLM component, or a tuner. It captures
measurements; later analysis attributes causes and policy effects.

**Invariant:** The Platform Analyzer is a hardware-resource recorder, not a
performance analyzer. Encoder fps, inference tokens/s and NVMe MB/s are external
experiment metadata supplied by the user; they are never calculated or interpreted
as bottlenecks by the recorder.

## Experiment orchestration

The v4 analyzer `record` path is the llama.cpp experiment orchestrator. It
expands a selection, initializes measurement, launches only the configured
CPU/HIP executables, coordinates their real start/end boundaries, and retains
argv, PID, process status, logs, and errors. Combined scenarios launch both
engines concurrently. CPU anchors the measurement: every successful early GPU
completion starts the next GPU pass, while successful CPU completion stops the
current GPU pass and records `termination_reason=cpu_completed`. A failed
engine or restart attempt fails the combined scenario.

This orchestration boundary does not select or apply platform policies,
reconfigure devices, verify model output, or attribute causes. The launched
applications retain responsibility for CPU and NUMA placement. The three `*-numactl` scenarios express that choice through llama.cpp's own
`--numa numactl` option. Every llama.cpp invocation uses `-st` so it completes
one turn and exits. No other workload family is launched by this command.

Use the operator's existing CPU monitor as a reference for measurement sources
and proven techniques, including counter ownership, conflicts, permissions,
and overhead; it is not an analyzer runtime dependency. Inspect the encoder
library and compare its integration with process isolation; neither
integration is assumed to exist.
See the [target experiments](targets/dual-xeon-6248/experiments.md).

## Required scenarios

The stable v4 scenario set and `all` expansion order are:

- `idle` - a fixed-duration baseline without workload children;
- `cpu`;
- `cpu-numactl`;
- `gpu`;
- `gpu-numactl`;
- `cpu-gpu`;
- `cpu-gpu-numactl`.

`--duration` applies only to `idle`. Workload scenarios continue until all
launched llama.cpp processes complete, fail, or receive an interruption.
The canonical CPU/HIP argv is `-m MODEL -p PROMPT -st`; `*-numactl` adds exactly
`--numa numactl`. Combined scenarios use both executables concurrently, repeat
GPU until CPU finishes, and retain each GPU attempt as numbered logs.

Use the same model, prompt and executables for paired default/`numactl` and
combined runs. Application throughput and correctness remain external
metadata, never a score or bottleneck classification.

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

The v4 resource record additionally retains per-core PCM instructions and
cycles, so Linux CPU/RAPL and all PCM resource domains share the same workload
interval. The legacy `analyzer compare --idle ... --cpu ... --gpu ...
--cpu-gpu ... --output ...` remains a deterministic four-run comparison. It
reports absolute deltas and ratios, not bottleneck conclusions.

The agent never invokes `sudo`, `su`, `pkexec`, or another privilege escalation
mechanism. If root is required for PCM, the exact command is shown to the user;
the user performs the privileged run and may later provide the resulting artifact.

Canonical command form:

```sh
sudo env PCM_KEEP_NMI_WATCHDOG=1 analyzer/build/analyzer record \
  --scenario all \
  --model /path/model.gguf \
  --output /path/new-batch-directory \
  --duration 60
```

The same command accepts any single scenario. An unprivileged invocation may
report PCM unavailable; it must not elevate itself or launch a workload after
PCM setup fails. The root process drops llama.cpp children to the original
`SUDO_UID` and `SUDO_GID`.

A v4 output root contains one new `output/<scenario>/` directory per selection.
It may already contain unrelated completed scenarios, but a selected directory
is never overwritten. `batch-manifest.json` is written at the root for
`--scenario all`. Scenario artifacts include `manifest.json`, `resource.json`,
`measurements.jsonl`, `events.jsonl`, `summary.json`, workload status and log
files. The legacy config recorder and four-run comparison remain compatibility
interfaces described in the [analyzer README](../analyzer/README.md).

The capability audit and exact source/API mapping are maintained in
[`analyzer/CAPABILITY-AUDIT.md`](../analyzer/CAPABILITY-AUDIT.md).

> **Analyzer measures. Later analysis attributes causes and policy effects.**

## Relationship to the Control Tester

The [Platform Control Tester](platform-control-tester.md) checks configured
state through direct reads and OS observers. The Analyzer measures shared
resource behavior under controlled workloads. Neither role substitutes for
the other.
