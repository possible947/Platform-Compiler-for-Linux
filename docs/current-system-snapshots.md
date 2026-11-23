# Read-only current-system snapshots

Initialize an external workspace once, then capture the currently running Linux
environment:

```sh
platform-compiler workspace init /path/to/workspace
platform-compiler snapshot collect --workspace /path/to/workspace
```

The collection command requires an existing workspace outside Git repositories,
the source checkout, and kernel/device filesystems. It prints only the snapshot
ID/path and collector completion states. Partial captures return success; an
entirely unusable capture or a workspace/storage failure returns nonzero.

## Collected interfaces

All collectors run with the current process's privileges. **None requires root,
executes external commands, accesses the network, or invokes inference.** Reads
denied by the kernel are recorded as permission-denied, without retrying through
sudo or changing permissions.

| Collector | Interfaces | Simple normalized observations |
| --- | --- | --- |
| CPU | Allowlisted `/proc/cpuinfo`; `/sys/devices/system/cpu/cpu*`, `online`, topology and node links | Architecture, per-CPU vendor/family/model/features, logical IDs, online membership, package/core IDs, SMT siblings, exposed node associations |
| NUMA | `/sys/devices/system/node/node*/{cpulist,meminfo,distance}` | Node IDs, CPU lists, memory totals/free/used in KiB, distance rows in kernel order |
| Memory | `/proc/meminfo` | Memory quantities (`_kib` suffix denotes KiB), hugepage counts and sizes |
| PCI | `/sys/bus/pci/devices`; device links, `vendor`, `device`, `class`, `driver`, `numa_node`, `local_cpulist`, `resource`, `power/{control,runtime_status}` | BDFs, IDs, driver names or `driver_bound: false` when no driver link exists, canonical sysfs paths/parents, locality, resource triples, observed runtime-PM values |
| IRQ | `/proc/interrupts` | Raw capture only |
| ACPI | `/sys/firmware/acpi/tables` and `dynamic` | Table names, interfaces, per-table capture availability and parsed standard 36-byte headers |
| Kernel | `uname.machine`, `/proc/sys/kernel/{osrelease,version}`, redacted `/proc/cmdline`, `/sys/firmware/efi` existence | Architecture, kernel release/version, boot arguments with identifying values redacted, EFI runtime-interface presence |

These are Linux-exposed observations, not verified physical facts or a canonical
platform model. No reference platform is consulted. The snapshot produces no
findings, diagnoses, policy, comparisons, recommendations or corrections.

## Retention and privacy

Every successful read retains its bytes under `raw/`, except interfaces with an
explicitly recorded privacy transformation. Directory and symlink observations
are recorded as filtered listings or canonical kernel paths. Captures include
source interface, observation time, availability, transformation, byte count and
SHA-256. Errors never include arbitrary exception text.

CPU information retains only processor/vendor/family/model/feature fields.
Kernel boot arguments keep every parameter name and non-identifying value (for
example `acpi_osi=`, `pcie_aspm=`, `nomodeset`). Values of disk, host, network,
user and credential parameters (`root=`, `resume=`, `*.luks.uuid=`, `ip=`,
`BOOTIF=`, `hostname=`, `password=`, `*_key=` ...) and any value resembling a
UUID, MAC address, long hex identifier, URL or e-mail address become
`[redacted]`. The capture is marked with that transformation.

Readable ACPI tables are retained as **exact, untransformed bytes** so their
digests identify the firmware tables; standard headers are also parsed into the
manifest (FACS has no standard header). These bytes stay in the local workspace
and may contain OEM identity, so review them before any sharing. License-bearing
MSDM and SLIC bodies are never read; a read-only open only records whether they
are permission-restricted. Table files are normally root-only, so unprivileged
collection usually yields an inventory with permission-denied bodies.

Hostnames, usernames, environment variables, MAC-address interfaces, serial/DMI
identity, boot IDs, application logs, credentials and unrelated files are not
collected. `/proc/version` is excluded because it can contain builder identities.
Custom kernel version strings, IRQ action names, topology paths and vendor CPU
descriptions are retained technical metadata; review local snapshots before any
future sharing. There is no upload or telemetry path.

## Storage and failure behavior

```text
<workspace>/snapshots/<UTC-time>-<random-event-id>/
    manifest.json
    raw/<collector-index>-<capture-index>.bin
```

A snapshot directory is reserved exclusively and never overwritten, even if a
previous collection with that ID was interrupted. New snapshot directories have
mode `0700`; capture/manifest files have mode `0600`. Persisted bytes are hash
checked before publishing a synced manifest through an atomic, no-overwrite
hard link. A directory without `manifest.json` is incomplete and is never
presented as a completed snapshot. Storage failures stop publication.
The workspace filesystem must support POSIX file permissions and hard links.

The versioned typed manifest distinguishes observed-target evidence from
reference evidence and hypotheses. Each of the seven collector results records
success, partial, unavailable, permission-denied, unsupported or failed status.
One collector failure does not discard other results.

## Limits

Collection is sequential, not a simultaneous freeze: hotplug, memory counters,
IRQs and PM state can change during the event. Per-capture timestamps preserve
that distinction. Containers/namespaces can expose incomplete or mixed views;
the snapshot records the current process's kernel-visible environment.
Files are read unbuffered in 64 KiB chunks and bounded to 8 MiB each; oversize
reads fail explicitly.
CPU-info coverage varies by architecture; absent kernel interfaces remain
explicitly unavailable, and exposed sentinel values such as PCI NUMA `-1` are
preserved without interpretation. DIMM/SPD inventory, PCI configuration space,
BAR mappings, firmware/DMI identity, detailed hugepage policy, logs and ACPI
disassembly are intentionally excluded.

The read-only boundary means no kernel/device writes, utility execution, driver
changes, affinity/NUMA/PM changes, firmware methods, benchmarks, reboot or suspend.
Ordinary filesystem access-time effects are not controlled. Do not concurrently
replace workspace paths while collection is running.
