# Platform Audit Report Template

> **Template purpose:** Step 1 — Platform Specification
>
> This document is the normative human-readable report structure for a Platform Compiler platform audit. The completed report describes what the target platform is and what its components are capable of. It does not diagnose problems or recommend configuration changes.

---

# Platform Specification Report

## Document Control

- **Case ID:** `<case-id>`
- **Report schema/version:** `platform-specification/1`
- **Preparation protocol:** `platform-preparation-protocol/v1`
- **Target snapshot ID:** `<snapshot-id or not-used>`
- **Target manifest hash:** `<sha256 or not-used>`
- **Audit started:** `<timestamp>`
- **Audit completed:** `<timestamp>`
- **Agent/model/provider:** `<identity>`
- **Report status:** `complete | partial | superseded`

### Scope statement

> This report describes the identity, topology, installed configuration, and documented capabilities of the target physical platform. It intentionally does not diagnose reported problems, interpret user goals, or propose platform changes.

---

# 1. Executive Platform Summary

Provide a concise engineering summary sufficient to orient the reader before the detailed inventory.

## 1.1 Platform at a glance

- **Architecture:** `<value>`
- **Platform/motherboard:** `<value/status>`
- **Firmware/BIOS:** `<value>`
- **CPU configuration:** `<2 sockets, model, cores/threads>`
- **NUMA configuration:** `<summary>`
- **Installed memory:** `<summary>`
- **Major PCIe topology:** `<summary>`
- **Major accelerators/GPUs:** `<summary>`
- **Storage architecture:** `<summary>`
- **Network architecture:** `<summary>`
- **IOMMU/remapping:** `<summary>`
- **ACPI inventory:** `<summary>`

## 1.2 Important audit limitations

List only limitations of the specification audit itself.

- `<unknown/unavailable data>`
- `<conflicting identity/specification data>`
- `<unavailable authoritative source>`

Do not list performance problems here.

---

# 2. Evidence and Source Basis

## 2.1 Target evidence used

For each important evidence source provide:

- **ID/reference:** `<stable evidence/capture/path reference>`
- **Class:** `observed_target | deterministic_derived`
- **Description:** `<what it contains>`
- **Integrity/provenance:** `<hash/snapshot/derivation reference when applicable>`

## 2.2 External sources used

For each external source provide:

- **Source ID:** `<SRC-###>`
- **Class:** `external_authoritative | external_secondary`
- **Publisher/owner:** `<Intel, PCI-SIG, kernel.org, vendor, etc.>`
- **Title:** `<document/page title>`
- **URL/document identifier:** `<source>`
- **Version/date where explicitly available:** `<value>`
- **Used for:** `<specific specification facts>`

## 2.3 Evidence classification legend

Use consistently:

- `observed_target`
- `deterministic_derived`
- `external_authoritative`
- `external_secondary`
- `unknown`
- `conflicting`

---

# 3. Platform Identity

## 3.1 System identity

- **System architecture:** `<value>`
- **Board/platform vendor:** `<value/status>`
- **Board/platform model:** `<value/status>`
- **Board revision:** `<value/status>`
- **Chipset/platform generation:** `<value/status>`
- **DMI/SMBIOS identity:** `<summary>`

For each nontrivial identity claim, cite its evidence/source.

## 3.2 Firmware identity

- **Firmware/BIOS vendor:** `<value>`
- **Firmware/BIOS version:** `<value>`
- **Firmware release/revision:** `<value/status>`
- **UEFI:** `<present/status>`
- **ACPI revision:** `<value/status>`

## 3.3 Identity conflicts or uncertainties

Record observed conflicts without diagnosis.

Example format:

```text
ID-CONFLICT-01
Observed target value: ...
External/vendor value: ...
Status: conflicting
Impact on later audit sections: ...
```

---

# 4. CPU Specification

## 4.1 Processor identity

- **Processor model:** `<exact model>`
- **Architecture/microarchitecture:** `<value>`
- **Family/model/stepping:** `<value>`
- **Socket/package count:** `<value>`
- **Physical cores per socket:** `<value>`
- **Total physical cores:** `<value>`
- **Threads per core:** `<value>`
- **Total logical CPUs:** `<value>`
- **SMT:** `<supported/enabled/not determined>`
- **Microcode observed:** `<value/status>`

## 4.2 CPU topology

Describe:

- CPU-to-core mapping;
- CPU-to-socket mapping;
- socket-to-NUMA relationship;
- SMT sibling structure;
- important asymmetries, if any.

Include a compact normalized topology representation when useful.

## 4.3 CPU frequency capability table

This section is mandatory.

### Documented frequency envelope

| Active physical cores per socket | Non-AVX / general ceiling | AVX2 ceiling | AVX-512 ceiling | Evidence/source | Status/notes |
|---:|---:|---:|---:|---|---|
| 1 | `<MHz/unknown>` | `<MHz/unknown>` | `<MHz/unknown>` | `<source>` | `<notes>` |
| 2 | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` |
| 3–4 | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` |
| 5–8 | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` |
| 9–12 | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` |
| 13–16 | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` |
| 17–20 / all-core | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` |

**Do not fabricate bins.** Replace the table rows/categories with the authoritative bin structure actually available for the processor. If no authoritative per-active-core table can be established, say so explicitly and record only the confirmed frequency capabilities.

### Frequency summary

- **Base frequency:** `<value/status/source>`
- **Maximum turbo frequency:** `<value/status/source>`
- **Confirmed all-core frequency capability:** `<value/status/source>`
- **Uncore/domain frequency capability:** `<value/status/source>`
- **Frequency caveats:** `<instruction mix, documented limits, unknowns>`

## 4.4 CPU power and thermal specification

- **Nominal TDP:** `<value/status/source>`
- **Documented package power envelope:** `<value/status/source>`
- **Configurable power-limit capability:** `<value/status/source>`
- **Thermal limit/TjMax:** `<value/status/source>`
- **Package power domains:** `<summary>`
- **Core power domain:** `<summary>`
- **Uncore power domain:** `<summary>`
- **DRAM power domain:** `<summary>`

Do not treat nominal TDP as a measured runtime power limit unless evidence establishes that relationship.

## 4.5 CPU performance-control capabilities

For each feature record `supported | not_supported | unknown` plus evidence/source.

- **Turbo Boost:** `<status>`
- **EIST/P-state control:** `<status>`
- **HWP:** `<status>`
- **CPPC:** `<status>`
- **Relevant performance MSR/interfaces:** `<summary>`
- **Processor idle/C-state capability:** `<summary>`

This section documents capability only. Current Linux policy belongs to Step 2.

## 4.6 Cache hierarchy

- **L1 data:** `<value>`
- **L1 instruction:** `<value>`
- **L2:** `<value>`
- **L3/LLC:** `<value>`
- **Sharing/topology:** `<summary>`

## 4.7 Socket interconnect

- **UPI/interconnect links:** `<count/status>`
- **Documented link capability:** `<value/status>`
- **Observed topology:** `<summary>`
- **Sources:** `<references>`

## 4.8 CPU audit unknowns

List unresolved CPU specification gaps that may matter to later stages.

---

# 5. Memory Specification

## 5.1 Installed memory

- **Total installed memory:** `<normalized GiB plus raw basis>`
- **Memory per NUMA node:** `<values>`
- **Memory speed:** `<value/status>`
- **ECC:** `<status>`

## 5.2 Memory-controller/channel topology

- **Controllers/socket:** `<value/status>`
- **Channels/controller:** `<value/status>`
- **Total channels/socket:** `<value/status>`
- **Populated channels:** `<value/status>`
- **Population asymmetry:** `<fact only>`

## 5.3 DIMMs

For each identified DIMM or homogeneous group:

- location;
- size;
- type;
- speed/capability;
- ranks/organization where available;
- manufacturer/part information where safely available.

## 5.4 Memory capability

- **Documented maximum supported speed:** `<value/status>`
- **Documented channel bandwidth:** `<value/status>`
- **Theoretical aggregate bandwidth:** `<value/status/calculation provenance>`

Clearly distinguish theoretical capability from measured bandwidth.

## 5.5 Memory audit unknowns

`<list>`

---

# 6. NUMA Specification

## 6.1 Node inventory

For each node:

```text
Node: <id>
Socket relationship: <value>
CPUs: <range/list>
Memory: <normalized size>
Important local PCI devices: <summary>
```

## 6.2 Distance matrix

Provide the observed NUMA distance matrix.

## 6.3 NUMA topology summary

Describe only established topology and asymmetry.

Do not evaluate whether the current scheduler uses it correctly.

---

# 7. PCIe / I/O Architecture

## 7.1 Root architecture

- PCI domains;
- root buses;
- root complexes/IIO structure where determinable;
- host bridges;
- relationship to sockets/NUMA.

## 7.2 Major endpoint inventory

For each major endpoint:

```text
Logical role: <GPU/NVMe/NIC/USB/etc.>
BDF: <dddd:bb:dd.f>
Vendor/device: <value>
Bound driver: <identity only if useful for identification; policy belongs to Step 2>
NUMA node: <value>
Maximum link capability: <speed x width>
Observed negotiated link: <speed x width/status>
Upstream path: <path>
Evidence: <refs>
```

## 7.3 GPUs / accelerators

`<inventory and hardware capabilities>`

## 7.4 Storage

`<controller/device architecture and hardware capabilities>`

## 7.5 Networking

`<controller architecture and hardware capabilities>`

## 7.6 USB / external I/O

`<controller topology and hardware capabilities>`

## 7.7 IOMMU / DMA remapping

- capability;
- relevant units/topology inferred from observed platform evidence;
- DMAR presence/identity;
- important unknowns.

Do not describe current Linux policy beyond identity/capability discovery.

---

# 8. Firmware and ACPI Inventory

## 8.1 Firmware architecture summary

Provide a neutral inventory summary.

Do not diagnose firmware quality or origin.

## 8.2 ACPI table inventory

For every important ACPI table provide:

| Name/signature | OEM ID | OEM table ID | Revision | Length | Captured? | Derived representation? | Evidence ID | Notes |
|---|---|---|---:|---:|---|---|---|---|
| `<...>` | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` |

At minimum identify:

- DSDT;
- SSDTs;
- OEM AML-bearing tables;
- FADT/FACP;
- SRAT;
- SLIT;
- DMAR;
- MCFG;
- APIC;
- HPET;
- other platform-relevant tables.

## 8.3 AML definition blocks

Inventory only:

- boot definition blocks;
- additional captured AML-bearing tables;
- deterministic DSL artifacts already available;
- derivation provenance.

Do not classify methods as defective.

## 8.4 Firmware audit unknowns/conflicts

`<list>`

---

# 9. Component Capability Summaries

Provide concise engineering summaries for major platform components.

## 9.1 CPU subsystem

`<capability summary>`

## 9.2 Memory subsystem

`<capability summary>`

## 9.3 NUMA/interconnect subsystem

`<capability summary>`

## 9.4 PCIe/I/O subsystem

`<capability summary>`

## 9.5 GPU/accelerator subsystem

`<capability summary>`

## 9.6 Storage subsystem

`<capability summary>`

## 9.7 Network/external-I/O subsystem

`<capability summary>`

---

# 10. Capability vs Installed-State Summary

This section prevents theoretical component capability from being confused with actual installed configuration.

For each important domain use a compact format:

```text
Domain: CPU frequency
Theoretical/documented capability: ...
Installed/observed hardware state: ...
Difference/unknown: ...
Evidence/source: ...
```

Repeat for:

- CPU topology;
- CPU frequency capability;
- memory channels/speed;
- PCIe links;
- NUMA configuration;
- relevant I/O capability.

Do not turn differences into diagnoses.

---

# 11. Unknowns and Unavailable Data

Use explicit categories:

## Unknown

The fact could not be established reliably.

## Unavailable

A known source/interface is unavailable.

## Not collected

The preparation run did not collect the evidence.

## Not applicable

The field does not apply to this platform.

## Conflicting sources

Multiple sources provide incompatible values.

For every item that may matter later, state why it is unresolved and whether a later stage needs it.

---

# 12. Source Conflicts

Record each conflict explicitly.

```text
Conflict ID: C-###
Subject: ...
Observed target value: ...
External/documented value: ...
Sources: ...
Resolution: unresolved | target observation retained | other
Relevance for later stages: ...
```

Do not erase observed data because documentation disagrees.

---

# 13. Audit Completeness

## 13.1 Completed domains

- [ ] Platform identity
- [ ] CPU identity/topology
- [ ] CPU frequency capability table
- [ ] CPU power/thermal capability
- [ ] CPU performance-control capability
- [ ] Memory
- [ ] NUMA
- [ ] PCIe/I/O
- [ ] Firmware/ACPI
- [ ] External sources
- [ ] Unknowns/conflicts

## 13.2 Partial domains

`<list with reasons>`

## 13.3 Data intentionally deferred to Step 2

Examples:

- active CPU governor;
- intel_pstate mode;
- current HWP policy;
- current power limits as software policy;
- scheduler policy;
- current IRQ policy;
- runtime PM policy;
- sysctl values;
- tuning recommendations.

---

# 14. Handoff to Step 2

Provide only factual handoff information.

## Stable facts Step 2 may rely on

`<list of the most important specification facts and IDs>`

## Specification gaps Step 2 must preserve as unknown

`<list>`

## Evidence references likely useful to Step 2

`<list>`

Do not tell Step 2 what to diagnose or change.

---

# 15. Machine-Readable Companion

A completed audit should also produce `report.json` representing the same facts in machine-readable form.

The JSON companion must preserve:

- schema version;
- target identity;
- normalized values and units;
- evidence/source references;
- status values;
- unknowns/conflicts;
- capability-vs-installed-state distinction.

Do not add facts to `report.json` that are absent from the evidentiary basis of this Markdown report, and do not leave important JSON facts unexplained when human interpretation is required.

---

# 16. Final Audit Statement

End the completed report with a short statement covering:

1. whether the platform was identified sufficiently for Step 2;
2. the most important unresolved specification gaps;
3. whether any source conflicts remain;
4. confirmation that no Step 3 diagnosis or Step 4 materialization recommendation was intentionally performed.
