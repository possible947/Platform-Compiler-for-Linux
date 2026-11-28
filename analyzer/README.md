# Platform Analyzer / Recorder

## Status

The principal analyzer workflow is an orchestrated v4 batch recording. One
`record` invocation can observe idle or launch the selected llama.cpp CPU,
HIP, and combined scenarios, including their `numactl` variants. Each scenario
records `/proc/stat`, Linux RAPL, PCM core instructions/cycles, socket memory
and NUMA traffic, UPI, IIO/DMA, GPU topology, and supported L3 metrics into one
coordinated artifact set.

The earlier v1/v2 configured recorder remains available for compatibility,
along with deterministic four-run comparison. The analyzer does not select or
apply platform policy, classify bottlenecks, verify model output, or score
application performance.

The current project contract is documented in
[Platform Analyzer](../docs/platform-analyzer.md) and the
[architecture](../docs/ARCHITECTURE.md). Where this draft leaves a decision
open, it does not establish a new project-wide requirement.

## Purpose and boundaries

The analyzer records platform behavior before, during, and after a defined
workload or idle observation. For v4 batch recordings, its record command is
also the narrowly scoped workload orchestrator: it launches only the two
known llama.cpp executables and retains exact arguments, process status, and
measurement boundaries.

The analyzer still does not select or apply policies, interpret application
throughput, verify model output, or attribute causes. The llama.cpp applications
retain responsibility for their own CPU and NUMA placement. The Platform
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
    batch/        Canonical workload orchestration and v4 batch lifecycle
    cli/          Command-line parsing and compatibility entry points
    session/      Legacy configured measurement lifecycle
    collectors/   PCM and Linux measurement sources
    resource/     Unified resource records and metric definitions
    comparison/   Deterministic resource deltas, without conclusions
    summary/      Derived CPU/RAPL results for v1/v2
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
| CPU | `/proc/stat` | Per-CPU raw counters and load in batch recordings |
| CPU performance counters | Intel PCM and Linux perf | Per-core instructions and cycles |
| Energy and power | Linux RAPL powercap | Raw energy in v4; v1/v2 can derive bounded power |
| Memory, NUMA, cache, UPI, IIO/PCIe | Intel PCM | Unified v4 resource measurements with explicit availability |
| GPU ownership topology | Linux PCM/PCIe topology | BDF, vendor and device identity where mapping is trustworthy |
| Temperature and residency | Not implemented in v4 | No values are invented |

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

The principal interface is one batch command:

```sh
analyzer/build/analyzer record \
  --scenario all|idle|cpu|cpu-numactl|gpu|gpu-numactl|cpu-gpu|cpu-gpu-numactl \
  --model /path/model.gguf \
  --output /path/new-output-directory \
  --duration 60
```

`all` expands in this exact order: `idle`, `cpu`, `cpu-numactl`, `gpu`,
`gpu-numactl`, `cpu-gpu`, `cpu-gpu-numactl`. `--duration` controls only the
idle window. Every workload runs until all selected llama.cpp children finish;
the model is required for workload scenarios. The canonical prompt is
`show me detailed descriptions about C programing language`.

The CPU and HIP executables are launched directly with `-m MODEL -p PROMPT -st`,
so each llama.cpp call performs one turn and exits instead of entering the
interactive prompt. The three `*-numactl` variants add exactly `--numa numactl`.
Combined scenarios start CPU and HIP llama.cpp concurrently, with CPU as the
measurement anchor. Whenever a successful GPU pass finishes before CPU, the
analyzer starts a new GPU pass. When CPU exits successfully, the current GPU
pass is stopped with `SIGINT` and marked `termination_reason=cpu_completed`.
A nonzero exit from either engine fails the scenario. A root analyzer drops each
child to `SUDO_UID`/`SUDO_GID`; the analyzer never invokes `sudo` or reconfigures
the host. Workload-only selections ignore `--duration`.

Compatibility and diagnostic operations remain available:

```sh
analyzer/build/analyzer probe
analyzer/build/analyzer clock
analyzer/build/analyzer record --config analyzer/examples/idle.json --output /tmp/legacy-run
analyzer/build/analyzer compare --idle IDLE/resource.json --cpu CPU/resource.json \
  --gpu GPU/resource.json --cpu-gpu CPU_GPU/resource.json --output delta.json
```

`probe` checks CPU, RAPL and MSR readability without programming PMUs. The
legacy configured recorder retains its v1/v2 artifact contract. `compare` is a
four-run resource delta matrix and does not emit a performance score or a
bottleneck conclusion.

## Output

A v4 batch uses the supplied directory as a shared output root. The root may
already exist and contain unrelated completed scenarios. Every selected scenario
gets its own new `root/<scenario>/` directory and existing scenario directories
are never overwritten. `batch-manifest.json` is published at the root only for
`--scenario all`.

```text
batch/
  batch-manifest.json
  idle/
    manifest.json
    resource.json
    measurements.jsonl
    events.jsonl
    summary.json
  cpu/
    ...the same measurement files...
    workloads.json
    cpu.stdout
    cpu.stderr
  gpu/ ...
  cpu-gpu/
    gpu.001.stdout
    gpu.001.stderr
    gpu.002.stdout
    gpu.002.stderr
    ...the same measurement and manifest files...
  cpu-gpu-numactl/ ...
```

`batch-manifest.json` retains the selected expansion, model, prompt, idle
duration, final batch status, and per-scenario exit codes. Each scenario manifest records completion and source state. Exact
argv, PIDs, monotonic/realtime boundaries, exit codes, logs, and termination
state are retained per workload. `resource.json` contains the unified PCM and
resource record; Linux CPU/RAPL observations and events remain raw and separate.
See [ARTIFACTS.md](ARTIFACTS.md) for the v4 and legacy contracts.

An interrupted or storage-failed run must not appear complete. Avoid
overwriting prior runs, use restrictive file permissions, and make any
partial artifacts identifiable. Artifacts may contain sensitive local paths
or identifying information: keep them local and review before sharing.

## Resource batch and root operation

A complete batch uses PCM's full memory, uncore and IIO APIs and therefore
normally requires manual root execution. For example, from a login shell:

```sh
sudo env PCM_KEEP_NMI_WATCHDOG=1 analyzer/build/analyzer record \
  --scenario all \
  --model /home/viktor/LLM/models/lmstudio-community/phi-4-GGUF/phi-4-Q4_K_M.gguf \
  --output /home/viktor/LLM/analyzer-experiments/batch-01 \
  --duration 60
```

The agent never executes this privileged command. `SUDO_UID` and `SUDO_GID`
identify the unprivileged caller to which llama.cpp children are dropped. If
PCM is unavailable, the analyzer writes a failure artifact and does not start
workloads. IIO values are stack-level PCM observations unless trustworthy
PCIe topology establishes a narrower association.

For a compatibility four-run comparison:

```sh
analyzer/build/analyzer compare --idle /path/s0/resource.json --cpu /path/s1/resource.json --gpu /path/s2/resource.json --cpu-gpu /path/s3/resource.json --output /path/resource-delta.json
```

The comparison is a resource delta matrix. It has no performance score,
bottleneck classification or recommendation.

See [CAPABILITY-AUDIT.md](CAPABILITY-AUDIT.md) for the exact PCM APIs and
metric classifications used by this mode.

## Validation and remaining work

Tests cover CPU/RAPL deltas, fake Linux sources, artifact contracts, scenario
expansion, interruption, storage failures, PCM read-only access, mocked perf
events, restricted PCM mode, and deterministic resource comparison. Earlier
manual target tests validated CPU/RAPL and the restricted PCM recorder on the
dual Xeon Gold 6248 host.

The unified v4 workflow has build and no-privilege artifact checks. A complete
real-hardware run of CPU, HIP and combined llama.cpp children still requires an
operator-run root session and target verification of cleanup, process placement,
IIO rotation, and PMU restoration. Runtime and workload results remain context
for resource interpretation, not an optimization target.

Remaining work is verification and extensions with demonstrated target support:
additional PCIe endpoint mapping, temperature/residency, and broader comparison
of paired default/`numactl` runs. Materialization and policy-control verification
remain separate project roles.