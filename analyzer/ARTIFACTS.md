# Analyzer Artifact Contract v1 through v4

Artifacts remain local and may contain sensitive paths, model identity, and
operator-supplied metadata. No schema migration is implemented. The v4 batch
contract is the principal workflow; the configuration sections below retain
the v1/v2 compatibility recorder contract.

## v4 batch

The canonical command accepts `--scenario`, `--model`, `--output`, and an
optional `--duration`. Scenario values are `all`, `idle`, `cpu`,
`cpu-numactl`, `gpu`, `gpu-numactl`, `cpu-gpu`, and `cpu-gpu-numactl`.
`all` expands to the six workload variants plus `idle` in the documented
order. `--duration` bounds only idle; workload recording ends at actual child
completion, interruption, or failure.

| Path | Contents |
| --- | --- |
| `batch-manifest.json` | Schema 4, requested scenario, expansion, model, prompt, idle duration, final status and scenario exit codes |
| `<scenario>/manifest.json` | Scenario status, PCM status, optional-source failures, sample counts |
| `<scenario>/resource.json` | Unified PCM/resource schema 3 record with per-core PCM, memory, NUMA, UPI, IIO, GPU topology, L3 and limitations |
| `<scenario>/measurements.jsonl` | Raw `/proc/stat` and Linux RAPL samples with availability and timestamps |
| `<scenario>/events.jsonl` | Initialization, workload-start, and measurement-finished boundaries |
| `<scenario>/summary.json` | Stage-one sample count and bounded first/last CPU/RAPL observations |
| `<scenario>/workloads.json` | Exact argv/command, PID, start/end clocks, exit code and orchestrator termination state |
| `<scenario>/{cpu,gpu}.stdout` and `.stderr` | Child output captured verbatim |

The batch directory must be absent or empty. PCM initialization happens before
workload creation. If PCM is unavailable, a scenario failure manifest and
resource artifact are retained and no workload is started. CPU/RAPL source
failures produce `partial` when PCM and workload completion otherwise succeed.
Process or PCM failures produce `failed`; signals produce `interrupted`.

Default CPU and HIP llama.cpp argv is `-m MODEL -p PROMPT`. A numactl scenario
adds `-numa numactl`; a combined scenario starts both children concurrently.
The fixed prompt is `show me detailed descriptions about C programing language`.
When the analyzer is root, children must be dropped to `SUDO_UID`/`SUDO_GID`.
The command never escalates privileges itself. Raw measurements and process
observations do not imply application-quality or bottleneck conclusions.

`resource.json` preserves the v3 field names but is measured by the v4 workload
lifecycle. Its `core_pcm` array contains logical CPU `instructions` and
`cycles`. The fixed duration is replaced with the actual monotonic interval
for workload scenarios. IIO values are stack-level unless topology establishes
a narrower endpoint mapping.

## Legacy v1/v2 configuration

The input is one JSON object. Unknown or repeated top-level keys are rejected.

| Key | Type | Meaning |
| --- | --- | --- |
| `run_id` | nonempty string | Operator-provided run identifier |
| `scenario` | string | `IDLE`, `CPU`, `IO`, or `CPU_IO` |
| `interval_ms` | integer | Requested interval, 100 through 3600000 ms |
| `duration_ms` | integer | Observation duration, at least one interval and at most 86400000 ms |
| `cpu_required` | boolean, optional | Defaults to true; source failure makes the run failed |
| `rapl_required` | boolean, optional | Defaults to false; source failure makes the run partial |
| `rapl_max_power_watts` | positive number, optional | Operator-verified upper bound per RAPL domain for power calculation |
| `pcm_enabled` | boolean, optional | Defaults to false; enables the restricted PCM core source |
| `pcm_required` | boolean, optional | Defaults to false; requires `pcm_enabled` and fails the run on PCM errors |
| `metadata` | object, optional | Operator-supplied workload, input, policy, and conditions; unverified |

The example in `examples/idle.json` intentionally provides no power bound.
The same scalar bound applies to each discovered domain. Choose a conservative
bound supported by the actual target; it is not inferred from a PL limit or a
RAPL counter range. A wrong bound invalidates the power interpretation.

When `pcm_enabled` is false, artifacts retain schema version 1. When true,
manifest and summary use version 2, including when PCM is unavailable. A build
without the optional PCM library records `unsupported`. Source selection does
not perform a privilege escalation.

## Run directory

The caller supplies a new path; existing directories are never overwritten.
The directory is created with mode `0700`, files with mode `0600` subject to
the process umask. The caller must not concurrently replace path components.

| File | Contents |
| --- | --- |
| `manifest.json` | Version, run identity, config, platform fields, clocks, errors, and final status |
| `measurements.jsonl` | One JSON object per CPU or RAPL observation |
| `events.jsonl` | Observation boundaries, baseline attempt, delayed sampling, and interruption |
| `summary.json` | Object with schema version and a `derived` array |

The manifest is published only after artifact writes and file sync. A directory
without `manifest.json` is incomplete, including on an unhandled crash or
storage error. An interrupted or source-failed run can have a manifest but is
not complete. Directory sync failure after publication remains an I/O failure;
durability depends on the filesystem. Files are not hash-protected.

When available, `recorder_user_usec`, `recorder_system_usec`, and
`recorder_max_rss_kib` are obtained from Linux `getrusage(RUSAGE_SELF)` for
the recorder process, including its threads. They cover the run up to the
resource-usage snapshot during finalization, not exclusively an external workload window. Failure to obtain
them is recorded in `recorder_resource_usage_status`.

## Measurement fields

Each observation has `metric`, `source`, `scope`, `unit`, `kind`, `status`,
`monotonic_ns`, and `realtime_ns`; errors add `error`. Times are nanoseconds
from `CLOCK_MONOTONIC` and the Unix realtime epoch respectively. They are
separate clock reads, not an atomic clock pair. Observations from different
sources are sequential, not a simultaneous snapshot. The kernel release in the
manifest identifies the Linux source version.

- `cpu.stat`: scope `cpu:<logical-id>`, unit `USER_HZ`, fields `user`, `nice`,
  `system`, `idle`, `iowait`, `irq`, `softirq`, and `steal`. Guest time is not
  separately added, avoiding double counting. `user_hz` is recorded when
  available. A failed whole-file read has system scope and no values.
- `rapl.energy`: scope is the Linux powercap domain ID; `domain_name` and
  `package` are read from powercap names. `value` and
  `max_energy_range_uj` are in microjoules. If only the range is unavailable,
  `value` remains available and `range_error` records the failure.

Successful observations have `sample_index`; a whole-source failure may not.
Statuses are `available`, `permission_denied`, and `read_error`. Unavailable
values are omitted, never represented as zero. The initial reading establishes
the baseline and is still retained as an observation.

Version 2 additionally records `pcm.instructions` and `pcm.cycles` for each
online logical CPU, with `source=intel_pcm_perf`, `unit=count`, PCM
`source_version`, `sample_index`, and `read_start_monotonic_ns`. The normal
observation timestamps are taken after the individual perf group read. `value`,
`time_enabled_ns`, and `time_running_ns` are raw cumulative kernel perf
values; no multiplex scaling is applied. These are PCM-managed perf groups,
not direct reads of physical counter registers. PCM initialization or read
failures are observations with no counter value and a status such as
`unsupported`, `unavailable`, `permission_denied`, `conflict`, or `read_error`.
The manifest records `pcm_status`, `pcm_version`, `pcm_error`, and, on error,
`pcm_error_detail`.

## Derived values

Each summary entry records the metric, scope, unit, status, method,
`before_sample_index`, `after_sample_index`, and monotonic interval endpoints.
`value` exists only for an available result. CPU load is the fraction of total
counter delta excluding idle and iowait. Decreasing counters or a zero total
produce `invalid_delta`.

RAPL power is energy delta divided by actual elapsed time. It is emitted only
if the range is unchanged, energy has not decreased, the configured maximum
power bounds the observed delta, and the maximum possible energy over the
interval is less than one counter range. Missing bounds produce
`bound_not_provided`; other unsafe cases produce `invalid_delta`. A counter
decrease is not treated as a wrap because reset and wrap are ambiguous.
Undetectable resets and an incorrect supplied bound remain limitations.

Version 2 `pcm.instructions.delta` and `pcm.cycles.delta` reference the two
sample indices and include `time_enabled_delta_ns` and `time_running_delta_ns`.
Only monotonic counter/time pairs with nonzero running time and equal enabled
and running deltas produce an unscaled `value`. Other cases are marked
`invalid_delta`, `not_running`, or `multiplexed`, without a derived value.
Raw cumulative observations remain available even when a delta is unusable;
`complete` does not guarantee every interval has an available delta.

## Completion and exit codes

- `complete`, exit 0: at least two samples and no source failures. This does
  not claim that optional power calculations or PCM metrics are available.
- `partial`, exit 2: a non-required source failed.
- `failed`, exit 1: a required source failed or fewer than two samples were
  collected; configuration, output, or storage errors also exit 1 and can
  leave no manifest.
- `interrupted`, exit 130 for SIGINT or 143 for SIGTERM: stopped by signal.

The source flags are sticky: a transient failure is retained in the final
status. PCM is recorded as `not_collected` only when disabled. A failure of a
required PCM source makes the run failed; an optional PCM source makes it
partial. Workload start/end, workload
outcomes, effective policy, CPU topology mapping, temperature, and PMU conflict
information are not captured by v1; metadata is explicitly unverified.