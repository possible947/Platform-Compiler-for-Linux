# Offline Snapshot Access and Joint ACPI Disassembly

This stage reads a **published snapshot** from the workspace without touching the
live machine. It then derives deterministic iASL disassembly from the captured AML
definition blocks. It does not interpret, diagnose, compare, patch or install ACPI.

```sh
platform-compiler acpi disassemble \
    --workspace /path/to/workspace \
    --snapshot <snapshot-id> \
    [--iasl /path/to/iasl-or-acpica-bin-dir] [--timeout 600]
```

Exit status:

- `0`: the derivation succeeded.
- `1`: the derivation was recorded as failed, or a rerun produced different results.
- `2`: the snapshot, the selection or the tool was refused before anything was written.

## Stored snapshots are untrusted input

`platform_compiler.snapshot.store.open_snapshot(workspace, snapshot_id)` resolves
`<workspace>/snapshots/<snapshot-id>/` and checks it before use:

- The directory and manifest must not be symlinks.
- The manifest must have a supported schema version.
- `manifest_sha256` is computed without rewriting the manifest.
- Capture IDs and raw paths must be unique.
- Each `raw_path` must be exactly `raw/<file>`.
- The content and provenance hashes must agree.
- Snapshot IDs must match their directory name.

`read_capture(capture_id)` returns bytes only after it re-verifies their size and
SHA-256. `verify()` checks every raw capture.

Typed observations are read directly with `observation(CPUTopology)`,
`NUMATopology`, `KernelEnvironment`, `ACPIInventory`, and so on. For PCI,
`platform_compiler.snapshot.query` adds three pure helpers:

- `pci_device(topology, bdf)`
- `pci_upstream_path(topology, bdf)`: the device first, ending at the device below the host bridge.
- `pci_devices_on_node(topology, node)`

## Definition-block selection

Selection uses each table's parsed header signature and its interface path. Inputs
are the boot tables `/sys/firmware/acpi/tables/DSDT` and `SSDT*`, ordered DSDT then
SSDTs by number. Every required input must be readable and consistent with its
header. Otherwise the derivation is refused, because a joint namespace without a
member would be incomplete.

Every other table is recorded in `excluded_tables` with a reason:

| Reason | Tables |
| --- | --- |
| `oem_specific_table_deferred` | `OEMx` tables. They may contain AML that firmware loads at runtime (`LoadTable`); that semantics is deferred. |
| `dynamic_definition_block_deferred` | DSDT/SSDT under `tables/dynamic/` |
| `not_a_boot_definition_block` | Data tables (APIC, SRAT, SLIT, DMAR, MCFG, FACS, and so on). These are not decoded. |

## iASL adapter

iASL is an **external ACPICA executable**. Platform Compiler never downloads,
builds or installs it, and never uses `sudo`. Resolution order:

1. the `--iasl` file, or a directory containing `iasl`;
2. `PATH`;
3. a clear missing-tool error.

Resolution and each run record:

- the absolute executable path, its SHA-256, and the `-v` version;
- the argv, run with `shell=False` and stdin closed;
- the environment, which is exactly `LC_ALL=C`;
- the timeout;
- the exit status and the stdout/stderr hashes.

The binary hash is checked again immediately before the run.

The inputs are copied byte-for-byte to `<capture_id>.dat` in a private staging
directory. iASL then runs there once, jointly over all of them, as
`iasl -da <inputs…>`. Afterwards the staged inputs are checked to confirm iASL did
not modify them.

If iASL fails, the derivation fails. Its stdout, stderr and any partial outputs
are kept under `diagnostics/`. There is **no** per-table or `-e` fallback.

## Derived evidence and storage

```text
<workspace>/derived/<snapshot-id>/acpi-disassembly/<derivation-id>/
  derivation.json      ACPIDisassembly record
  tool/stdout.txt
  tool/stderr.txt
  outputs/<capture_id>.dsl      succeeded derivations only
  diagnostics/…                 partial or unexpected tool output
```

`derivation_id` is the SHA-256 of a canonical JSON object containing:

- the derivation schema version and kind;
- the snapshot manifest SHA-256;
- the ordered `(capture_id, sha256)` inputs;
- the iASL executable SHA-256 and version;
- the iASL arguments.

Output hashes are results only, so they are stored in the record and never feed
the identity. The executable path is also excluded from the identity, because the
binary's hash and version identify it. The full argv is still recorded.

Each output is a `DerivedArtifact` with:

- its subject capture;
- every joint source capture;
- the `ToolInvocation`.

Its source evidence class is fixed to `observed_target`. A `DerivedArtifact` is
neither a raw `Capture` nor an AI `Finding`.

Publication is an atomic directory rename. If the same derivation is run again,
the published record and files are verified and then compared:

- If they are identical, the result is reported as `reproduced`.
- If they differ, the result is reported as `nondeterministic`. The differing
  attempt is kept beside the original as `<derivation-id>.attempt-<hash>`.
  Nothing is overwritten.

DSL is never normalized to make hashes match.

## Testing

Ordinary `pytest` uses fixture snapshots and a fake `iasl`. To run the opt-in real
integration test:

```sh
PLATFORM_COMPILER_REAL_WORKSPACE=~/platform-compiler-workspace \
PLATFORM_COMPILER_REAL_SNAPSHOT=<root-snapshot-id> \
[PLATFORM_COMPILER_IASL=/path/to/iasl] \
pytest -s -k real_root tests/test_offline_acpi.py
```

It skips with an explicit reason when iASL cannot be resolved.
