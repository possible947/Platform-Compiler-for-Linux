# Dual Xeon Gold 6248 Experiments

Concise current backlog and history. These are investigations, not accepted
causal conclusions.

## Workloads and automation

The operator reports using the following workloads in later observations;
their original measurement artifacts are not available:

- **Target parallel video encoder:** a Pascal project using a custom FFmpeg
  built on the target for the target, and custom SVT-HEVC adapted for modern
  Intel architectures without AVX-512. This is the principal intended use:
  maximize useful use of available resources under high to very high load.
  The encoder has its own `numactl` and CPU affinity settings.
- **HandBrake:** a comparison workload used to observe how a tool without
  target-specific optimization manages its own resources. HandBrakeCLI is a
  candidate for automated execution; do not assume its behavior is identical
  to the GUI without verification.
- **llama.cpp:** built on the target, with CPU-only, GPU-only, and CPU+GPU
  inference. `llama-cli` is a candidate for automated execution.

The encoder exposes a library with three inputs: working directory, input file,
and preset. The operator describes it as a predictable CPU, memory, and I/O
load source; its own NUMA and affinity behavior must be preserved. The
operator reports more than 200 hours of encoder testing and a design
requirement for no more than 0.1% variation in the encoder's analysis and
quality metrics, with stable segment output and synchronization. That
threshold has not been verified under defined conditions; it is not a
platform-measurement tolerance. These claims do not establish the variability
of platform measurements under controlled experimental conditions. Checking
encoded output or quality is not part of the analyzer's task.

Plan automated execution of explicitly selected scenarios through an
orchestrator, separate from measurement and policy selection. Record workload
parameters, component and preset versions, completion, timing, and errors
alongside the analyzer artifacts. Compare repeated runs under recorded system
and cache conditions; preserve the same scenario definitions for baseline and
verification. Study the existing PCM monitor and encoder library before
choosing their integration, including counter conflicts and process isolation.
No existing integration is assumed.

## Priority experiments

- Expand TuneD inheritance and produce effective parameter/state diffs for
  each profile of interest.
- Map policy parameter/family -> effective hardware/system state -> measured
  effect.
- Compare the target-installed Intel C-state-oriented profile,
  `hpc-compute`, `accelerator-performance`, and `throughput-performance`
  where useful.
- Capture IDLE, CPU, I/O, and mandatory CPU+I/O Platform Analyzer scenarios
  for comparable baselines and policies.
- Test CPU groups and priorities using stock Linux mechanisms.
- Characterize memory/NUMA policy and explicit placement under inference
  workloads; measure locality, throughput, power, and thermal behavior.
- Characterize PCIe/I/O policy, including NVMe throughput and peripheral/system
  responsiveness under CPU and combined CPU+I/O load.

## Memory and storage investigations

- Record the current memory topology, per-node capacity and effective access
  costs; compare native placement and migration policies under inference and
  video workloads. Test prioritization of faster versus slower memory only
  where measurements establish a meaningful distinction, and track locality,
  memory use, throughput, latency, and responsiveness.
- Establish comparable baselines for the actual SSD/Btrfs and rotating
  disk/XFS combinations. Include project and LLM model access as well as
  segment encoders reading ProRes and writing raw HEVC. Record input/output
  sizes, concurrency, device occupancy, cache state, and workload outcomes;
  include combined CPU+I/O pressure. Investigate uneven memory and streaming
  video behavior as separate and potentially interacting hypotheses.
- Compare applicable caching, read-ahead, writeback, and block I/O parameters
  one family at a time against the baseline. Measure per-node memory use,
  reclaim, page-cache and dirty/writeback memory where available, I/O
  throughput and latency, workload completion, and responsiveness. Distinguish
  warm and cold access conditions and record unavailable metrics; do not
  equate reclaimable cache with wasted memory.
- Evaluate mount options and any `/etc/fstab` changes separately for each
  filesystem and device. Record the original and candidate configuration,
  effective mounted state, durability and recovery implications, and a
  rollback procedure. Do not trade data integrity for a memory reduction.
- After the Optane replacement is installed, inventory it and repeat relevant
  tests at documented occupancy levels. Verify sustained behavior and whether
  reduced caching benefits the real workloads rather than assuming either.

## Evidence boundary

The stored platform specification report is an inventory baseline, not a
performance experiment. Operator-reported observations are summarized in
[observations.md](observations.md); isolate parameter effects before treating
correlations as causes. Custom scheduler development is not a planned
experiment.
