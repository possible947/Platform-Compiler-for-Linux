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
keep them local and review them before sharing. The analyzer implements
versioned schemas for its current limited scope; a complete experiment schema
is not yet finalized.

> **Analyzer measures. Later analysis attributes causes and policy effects.**

## Relationship to the Control Tester

The [Platform Control Tester](platform-control-tester.md) checks configured
state through direct reads and OS observers. The Analyzer measures shared
resource behavior under controlled workloads. Neither role substitutes for
the other.
