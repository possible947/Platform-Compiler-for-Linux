# Platform Analyzer / Recorder

The Platform Analyzer/Recorder is the planned hardware-centered measurement
component for controlled platform-policy experiments. Its implementation
direction is compiled C/C++, using the included Intel PCM library as its
primary measurement source and verified direct hardware interfaces where
necessary. Hardware performance-counter access may require privileges;
agents do not perform privileged operations, and root operations are performed
manually by the user.

The analyzer is not Python-based, an LLM component, or a tuner. It captures
measurements; later analysis attributes causes and policy effects.

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

Depending on the included PCM version, target support, and verified interfaces,
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
interconnect-related metrics. The included version's actual APIs and tools are
the implementation source of truth when implementation begins; unsupported
metrics must not be invented.

## Output boundary

Record scenario identity, workload/context, observation interval, measured
values and units, availability/errors, and provenance as supported by the
eventual implementation. No finalized output schema is asserted here. Keep
raw measurements separate from derived interpretations.

> **Analyzer measures. Later analysis attributes causes and policy effects.**

## Relationship to the Control Tester

The [Platform Control Tester](platform-control-tester.md) checks configured
state through direct reads and OS observers. The Analyzer measures shared
resource behavior under controlled workloads. Neither role substitutes for
the other.
