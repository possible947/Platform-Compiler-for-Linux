# Platform Analyzer / Recorder

## Status

The first implementation stage is complete within the CPU/RAPL and restricted
PCM core-only scope. The Linux recorder reads `/proc/stat`
and Linux RAPL powercap, writes version 1 local artifacts, and computes CPU
load and, when explicitly bounded, RAPL power. An optional PCM core backend
records per-CPU instructions and cycles via Linux perf in version 2 artifacts.
The operator's root test passed and a five-pair Phi-4 CPU workload experiment
completed on the target. The experiment provides an initial overhead observation with
substantial variability, not a proof of negligible impact or an accepted
threshold. A separate read-only PCM MSR diagnostic also passed.
Memory bandwidth, NUMA, UPI and IIO collection,
workload orchestration, and policy-state verification are not implemented.

The current project contract is documented in
[Platform Analyzer](../docs/platform-analyzer.md) and the
[architecture](../docs/ARCHITECTURE.md). Where this draft leaves a decision
open, it does not establish a new project-wide requirement.

## Purpose and boundaries

The analyzer records platform behavior before, during, and after a defined
workload or idle observation. Its measurements support later comparison of
platform policies on the same target and under the same scenarios.

The analyzer does not select or apply policies, launch workloads, verify
encoder output, or attribute causes. A separate experiment orchestrator can
run explicitly selected workloads, preserve their own CPU and NUMA placement,
coordinate measurement boundaries, and record workload results. The Platform
Control Tester separately verifies configured and effective control state.

The external CPU Monitor is a reference for measurement sources and techniques,
not an analyzer runtime dependency. Reuse individual C code only after checking
its behavior, timing, ownership, and applicable permissions and licensing.

## Source layout

```text
analyzer/
  README.md
  ARTIFACTS.md    Version 1 and 2 artifact and configuration contract
  ROOT_TEST.md    Manual target root-test instructions and observations
  OVERHEAD_TEST.md  Phi-4 overhead experiment and observations
  CMakeLists.txt
  examples/       Example configurations
  experiments/    Explicitly selected experiment scripts
  src/
    cli/          Command-line parsing and entry point
    session/      Measurement lifecycle, scheduling, and event boundaries
    collectors/   PCM and Linux measurement sources
    recording/    Artifact writing and completeness status
    summary/      Derived results, separate from observations
  tests/          Unit and integration tests
  third_party/    Copied Intel PCM source and prebuilt library
```

The CLI, session, Linux collectors, and delta calculations are implemented.
Other collection domains remain planned.

## Implementation direction

Implement the analyzer in compiled C++, using Intel PCM as the primary
hardware measurement source and verified Linux or direct hardware interfaces
where appropriate. Keep collectors independent so an unavailable source does
not silently suppress other observations. Record each source's scope,
availability, errors, and provenance.

Current and planned collector domains, subject to target and interface support:

| Domain | Candidate sources | Important boundary |
| --- | --- | --- |
| CPU | `/proc/stat` | Implemented per-CPU raw counters and load; OS-visible only |
| CPU performance counters | Intel PCM and Linux perf | Optional restricted core-only mode; short root test passed on target |
| Energy and power | Linux RAPL powercap | Implemented energy; power requires an operator-supplied bound |
| Cache, NUMA, memory bandwidth, interconnect, IIO/PCIe | Intel PCM | Planned; events and compatibility must be verified |
| Temperature and residency | PCM, hwmon, or other verified interfaces | Planned; sensor scope and source must be preserved |
| Memory, block I/O and pressure | Linux `/proc` and sysfs | Planned; derived averages are not latency distributions |

Where PCM exposes only a calculated metric, identify it as such instead of
claiming it is a raw hardware counter. Never fabricate unsupported values.

### Time and sampling

- Record UTC time for correlation and monotonic time for durations and deltas.
- Timestamp each `/proc/stat` snapshot and RAPL energy read; sequential reads
  are not a simultaneous platform snapshot.
- Use the first counter reading as a baseline. Reject counter decreases and
  unsafe RAPL intervals instead of assuming wraparound or a reset.
- Distinguish the requested sampling interval from actual elapsed time and
  record missed or delayed samples.

### Counter ownership and privileges

Programming hardware performance counters can change PMU state: the analyzer
is not a purely read-only tool. Establish one owner for each counter set,
detect conflicts, and report unavailable or incompatible events. Do not reset
another process's counters or automatically change the NMI watchdog, system
policy, device permissions, or kernel settings. Verify the selected PCM
version's initialization and cleanup behavior before relying on it.

Some sources require privileges. Any privileged setup is performed manually
by the user; the analyzer and development agents must not elevate themselves
or change permissions autonomously. Record permission failures and continue
where other requested sources can still provide meaningful observations.

## Dependencies and build

Requirements: Linux, a C++17 compiler, CMake 3.16 or newer, pkg-config, and
libsystemd development headers with `sd-json` (pkg-config `libsystemd >= 254`).
The recorder links dynamically to libsystemd, distributed under LGPL-2.1-or-later.
`numactl`, `fio`, and workload applications are optional experiment or
orchestration tools, not analyzer dependencies.

Build and run tests from the project root:

```sh
cmake -S analyzer -B analyzer/build -DCMAKE_BUILD_TYPE=Debug
cmake --build analyzer/build --parallel 2
ctest --test-dir analyzer/build --output-on-failure
```

The copied PCM tree identifies itself as `abb6bce8` (2026-04-09) and carries
its BSD-3-Clause license in `third_party/pcm/LICENSE`. The prebuilt archive is
copied from the external monitor and is not used by the default analyzer build;
its source/build correspondence and portability are not established. The local
PCM copy adds a Linux-only read-only `MsrHandle` constructor and a restricted
analyzer core-only mode. The latter uses read-only MSR handles, skips RDT,
uncore, energy initialization and the write-based microcode probe, does not
change watchdog or MSR driver settings, and refuses direct PMU fallback. It
supports Intel family 6 model 85 only. Rebuild the library from this local
source for the PCM backend and MSR diagnostic. PCM's
optional `simdjson`, `pugixml`, and `googletest` sources were absent in the
copied tree. The static library builds without them on the tested host:

```sh
cmake -S analyzer/third_party/pcm -B analyzer/build/pcm \
  -DPCM_BUILD_EXECUTABLES=OFF -DCMAKE_BUILD_TYPE=Release
cmake --build analyzer/build/pcm --target PCM_STATIC_SILENT --parallel 2
cmake -S analyzer -B analyzer/build \
  -DANALYZER_PCM_LIBRARY="$PWD/analyzer/build/pcm/src/libPCM_STATIC_SILENT.a"
cmake --build analyzer/build --parallel 2
ctest --test-dir analyzer/build --output-on-failure
```

Without `ANALYZER_PCM_LIBRARY`, the recorder builds without PCM and reports
the source as unsupported when requested. With the local library configured,
`pcm_enabled` opts in to the restricted PCM backend. The example configuration
is [pcm.json](examples/pcm.json). The read-only MSR and kernel-perf checks
and the extended manual root scenario are described in [ROOT_TEST.md](ROOT_TEST.md).

## Usage

The interface has three operations:

```sh
analyzer/build/analyzer probe
analyzer/build/analyzer clock
analyzer/build/analyzer record --config analyzer/examples/idle.json --output /tmp/my-new-analyzer-run
```

The output directory must not already exist. The probe reads CPU and RAPL
interfaces and checks MSR readability; it does not initialize PCM or program
PMUs. The configuration supplies run identity, scenario, interval, duration,
required source flags, an optional RAPL power bound, and optional operator
metadata. See [ARTIFACTS.md](ARTIFACTS.md) for fields, statuses, exit codes,
and the limitations of derived values. Configuration does not apply policy or
override CPU/NUMA affinity.

`analyzer clock` prints one monotonic/realtime timestamp pair for external
workload coordination. The prepared paired Phi-4 overhead experiment is
described in [OVERHEAD_TEST.md](OVERHEAD_TEST.md); it requires manual `sudo`.

For manual experiments, start recording, run the explicitly selected workload
separately, and stop recording with `SIGINT` or `SIGTERM`. The future
orchestrator must communicate workload start and end events and retain its
completion status, duration, and errors; the coordination protocol remains to
be designed. Record observation windows before, during, and after the workload
where supported.

Required experiment scenarios are **IDLE**, **CPU**, **I/O**, and **CPU+I/O**.
Use the same workload definitions and measurement protocol for baseline and
verification; record relevant cache, device, and system conditions.

## Output

Each run produces a private local directory:

```text
run/
  manifest.json       Run identity, configuration, versions, and completion
  measurements.jsonl  Source observations and availability/errors
  events.jsonl        Observation and workload boundaries and errors
  summary.json        Separately derived interval metrics and aggregates
```

The version 1 and 2 schemas and their current omissions are documented in
[ARTIFACTS.md](ARTIFACTS.md). Operator-supplied metadata is not independently
verified. Workload boundaries and effective policy are not yet collected.

An interrupted or storage-failed run must not appear complete. Avoid
overwriting prior runs, use restrictive file permissions, and make any
partial artifacts identifiable. Artifacts may contain sensitive local paths
or identifying information: keep them local and review before sharing.

## Validation and remaining work

Tests cover delta calculations, fake Linux sources, output and config checks,
interruption, storage failure, a mocked root scenario, PCM read-only access,
mocked perf events, and restricted PCM mode. On 2026-11-26, the operator ran the
[manual root scenario](ROOT_TEST.md) on the dual Xeon Gold 6248 target; both
the initial CPU/RAPL checks and the later restricted PCM recorder check passed.
The later [Phi-4 overhead experiment](OVERHEAD_TEST.md) exercised five
real-hardware PCM recordings under CPU inference and stopped each with SIGINT;
subsequent recordings started successfully. It provides an initial, variable
overhead estimate, not an accepted threshold or independent accuracy check.
Counter conflicts and broader controlled load experiments remain unverified.

## Planned stages

These stages remain planned; exact event sets and ordering require target
verification. Runtime measurement is context for understanding resource use
and measurement influence, not an instruction to maximize throughput.

1. **Completed: CPU/RAPL baseline.** Record Linux CPU and energy counters,
  restricted PCM core counters, source availability, errors, and timing;
  validate on the target and characterize initial recorder overhead.
2. **Characterize additional PCM events.** Verify target support, access,
  ownership, conflicts, simultaneous event sets, and cleanup before enabling
  additional collectors. Retain explicit unsupported and error states.
3. **Memory and NUMA.** Record verified memory-controller bandwidth and
  local/remote behavior, supplemented by relevant OS-visible node and memory
  state. Do not equate node allocation with measured access locality.
4. **Interconnect and I/O fabric.** Add supported UPI and IIO/PCIe measurements
  only after checking event compatibility and target device mapping.
5. **Platform context.** Add applicable temperature, residency, block I/O,
  cache and resource-pressure measurements with clear scope and provenance.
6. **Experiment coordination.** Implement the separate orchestrator for
  explicitly selected workloads and the IDLE, CPU, I/O and CPU+I/O scenarios;
  preserve workload-owned affinity and NUMA settings.
7. **Comparison and verification.** Repeat the same scenarios and workloads
  across recorded baseline and candidate states; preserve measurement,
  interpretation, and causal claims separately. Materialization and control
  verification remain distinct project roles.