# Platform Control Tester

The Platform Control Tester verifies configured/control state using verified
direct reads and operating-system observers. It answers questions such as
whether a required setting or state is present and what the operating system
reports about it. It does not measure shared-resource performance under
controlled workload load and does not attribute causal effects.

```text
Platform Control Tester
  -> verifies control/configured state

Platform Analyzer
  -> measures shared-resource behavior under workload
```

The tester should use a verified read path for each claimed state, report
unavailable or conflicting evidence explicitly, and retain source/provenance.
An intended setting is not proof of effective hardware behavior.

The repository's [current-system snapshot collector](current-system-snapshots.md)
captures read-only OS-visible observations and raw evidence. Its documented
scope and limitations remain authoritative for that collector; a snapshot is
not a workload analyzer result and should not be misrepresented as a complete
control-state verification.

The tester complements the analyzer in the materialization
[verification loop](MATERIALIZATION.md). It is not a tuner and must not perform
privileged operations autonomously; root operations are performed manually by
the user.
