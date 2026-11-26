# Dual Xeon Gold 6248 Experiments

Concise current backlog and history. These are investigations, not accepted
causal conclusions.

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

## Evidence boundary

The stored platform specification report is an inventory baseline, not a
performance experiment. Operator-reported observations are summarized in
[observations.md](observations.md); isolate parameter effects before treating
correlations as causes. Custom scheduler development is not a planned
experiment.
