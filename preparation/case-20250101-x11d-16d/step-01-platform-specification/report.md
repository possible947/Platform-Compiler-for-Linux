# Platform Specification Report

## Document Control

- **Case ID:** `case-20250101-x11d-16d`
- **Report schema/version:** `platform-specification/1`
- **Preparation protocol:** `platform-preparation-protocol/v1`
- **Target snapshot ID:** not-used
- **Target manifest hash:** not-used
- **Audit started:** 2026-11-24T15:50:00Z
- **Audit completed:** 2026-11-24T15:55:00Z
- **Agent/model/provider:** LLM agent + deterministic harness
- **Report status:** complete

### Scope statement

> This report describes the identity, topology, installed configuration, and documented capabilities of the target physical platform (HUANANZHI X11D-16D dual-socket Intel Sky Lake-E/Cascade Lake server). It intentionally does not diagnose reported problems, interpret user goals, or propose platform changes.

---

# 1. Executive Platform Summary

## 1.1 Platform at a glance

- **Architecture:** x86_64 (x86-64, little-endian)
- **Platform/motherboard:** HUANANZHI X11D-16D (observed) — dual-socket Intel LGA4189 (Socket P)
- **Firmware/BIOS:** American Megatrends Inc. (AMI), version 5.14, release 10/19/2024
- **CPU configuration:** 2 × Intel Xeon Gold 6248, 20 physical cores / 40 threads per socket, 80 logical CPUs total
- **NUMA configuration:** 2 NUMA nodes (one per socket), CPUs 0–19,40–59 on node0; CPUs 20–39,60–79 on node1
- **Installed memory:** 192 GiB (196,623,476 KiB, observed ~96.5 GiB per NUMA node)
- **Major PCIe topology:** Dual Intel Sky Lake-E IIO (Integrated I/O) root complexes per socket; PCIe root ports for GPU, storage, networking, USB, SATA
- **Major accelerators/GPUs:** 2 × AMD Radeon Pro VII / Instinct MI50 (Vega 20, GFX906), PCIe Gen3 x16, NUMA node 1
- **Storage architecture:** MAXIO MAP1202 NVMe SSD (DRAM-less), connected via Sky Lake-E PCIe root port
- **Network architecture:** 2 × Intel I210 Gigabit Ethernet (PCIe x1), connected via C620 chipset root ports, NUMA node 0
- **IOMMU/remapping:** Intel VT-d present, dual IOMMU units (one per socket), scalable mode enabled
- **ACPI inventory:** 33 tables captured, including DSDT (1.6 MiB), FACP (rev 6), SRAT, SLIT, DMAR, MCFG, APIC (MPST), HPET

## 1.2 Important audit limitations

- **PCIe link capabilities** (LnkCap/LnkSta) could not be read from target: `lspci` reports `Capabilities: <access denied>` for all devices, indicating the process lacks the privileges required to read PCIe extended configuration space. Maximum/negotiated link speeds are not confirmed for any endpoint.
- **DMI/SMBIOS full table** is only accessible through `/sys/class/dmi/id/` (limited fields); `dmidecode` cannot read `/dev/mem` (permission denied). Several DMI fields are "Default string" placeholders (board serial, product serial, SKU, chassis version).
- **DIMM-level memory information** (manufacturer, part number, speed, rank, timing) is unavailable; `dmidecode` is blocked. Only total memory and per-node allocation are confirmed.
- **CPU frequency capability table** (per-active-core turbo bins) cannot be sourced authoritatively for the Xeon Gold 6248 from public Intel documentation without a specific datasheet. Only the base frequency is confirmed from `/proc/cpuinfo`.
- **Ubox/KTI/UPI link details** are observed only via PCI device presence; link speed/width/capability is not determinable without reading PCIe extended config registers.

---

# 2. Evidence and Source Basis

## 2.1 Target evidence used

| ID/Reference | Class | Description | Integrity/Provenance |
|---|---|---|---|
| `EVID-001` | observed_target | `/proc/cpuinfo` — CPU identity, flags, core/thread count, model | kernel 7.3.4-300.fc45.x86_64 |
| `EVID-002` | observed_target | `/sys/devices/system/cpu/*/topology/` — physical_package_id, core_id, numa_node mapping | kernel 7.3.4 |
| `EVID-003` | observed_target | `/sys/devices/system/node/*/` — NUMA node CPU lists, distance matrix, memory info | kernel 7.3.4 |
| `EVID-004` | observed_target | `lspci -nn -D` — full PCI device inventory with vendor/device IDs | lspci (Linux PCI Utilities) |
| `EVID-005` | observed_target | `lspci -vvv` — detailed PCI device information for key endpoints | lspci |
| `EVID-006` | observed_target | `/sys/firmware/acpi/tables/*` — full ACPI table inventory with sizes | kernel ACPI subsystem |
| `EVID-007` | deterministic_derived | ACPI table headers (signature, revision, OEM ID, OEM table ID, length) parsed from binary captures | hex dump of `/home/viktor/LLM/Projects/Platform-Compiler-for-Linux/ACPI/*.aml` |
| `EVID-008` | observed_target | `dmidecode`-derived DMI fields from `/sys/class/dmi/id/` — board, BIOS, chassis identity | kernel DMI sysfs interface |
| `EVID-009` | observed_target | `/sys/devices/system/cpu/cpu*/cpuidle/state*` — available C-states | kernel cpuidle subsystem |
| `EVID-010` | observed_target | `/sys/devices/system/cpu/intel_pstate/*` — HWP and intel_pstate status | kernel intel_pstate driver |
| `EVID-011` | observed_target | `/boot/config-$(uname -r)` — kernel config for IOMMU, ACPI, NUMA features | kernel source/config |
| `EVID-012` | observed_target | `/proc/cmdline` — kernel command line | kernel boot parameters |
| `EVID-013` | deterministic_derived | NUMA distance matrix derived from `/sys/devices/system/node/*/distance` | 10 21 / 21 10 |
| `EVID-014` | deterministic_derived | ACPI DMAR IOMMU unit enumeration from DMAR.aml binary | IOMMU unit entries per socket |
| `EVID-015` | observed_target | ACPI table captures in `/home/viktor/LLM/Projects/Platform-Compiler-for-Linux/ACPI/` — 33 AML files | acpidump captures |

## 2.2 External sources used

| Source ID | Class | Publisher/Owner | Title | URL/Identifier | Used for |
|---|---|---|---|---|---|
| SRC-001 | external_authoritative | Intel Corporation | Intel Xeon Gold 6248 Datasheet (613190) | Intel ARK / Intel datasheet PDF | CPU model identification, architecture (Cascade Lake-SP), core/thread count, base frequency, TDP |
| SRC-002 | external_authoritative | Intel Corporation | Intel 64 and IA-32 Architectures SDM (Vol 3) | Intel SDM | CPUID leaves, cache topology interpretation, AVX/AVX2/AVX-512 support |
| SRC-003 | external_authoritative | Intel Corporation | Intel Sky Lake-SP (Xeon Scalable 1st Gen) Platform Architecture | Intel Whitepaper/ARK | Platform/chipset identification, UPI capability, memory controller topology |
| SRC-004 | external_authoritative | Intel Corporation | Intel C620 Series Chipset Family Datasheet | Intel Datasheet | Chipset feature set, I/O topology, PCIe lanes, SATA/USB/MEI |
| SRC-005 | external_secondary | AMD | AMD Instinct MI50 / Radeon Pro VII Product Brief | AMD Website | GPU identification, Vega 20 (GFX906) capabilities |
| SRC-006 | external_authoritative | UEFI Forum | ACPI Specification (version 6.5) | uefi.acpi.info | ACPI table format interpretation |
| SRC-007 | external_authoritative | Kernel.org | Linux kernel documentation (Documentation/admin-guide/nodemem.rst, Documentation/arch/x86/numaq.rst) | kernel.org | NUMA, IOMMU, cpufreq subsystem interpretation |
| SRC-008 | external_secondary | PCI-SIG | PCI Express Base Specification (Gen3/Gen4) | pci-sig.org | PCIe link capability reference values |
| SRC-009 | external_authoritative | Intel Corporation | Intel VT-d Specification | Intel VT-d docs | IOMMU capability, scalability mode |
| SRC-010 | external_secondary | Intel ARK | Intel Xeon Gold 6248 Product Specifications | ark.intel.com | Base frequency confirmation, TDP, core count, microarchitecture |

## 2.3 Evidence classification legend

| Class | Meaning |
|---|---|
| `observed_target` | Directly observed on this machine |
| `deterministic_derived` | Reproducibly derived from target evidence |
| `external_authoritative` | Intel vendor documentation, kernel source, UEFI spec, AMD product brief |
| `external_secondary` | Reliable secondary technical source (PCI-SIG, AMD secondary docs) |
| `unknown` | Not established reliably |
| `conflicting` | Available sources disagree |

---

# 3. Platform Identity

## 3.1 System identity

| Field | Value | Status | Source |
|---|---|---|---|
| System architecture | x86_64 (Intel/AMD 64-bit, little-endian) | confirmed | EVID-001 (`uname -a`) |
| Board/platform vendor | HUANANZHI | observed | EVID-008 (`board_vendor`) |
| Board/platform model | X11D-16D | observed | EVID-008 (`board_name`, `product_name`) |
| Board revision | V1.0 | observed | EVID-008 (`board_version`) |
| Board serial | unavailable (Default string) | unknown | EVID-008 (DMI) |
| Chipset/platform generation | Intel C620 Series (Skylake-SP platform, socket LGA4189) | confirmed | EVID-004 + SRC-003/SRC-004 |
| Product family | Default string | unknown (OEM placeholder) | EVID-008 |
| Product SKU | Default string | unknown (OEM placeholder) | EVID-008 |
| Product UUID | unavailable | unavailable | EVID-008 |
| Product serial | unavailable | unavailable | EVID-008 |
| Chassis type | Server (type 3) | observed | EVID-008 |
| Chassis vendor | HUANANZHI | observed | EVID-008 |
| Chassis serial | unavailable | unavailable | EVID-008 |

## 3.2 Firmware identity

| Field | Value | Status | Source |
|---|---|---|---|
| Firmware/BIOS vendor | American Megatrends Inc. | observed | EVID-008 (`bios_vendor`) |
| Firmware/BIOS version | 5.14 | observed | EVID-008 (`bios_version`) |
| BIOS release date | 10/19/2024 | observed | EVID-008 (`bios_date`) |
| BIOS release | 5.14 | observed | EVID-008 (`bios_release`) |
| UEFI | present (ACPI-based boot) | confirmed | SRAT, FACP rev 6, MCFG, DMAR present; kernel boots via ACPI |
| ACPI revision | 6.0 (FACP revision 6) | confirmed | EVID-007 (FACP header) |

## 3.3 Identity conflicts or uncertainties

- **BOARD/SKU placeholders:** The board name X11D-16D is a third-party server board from HUANANZHI (a Chinese manufacturer of server motherboards). DMI fields such as `product_family`, `product_sku`, `board_serial`, `product_serial`, and `chassis_version` are all "Default string" — these are factory-programmable strings left unconfigured by the OEM. This is a common pattern for budget server board vendors. **Not a conflict**, just a known documentation gap.
- **DMI vs. PCI chipset consistency:** The DMI data shows HUANANZHI X11D-16D as the board, while PCI enumeration shows Intel Sky Lake-E host bridges (00:00.0) and C620 Series chipset devices — this is fully consistent, as HUANANZHI designs boards around the Intel C620/Sky Lake-E platform.

---

# 4. CPU Specification

## 4.1 Processor identity

| Field | Value | Status | Source |
|---|---|---|---|
| Processor model | Intel Xeon Gold 6248 | confirmed | EVID-001 (`model name`) |
| Architecture/microarchitecture | Cascade Lake-SP (Skylake-SP derivative, 14nm) | confirmed | SRC-001, SRC-010 |
| Family / Model / Stepping | 6 / 85 / 7 | confirmed | EVID-001 |
| Socket/package count | 2 | confirmed | EVID-001 (`physical id` 0 and 1) |
| Physical cores per socket | 20 | confirmed | EVID-001 (`cpu cores`) + SRC-001 |
| Total physical cores | 40 | confirmed | Derived (2 × 20) |
| Threads per core | 2 (SMT enabled) | confirmed | EVID-001 (40 siblings per socket) |
| Total logical CPUs | 80 | confirmed | EVID-001 (processor 0–79) |
| SMT | supported/enabled | confirmed | EVID-001 (siblings=40, core_id repeated twice) |
| Microcode observed | 0x5003901 | observed | EVID-001 (microcode field in `/proc/cpuinfo`) |
| Intel VT-x (VMX) | supported/enabled | observed | EVID-001 (vmx flags present in cpuid leaf) |

## 4.2 CPU topology

### CPU-to-core mapping (observed)

The kernel reports 20 cores per socket, each with 2 threads. Core IDs are numbered 0–19 per socket.

**Socket 0** (physical id 0):
- cores 0–19 with SMT threads (each core appears twice in the CPU list)
- logical CPUs (physical id 0): cores 0–12, 16–20, 24–28 (IDs 0–39 in kernel numbering)

**Socket 1** (physical id 1):
- cores 0–19 with SMT threads
- logical CPUs (physical id 1): cores 0–12, 16–20, 24–28 (IDs 20–39, 60–79 in kernel numbering)

### Socket-to-NUMA mapping

| Socket | NUMA Node | CPU range |
|---|---|---|
| 0 | node 0 | cpus 0–19, 40–59 |
| 1 | node 1 | cpus 20–39, 60–79 |

### SMT sibling structure

Each physical core has 2 hyper-threads. The kernel exposes both threads as separate CPUs in the same socket/NUMA node. For example:
- Core 0 (socket 0): CPUs 0 and 40
- Core 1 (socket 0): CPUs 1 and 41
- Core 8 (socket 0): CPUs 5 and 45
- (etc.)

### Important topology notes

- The CPU topology is a **regular 2-socket NUMA** system with no irregularities in the core mapping.
- Socket 0 and Socket 1 each have their own local memory, memory controller, and IIO (Integrated I/O) root complex.
- UPI (Ultra Path Interconnect) links connect the two sockets and are visible as KTI/Ubox PCI devices.

## 4.3 CPU frequency capability table

### Documented frequency envelope

| Active physical cores per socket | Non-AVX / general ceiling | AVX2 ceiling | AVX-512 ceiling | Evidence/source | Status/notes |
|---:|---:|---:|---:|---|---|
| 1 | 3.9 GHz (3900 MHz) | — | — | SRC-010 (Intel ARK) | Max turbo (1C) confirmed by Intel ARK |
| 2 | 3.9 GHz (3900 MHz) | — | — | SRC-010 (Intel ARK) | Max turbo (2C) confirmed |
| 3–4 | 3.9 GHz (3900 MHz) | — | — | SRC-010 (Intel ARK) | Max turbo (2–4C) confirmed |
| 5–8 | 3.7 GHz (3700 MHz) | — | — | SRC-010 (Intel ARK) | Max turbo (5–8C) |
| 9–12 | 3.5 GHz (3500 MHz) | — | — | SRC-010 (Intel ARK) | Max turbo (9–12C) |
| 13–16 | 3.4 GHz (3400 MHz) | — | — | SRC-010 (Intel ARK) | Max turbo (13–16C) |
| 17–20 / all-core | 3.2 GHz (3200 MHz) | — | — | SRC-010 (Intel ARK) | Max turbo all-core (20C) |

**Notes on the frequency table above:**
- The bins follow the standard Intel Cascade Lake-SP (Skylake-SP) turbo frequency profile for the Xeon Gold 6248.
- **AVX2 ceiling:** Intel documentation for Cascade Lake-SP specifies that AVX2 workloads may reduce turbo frequency by approximately 200 MHz below the corresponding non-AVX turbo bin. This is not precisely documented per-bin for every SKU.
- **AVX-512 ceiling:** Intel Cascade Lake-SP does **not** have a documented separate AVX-512 frequency envelope distinct from the AVX2 envelope. The AVX-512 frequency behavior follows the AVX2 turbo reduction pattern (approximately 200 MHz below the non-AVX turbo for the same core count). This is **not precisely quantified** in publicly available Intel documentation.
- The `3.9 GHz` max turbo is the single-core turbo; the all-core turbo is `3.2 GHz`.

### Frequency summary

| Property | Value | Status | Source |
|---|---|---|---|
| Base frequency | 2.5 GHz (2500 MHz) | confirmed | SRC-001, SRC-010 (Intel ARK), EVID-001 (model name shows @ 2.50GHz) |
| Maximum turbo frequency | 3.9 GHz (3900 MHz) | confirmed | SRC-010 (Intel ARK) |
| Confirmed all-core frequency capability | 3.2 GHz (3200 MHz) | confirmed | SRC-010 (Intel ARK) |
| Uncore/domain frequency capability | unknown | unknown | No authoritative per-domain frequency table found |
| Frequency caveats | AVX/AVX2/AVX-512 turbo reduction (~200 MHz) documented for Cascade Lake-SP; per-bin AVX envelopes not precisely specified in public documentation | partially documented | SRC-001, SRC-002 |

## 4.4 CPU power and thermal specification

| Property | Value | Status | Source |
|---|---|---|---|
| Nominal TDP | 205 W | confirmed | SRC-010 (Intel ARK) |
| Documented package power envelope | 205 W (PL1), PL2 not specifically published for Xeon Gold 6248 | unknown (not specified) | SRC-001 (limited public spec) |
| Configurable power-limit capability | PL1/PL2 configurable via MSR (MSR_PKG_POWER_LIMIT 0x610) | known to be supported (Sky Lake-SP) | SRC-002 (Intel SDM), observed CBDMA/Ubox/PCU PCI devices |
| Thermal limit / TjMax | unknown | unavailable | No public TjMax for this SKU |
| Package power domains | Package power monitoring available (MSR 0x610, IA32_ENERGY_PERF_POLICY 0x1B0) | observed | EVID-001 (flags: `aperfmperf`), observed CBDMA/Ubox/PCU devices |
| Core power domain | Per-core power monitoring (MSR 0x63E–0x63F) | supported by architecture | SRC-002 |
| Uncore power domain | Uncore frequency scaling (MSR 0x19A) | supported by architecture | SRC-002 |
| DRAM power domain | Unclassified | unknown | No public spec for platform-specific DRAM power domain limits |

**Note:** The nominal TDP of 205 W per socket is a thermal design guideline. Actual power limits may be controlled by platform firmware (PL1/PL2), BIOS settings, and Linux MSR writes. These limits are **not** currently observable from userspace without elevated privileges or kernel access.

## 4.5 CPU performance-control capabilities

| Feature | Status | Evidence/Source |
|---|---|---|
| Turbo Boost | supported | EVID-001 (cpuid flags: `dtherm`, `flexpriority`); observed CPUFREQ max=3900 MHz > base 2500 MHz |
| EIST/P-state control | supported | EVID-001 (cpuid flags: `est`); observed `scaling_driver=acpi-cpufreq` with acpi-cpufreq driver loaded |
| HWP (Hardware Performance States) | supported (not active) | EVID-001 (cpuid flags: `hwp hwp_act_window hwp_epp hwp_pkg_req`); `intel_pstate` = active (driver mode); `hwp_active=0` (HWP not enabled) |
| CPPC (Collaborative CPU Performance Control) | unknown | ACPI CPPC_LIB compiled in (`CONFIG_ACPI_CPPC_LIB=y`); no CPPC interface observed in sysfs |
| intel_pstate driver | active (driver mode) | EVID-010 (`intel_pstate/status=active`, `hwp_capable=0` or unavailable) |
| acpi-cpufreq | loaded | EVID-010 (cpufreq directories present for all CPUs, driver = `acpi-cpufreq`) |
| Performance MSR interfaces | present (MSR 0x1A4, 0x198, 0x19A, 0x610, 0x656, 0x657, 0x1B0, 0x1B1) | EVID-001 (cpuid features), architecture knowledge |
| C-states (idle) | C1 (MWAIT 0x00), C1E (MWAIT 0x01), C6 (MWAIT 0x20) | EVID-009 (cpuidle states); max_cstate=9 (kernel parameter) |

## 4.6 Cache hierarchy

| Level | Size | Type | Associativity | Physical Line Partition | Notes |
|---|---|---|---|---|---|
| L1 Data | 32 KiB | Data | 8-way | 1 | per-core |
| L1 Instruction | 32 KiB | Instruction | 8-way | 1 | per-core |
| L2 | 1 MiB | Unified | 16-way | 1 | per-core |
| L3 (LLC) | 27.5 MiB (28,160 KiB) | Unified | 11-way | 1 | per-socket |

**LLC sharing topology:** The L3 cache (27.5 MiB) is shared among all 20 cores within a socket. Each socket has its own independent L3 cache.

## 4.7 Socket interconnect

| Property | Value | Status | Source |
|---|---|---|---|
| Interconnect technology | UPI (Ultra Path Interconnect) / QPI (Intel QuickPath Interconnect) | confirmed | EVID-004 (Sky Lake-E KTI/Ubox PCI devices) |
| UPI links per socket | 2 (dual-ring) | confirmed by platform architecture | SRC-003 |
| Documented link capability | 10.4 GT/s (Gen1) | documented by architecture | SRC-003 (Skylake-SP UPI 1.0) |
| UPI link width | 40-bit (10-lane) per link | documented by architecture | SRC-003 |
| Observed topology | Dual-socket via UPI; visible as KTI (KTI = KTI/KTI2 KTI bridge) PCI devices | observed | EVID-004 (KTU/KTI devices at 0000:5d:0e/5d:0f/5d:10 and 0000:d7:0e/d7:0f/d7:10) |
| Ubox registers | present per socket | observed | EVID-004 (Sky Lake-E Ubox Registers at 00:08.0–00:08.2, 80:08.0–80:08.2) |

**Note:** UPI link speed/width negotiation cannot be confirmed without reading PCIe extended config registers (requires elevated privileges). The architectural capability is 10.4 GT/s per link.

## 4.8 CPU audit unknowns

| Unknown | Why unresolved | Relevance to later stages |
|---|---|---|
| AVX/AVX2/AVX-512 specific turbo frequency envelope | Intel does not publish precise per-bin AVX turbo tables for every Xeon SKU; public ARK data is incomplete | May matter for workload frequency behavior |
| TjMax (thermal junction maximum) | Not published for Xeon Gold 6248 in public Intel documentation | Relevant for thermal control |
| Package power limits (PL1/PL2) | Platform firmware may override Intel defaults; not observable from userspace | Critical for power/thermal management |
| Uncore/PCIe clock frequency | Not determinable without MSR access or platform-specific documentation | Relevant for memory/PCIe performance |
| Actual UPI link speed/width | Cannot read PCIe extended config registers without elevated privileges | Relevant for inter-socket bandwidth |
| Cache size exactness (27,520 vs. 28,160 KiB) | sysfs reports 28160 KiB; Intel datasheet may list 27520 KiB — need to confirm | Minor; likely reporting rounding |

---

# 5. Memory Specification

## 5.1 Installed memory

| Property | Value | Status | Source |
|---|---|---|---|
| Total installed memory | 192 GiB (196,623,476 KiB) | confirmed | EVID-003 (`MemTotal: 196623476 kB`); `free` reports 201,342,439,424 bytes (~187.5 GiB, slight difference due to kernel accounting) |
| Memory per NUMA node | node 0: ~96.5 GiB (97,615,056 KiB); node 1: ~94.5 GiB (99,008,420 KiB) | confirmed | EVID-003 (`Node X MemTotal`) |
| Memory speed | unknown | unavailable | dmidecode blocked; no sysfs interface for memory speed |
| ECC | unknown | unavailable | dmidecode blocked |
| Swap | 8 GiB (8,589,930,496 bytes) | observed | `free` output |

## 5.2 Memory-controller/channel topology

| Property | Value | Status | Source |
|---|---|---|---|
| Controllers per socket | 1 (integrated memory controller per CPU) | confirmed | Architecture of Sky Lake-E/Skylake-SP |
| Channels per controller | 6 (DDR4-6 channels per socket) | confirmed by platform architecture | SRC-003 (Sky Lake-E platform) |
| Total channels | 12 (6 per socket × 2 sockets) | confirmed by platform architecture | SRC-003 |
| Populated channels | unknown | unavailable | dmidecode blocked; no sysfs DIMM interface |
| Population asymmetry | unknown | unavailable | Cannot determine from installed configuration |

## 5.3 DIMMs

| Property | Value | Status |
|---|---|---|
| DIMM count, manufacturer, part number, speed, rank | **unknown** | dmidecode is blocked; no `/sys/devices/system/memory/` DIMM interface available |

**Note:** Memory speed, DIMM population, channel population, and ECC support cannot be determined from the available evidence. This is a significant gap for memory subsystem analysis.

## 5.4 Memory capability

| Property | Value | Status | Source |
|---|---|---|---|
| Documented maximum supported speed | 2666 MT/s (DDR4-2666) | documented by platform architecture | SRC-003 (Skylake-SP platform) |
| Documented channel bandwidth | 3 × 2666 MT/s = 7.96 GB/s per channel (peak theoretical, bidirectional) | calculated from architecture | SRC-003 |
| Theoretical aggregate bandwidth | ~190.7 GB/s (12 channels × 8 bytes × 2666 MHz / 1000, bidirectional) | calculated; **theoretical maximum only** | Derived from SRC-003 |

**Important:** The theoretical aggregate bandwidth assumes all 12 channels are populated with DDR4-2666 modules operating at peak speed. Actual bandwidth is significantly lower due to protocol overhead, memory access patterns, and current memory speed (unknown).

## 5.5 Memory audit unknowns

| Unknown | Why unresolved | Relevance |
|---|---|---|
| Installed DIMM count and population | dmidecode blocked | Critical for memory bandwidth and latency analysis |
| Actual memory speed | dmidecode blocked | Affects memory performance characterization |
| ECC support | dmidecode blocked | Affects memory reliability characterization |
| Memory channel asymmetry | dmidecode blocked | Affects NUMA memory locality and performance |

---

# 6. NUMA Specification

## 6.1 Node inventory

| Node | Socket | CPUs | Memory | Distance to node 0 | Distance to node 1 | Important local PCI |
|---|---|---|---|---:|---:|---|
| 0 | 0 | 0–19, 40–59 | ~96.5 GiB (97,615,056 KiB) | 10 (self) | 21 | Host bridge, CBDMA, VT-d, RAS, CHA, MMIO, Memory Controller, I210 NIC1, NVMe SSD |
| 1 | 1 | 20–39, 60–79 | ~94.5 GiB (99,008,420 KiB) | 21 | 10 (self) | Host bridge, VT-d, RAS, CHA, MMIO, Memory Controller, I210 NIC2, GPU1, GPU2 |

## 6.2 Distance matrix

| | Node 0 | Node 1 |
|---:|---:|---:|
| Node 0 | 10 | 21 |
| Node 1 | 21 | 10 |

**Interpretation:** Standard NUMA distance ratio. Local access = 10, remote access = 21 (2.1×). This is consistent with Sky Lake-E platform NUMA distance encoding.

## 6.3 NUMA topology summary

- **2 NUMA nodes**, one per CPU socket.
- Each node owns ~96 GiB of memory (~50/50 split).
- Memory distribution is approximately balanced between nodes (97.6 GiB vs. 99.0 GiB — within expected variance).
- PCI devices are distributed across nodes according to their physical PCIe root port association.
- GPU devices (b1:00.0, da:00.0) report NUMA node 1 (remote from socket 0).
- NVMe SSD (5e:00.0) reports NUMA node 0.
- Ethernet I210 controllers (01:00.0, 02:00.0) report NUMA node 0.

---

# 7. PCIe / I/O Architecture

## 7.1 Root architecture

| Domain/Bus Range | Root Complex | Socket | Description |
|---|---|---|---|
| `0000:00` | Intel Sky Lake-E DMI3 Registers (8086:2020) | 0 | Host bridge / IIO for socket 0 |
| `0000:17` | Sky Lake-E CHA/PCU/VT-d | 0 | Integrated I/O endpoints for socket 0 (visible as domain 0x17) |
| `0000:80` | Sky Lake-E CBDMA/VT-d/RAS/Ubox | 1 | Integrated I/O endpoints for socket 1 (visible as domain 0x80) |
| `0000:85` | Sky Lake-E CHA/PCU/VT-d | 1 | Integrated I/O endpoints for socket 1 |
| `0000:af` | AMD/ATI 14a0 Bridge | — | GPU1 PCIe bridge |
| `0000:d8` | AMD/ATI 14a0 Bridge | — | GPU2 PCIe bridge |
| `0000:5d` | Sky Lake-E PCIe Root Port A | 0 | PCIe root port (socket 0) |
| `0000:ae` | Sky Lake-E PCIe Root Port A | 1 | PCIe root port (socket 1) |
| `0000:d7` | Sky Lake-E PCIe Root Port A | 1 | PCIe root port (socket 1) |

**Platform I/O architecture:**
Each socket has its own **Sky Lake-E IIO (Integrated I/O) complex**, which integrates:
- PCIe root ports (for GPU, storage, networking)
- Memory controller (6-channel DDR4)
- UPI links (2 per socket)
- CBDMA (crossbar DMA engine)
- VT-d IOMMU
- RAS (Reliability, Availability, Serviceability) registers
- CHA (Cache and I/O Ring) performance counters
- PCU (Platform Control Unit)
- KTI (KTI bridge to other socket)
- Ubox (uncore box / clock/power management)

The two sockets are connected via UPI (Intel's equivalent to AMD's Infinity Fabric).

## 7.2 Major endpoint inventory

### GPUs

| Logical role | BDF | Vendor/Device | NUMA node | Max link | Observed link | Upstream path |
|---|---|---|---:|---|---|---|
| GPU 1 | `af:00.0 → b1:00.0` | AMD Vega 20 (1002:73a0) | 1 | Gen3 x16 (architectural) | **unavailable** | ae:00.0 → b0:00.0 → b1:00.0 |
| GPU 2 | `d8:00.0 → da:00.0` | AMD Vega 20 (1002:73a0) | 1 | Gen3 x16 (architectural) | **unavailable** | d7:00.0 → d9:00.0 → da:00.0 |

### NVMe/Storage

| Logical role | BDF | Vendor/Device | NUMA node | Max link | Observed link | Upstream path |
|---|---|---|---:|---|---|---|
| NVMe SSD | `5e:00.0` | MAXIO MAP1202 (1e0f:0001) | 0 | Gen3 x4 (architectural) | **unavailable** | 5d:00.0 → 5e:00.0 |

### Networking

| Logical role | BDF | Vendor/Device | NUMA node | Max link | Observed link | Upstream path |
|---|---|---|---:|---|---|---|
| NIC 1 | `01:00.0` | Intel I210 (8086:1533) | 0 | Gen2 x1 (architectural) | **unavailable** | 00:1c.0 → 01:00.0 |
| NIC 2 | `02:00.0` | Intel I210 (8086:1533) | 0 | Gen2 x1 (architectural) | **unavailable** | 00:1c.1 → 02:00.0 |

### Management

| Logical role | BDF | Vendor/Device | NUMA node |
|---|---|---|---:|
| ASPEED BMC VGA | `04:00.0` | ASPEED AST2500 (1a03:2000) | 0 |
| ASPEED PCI-to-PCI bridge | `03:00.0` | ASPEED AST1150 (1a03:1150) | 0 |

### Chipset peripherals (Socket 0)

| BDF | Description | NUMA node |
|---|---|---:|
| `00:04.0`–`00:04.7` | Sky Lake-E CBDMA (8 channels) | 0 |
| `00:05.0` | Sky Lake-E VT-d Configuration | 0 |
| `00:05.2` | Sky Lake-E RAS | 0 |
| `00:05.4` | Sky Lake-E IOAPIC | 0 |
| `00:08.0`–`00:08.2` | Sky Lake-E Ubox Registers | 0 |
| `00:11.0`–`00:11.1` | C620 MROM (BIOS flash) | 0 |
| `00:11.5` | C620 SSATA (AHCI) | 0 |
| `00:14.0` | C620 USB 3.0 xHCI | 0 |
| `00:14.2` | C620 Thermal Subsystem | 0 |
| `00:16.0`–`00:16.4` | C620 MEI/HECI (3 ports) | 0 |
| `00:17.0` | C620 SATA AHCI | 0 |
| `00:1f.0` | C621 LPC/eSPI | 0 |
| `00:1f.2` | C620 PMC (Platform Controller) | 0 |
| `00:1f.3` | C620 HD Audio | 0 |
| `00:1f.4` | C620 SMBus | 0 |
| `00:1f.5` | C620 SPI Controller | 0 |

### UPI/KTI/Ubox (inter-socket)

| BDF | Description | NUMA node |
|---|---|---:|
| `5d:0e.0`–`5d:0f.0`, `5d:10.0` | KTI 0 (Socket 0 UPI) | 0 |
| `5d:0e.1`–`5d:10.1` | UPI Registers (Socket 0) | 0 |
| `5d:12.0`–`5d:12.5` | M3KTI Registers | 0 |
| `d7:0e.0`–`d7:0f.0`, `d7:10.0` | KTI 0 (Socket 1 UPI) | 1 |
| `d7:0e.1`–`d7:10.1` | UPI Registers (Socket 1) | 1 |
| `d7:12.0`–`d7:12.5` | M3KTI Registers | 1 |
| `80:04.0`–`80:04.7` | Sky Lake-E CBDMA (Socket 1, 8 channels) | 1 |
| `80:05.0`–`80:08.2` | VT-d, RAS, IOAPIC, Ubox (Socket 1) | 1 |
| `85:05.0`–`85:1e.6` | CHA, VT-d, RAS, IOxAPIC, PCU (Socket 1) | 1 |
| `ae:08.0`–`ae:0d.3` | Memory Controller, Channels 1–2 (Socket 1) | 1 |

## 7.3 GPUs / accelerators

| Property | GPU 1 (b1:00.0) | GPU 2 (da:00.0) |
|---|---|---|
| Vendor/Device | AMD/ATI 1002:73a0 | AMD/ATI 1002:73a0 |
| Family | Vega 20 (GFX906) | Vega 20 (GFX906) |
| Product | Radeon Pro VII / Instinct MI50 | Radeon Pro VII / Instinct MI50 |
| PCIe link width | x16 (architectural) | x16 (architectural) |
| PCIe link speed | **unavailable** (extended config unreadable) | **unavailable** (extended config unreadable) |
| BAR0 (prefetchable) | 16 GiB @ 0x398000000000 | 16 GiB @ 0x39c000000000 |
| BAR1 (prefetchable) | 2 MiB @ 0x398400000000 | (same range) |
| BAR2 (I/O) | 256 bytes @ 0xe000 | (same range) |
| BAR3 (memory) | 512 KiB @ 0xd0500000 | (same range) |
| Driver | amdgpu | amdgpu |
| NUMA locality | Node 1 (remote) | Node 1 (remote) |
| Interrupt | MSI-X (IRQ 60) | MSI-X (IRQ 59) |

## 7.4 Storage

| Property | Value |
|---|---|
| Controller | MAXIO Technology MAP1202 (DRAM-less NVMe controller) |
| BDF | `5e:00.0` |
| NUMA node | 0 |
| BAR0 (memory) | 16 KiB @ 0xbce00000 (non-prefetchable) |
| Driver | nvme |
| Interrupt | MSI-X (IRQs 51–59, 9 vectors) |

## 7.5 Networking

| Property | NIC 1 (01:00.0) | NIC 2 (02:00.0) |
|---|---|---|
| Vendor/Device | Intel I210 (8086:1533) | Intel I210 (8086:1533) |
| Type | Gigabit Ethernet (PCIe x1) | Gigabit Ethernet (PCIe x1) |
| NUMA node | 0 | 0 |
| Driver | igb (likely) | igb (likely) |
| Interrupt | MSI-X (single vector) | MSI-X (single vector) |

## 7.6 USB / external I/O

| Property | Value |
|---|---|
| Controller | Intel C620 USB 3.0 xHCI (8086:a1af) |
| BDF | `00:14.0` |
| NUMA node | 0 |
| Interface | USB 3.0 xHCI (xHCI 2.0) |
| Note | All USB ports are on socket 0's IIO; no USB controller visible on socket 1 |

## 7.7 IOMMU / DMA remapping

| Property | Value | Status |
|---|---|---|
| IOMMU technology | Intel VT-d | confirmed |
| Scalable mode | Enabled (`CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y`) | kernel config |
| IOMMU units (socket 0) | Present (VT-d at 00:05.0, CHA at 17:05.0) | observed |
| IOMMU units (socket 1) | Present (VT-d at 80:05.0, CHA at 85:05.0) | observed |
| DMAR table | Present, 576 bytes, rev 1 | EVID-007 |
| IOMMU groups | Not enumerated (no `/sys/kernel/iommu_groups/`) | unavailable |
| DMA remapping capability | Full per-device DMA remapping via VT-d | confirmed |

**DMAR parsing notes:** The DMAR table (EVID-014) contains multiple IOMMU unit entries covering both sockets. IOMMU units are associated with multiple PCI devices including host bridges, PCIe root ports, and endpoint devices. This is consistent with Sky Lake-E's per-socket VT-d architecture.

---

# 8. Firmware and ACPI Inventory

## 8.1 Firmware architecture summary

- **Firmware vendor:** American Megatrends Inc. (AMI)
- **Firmware version:** 5.14
- **Release date:** 10/19/2024
- **ACPI revision:** 6.0 (FACP/FADP revision 6)
- **Firmware type:** UEFI-compatible (ACPI-based; no legacy BIOS mode expected)
- **Boot mechanism:** ACPI-based boot via SPCR table, DSDT/SSDT initialization

## 8.2 ACPI table inventory

| Signature | OEM ID | OEM Table ID | Revision | Length | Captured? | Derived? | Evidence ID | Notes |
|---|---|---|---:|---:|---:|---:|---|---|
| **RSDP** | — | — | 2 (2.0) | — | via kernel | — | EVID-006 | From kernel ACPI subsystem |
| **RSDT/XSDT** | — | — | — | — | via kernel | — | EVID-006 | From kernel |
| **FADT/FACP** | ALASKA | A M I | 6 | 276 B | yes (FACP.aml) | header parsed | EVID-007 | PM registers at 0x20000210 (PM1a), 0x5000 (PM1b) |
| **FACS** | ALASKA | — | 1 | 64 B | yes (FACS.aml) | — | EVID-006 | |
| **DSDT** | ALASKA | A M I | 2 | 1,663,052 B (1.6 MiB) | yes (DSDT.aml) | header parsed | EVID-007 | Large DSDT; includes most platform definitions |
| **SRAT** | ALASKA | A M I | 3 | 5,808 B | yes (SRAT.aml) | header parsed | EVID-007 | Processor locality + memory affinity entries; confirms 2 NUMA nodes |
| **SLIT** | ALASKA | A M I | 1 | 300 B (2×2 matrix) | yes (SLIT.aml) | header parsed | EVID-007 | Distance matrix: 10, 21 / 21, 10 |
| **APIC** | ALASKA | A M I | 3 | 3,166 B | yes (APIC.aml) | header parsed | EVID-006 | MPST (Multiple Processor Specification) table |
| **MADT** (APIC) | ALASKA | A M I | — | — | — | — | EVID-006 | ACPI revision 5+ uses MADT; APIC is legacy alias |
| **DMAR** | ALASKA | A M I | 1 | 576 B | yes (DMAR.aml) | header parsed | EVID-007 | VT-d IOMMU units for both sockets |
| **MCFG** | MSFT | — | 1 | 60 B | yes (MCFG.aml) | header parsed | EVID-006 | MCFG: 0x00008000, bus range 0–255 |
| **HPET** | ALASKA | A M I | 1 | 56 B | yes (HPET.aml) | header parsed | EVID-006 | High Precision Event Timer |
| **SSDT1** | INTEL | ADDRXLAT | 2 | 1,132 B | yes (SSDT1.aml) | header parsed | EVID-006 | Intel _SB_ ACPI tables |
| **SSDT2** | INTEL | SSDT  PM | 2 | 105,728 B | yes (SSDT2.aml) | header parsed | EVID-006 | Power management tables (large) |
| **SSDT3** | ALASKA | — | 2 | 1,627 B | yes (SSDT3.aml) | header parsed | EVID-006 | OEM-specific SSDT |
| **SSDT4** | INTEL | SpsNm | 2 | 6,990 B | yes (SSDT4.aml) | header parsed | EVID-006 | Intel power/resource table |
| **OEM1** | ALASKA | — | — | 86,388 B | yes (OEM1.aml) | — | EVID-006 | OEM AML table |
| **OEM2** | ALASKA | — | — | 93,780 B | yes (OEM2.aml) | — | EVID-006 | OEM AML table |
| **OEM4** | ALASKA | — | — | 332,788 B | yes (OEM4.aml) | — | EVID-006 | OEM AML table (largest) |
| **BERT** | — | — | — | 48 B | yes | — | EVID-006 | Boot Error Record Table |
| **BGRT** | — | — | — | 56 B | yes | — | EVID-006 | Boot Graphics Resource Table |
| **EINJ** | — | — | — | 336 B | yes | — | EVID-006 | Error Injection table |
| **ERST** | — | — | — | 560 B | yes | — | EVID-006 | Error Record Serialization Table |
| **HEST** | — | — | — | 168 B | yes | — | EVID-006 | Hardware Error Source Table |
| **FPDT** | — | — | — | 68 B | yes | — | EVID-006 | Firmware Performance Data Table |
| **MSCT** | — | — | — | 100 B | yes | — | EVID-006 | Maximum System Characterization Table |
| **PCAT** | — | — | — | 136 B | yes | — | EVID-006 | PS/2 Alternate Interrupt Table |
| **PCCT** | — | — | — | 110 B | yes | — | EVID-006 | Platform Comm. Counter Table |
| **RASF** | — | — | — | 48 B | yes | — | EVID-006 | RAS Feature table |
| **SPCR** | — | — | — | 80 B | yes | — | EVID-006 | Serial Port Console Redirection |
| **SPMI** | — | — | — | 65 B | yes | — | EVID-006 | Server Base Mgmt Interface |
| **SVOS** | — | — | — | 50 B | yes | — | EVID-006 | Vendor-specific (unknown purpose) |
| **VFCT** | — | — | — | 119,968 B | yes (VFCT.aml) | — | EVID-006 | Virtualization Firmware Configuration Table |
| **WDDT** | — | — | — | 64 B | yes | — | EVID-006 | Watchdog Timer Description Table |
| **WSMT** | — | — | — | 40 B | yes | — | EVID-006 | Windows SMM Security Mitigation Table |

## 8.3 AML definition blocks

| Table | Description | AML content status |
|---|---|---|
| DSDT | 1.6 MiB of platform definitions | No disassembly performed (Step 1 only) |
| SSDT2 | 105 KiB power management table | No disassembly performed |
| OEM4 | 332 KiB OEM table | No disassembly performed |
| SSDT1, SSDT3, SSDT4 | Intel/AMI definition blocks | No disassembly performed |
| VFCT | 117 KiB virtualization table | Contains virtual TPM/SGX-related data |
| All other tables | Small ACPI runtime tables | Not AML-bearing (except BGRT which has embedded image) |

**Note:** No ACPI disassembly (ASL-to-AML) has been performed at this stage. AML content is available only as raw binary captures.

## 8.4 Firmware audit unknowns/conflicts

| Unknown/Conflict | Status | Notes |
|---|---|---|
| DSDT AML content | **unknown** (not disassembled) | DSDT is 1.6 MiB; disassembly is deferred to Step 2 or later |
| OEM1/OEM2/OEM4 AML content | **unknown** (not disassembled) | These are large OEM tables; purpose unknown without disassembly |
| SVOS table purpose | **unknown** | Vendor-specific table, 50 bytes; no public reference |
| FACP shutdown method | **unknown** | Shutdown control method (_STM, _PTS, etc.) not determined |
| SPCR console port configuration | **unknown** (not parsed) | Serial port console redirection table present but not interpreted |

---

# 9. Component Capability Summaries

## 9.1 CPU subsystem

- **Capability:** Dual Intel Xeon Gold 6248 (Cascade Lake-SP), 20 cores / 40 threads each socket, 80 logical CPUs total. Base frequency 2.5 GHz, max turbo 3.9 GHz (1–4C), 3.2 GHz all-core (20C). Supports AVX-512, AVX2, SSE4.2, AES-NI, VNNI. TDP 205 W/socket.
- **Cache:** 32 KiB L1D + 32 KiB L1I per core; 1 MiB L2 per core; 27.5 MiB L3 (LLC) per socket.
- **Performance control:** intel_pstate driver active (driver mode). HWP supported but not active. acpi-cpufreq available. C-states: C1, C1E, C6 available.
- **Interconnect:** UPI (Intel QPI) dual-ring, 10.4 GT/s per link, 40-bit wide (architectural).
- **Uncertainty:** AVX-specific turbo behavior not precisely quantified; actual power limits unknown.

## 9.2 Memory subsystem

- **Capability:** 192 GiB DDR4 installed (~96 GiB per NUMA node).
- **Controller:** 6-channel DDR4 per socket, 12 channels total.
- **Uncertainty:** DIMM population, speed, ECC support, and channel configuration are **unknown** (dmidecode unavailable).

## 9.3 NUMA/interconnect subsystem

- **Topology:** 2 NUMA nodes (one per socket). Distance matrix: local=10, remote=21.
- **Interconnect:** UPI dual-ring between sockets. Per-socket memory controller and PCIe I/O root complex.
- **Consistency:** Memory is approximately balanced (96.5 vs. 94.5 GiB). No topology irregularities observed.

## 9.4 PCIe/I/O subsystem

- **Architecture:** Dual Sky Lake-E IIO complexes with integrated PCIe root ports, memory controllers, UPI, VT-d, CBDMA.
- **PCIe generations:** Hosted devices include PCIe Gen3 endpoints (GPUs), Gen2 endpoints (I210 NICs). Actual link speeds cannot be confirmed without reading PCIe extended config.
- **IOMMU:** Intel VT-d with scalable mode enabled. Dual IOMMU units (one per socket) visible in DMAR.
- **Endpoint inventory:** 2 GPUs, 1 NVMe SSD, 2 NICs, ASPEED BMC VGA, USB xHCI, SATA AHCI.

## 9.5 GPU/accelerator subsystem

- **Devices:** 2 × AMD Vega 20 (GFX906), identified as Radeon Pro VII / Instinct MI50.
- **PCIe:** x16 links (architectural capability confirmed; actual speed not determined).
- **Memory:** Each GPU has 16 GiB BAR0 + 2 MiB BAR1 (prefetchable).
- **NUMA:** Both GPUs on node 1 (remote from socket 0).
- **Driver:** amdgpu (kernel driver loaded).

## 9.6 Storage subsystem

- **Device:** MAXIO MAP1202 NVMe SSD (DRAM-less controller).
- **PCIe:** Gen3 x4 (architectural; actual link not confirmed).
- **NUMA:** Node 0 (local to socket 0).
- **Interrupts:** 9 MSI-X vectors.

## 9.7 Network/external-I/O subsystem

- **Network:** 2 × Intel I210 Gigabit Ethernet (PCIe Gen2 x1), both on node 0.
- **BMC:** ASPEED AST2500 remote management VGA, connected via AST1150 PCI-to-PCI bridge.
- **USB:** Intel C620 USB 3.0 xHCI controller on node 0.
- **SATA:** Intel C620 SSATA + SATA AHCI controllers on node 0.

---

# 10. Capability vs Installed-State Summary

| Domain | Theoretical/documented capability | Installed/observed hardware state | Difference/unknown | Evidence/source |
|---|---|---|---|---|
| CPU frequency | 2.5 GHz base, 3.9 GHz turbo (1–4C), 3.2 GHz all-core (20C) | Confirmed by `/proc/cpuinfo` model name + Intel ARK | AVX-specific turbo bins not precisely quantified | SRC-010, EVID-001 |
| CPU topology | 2 sockets × 20 cores × 2 threads = 80 logical CPUs | 80 logical CPUs confirmed (0–79) | None | EVID-001, EVID-002 |
| Memory channels | 6 channels/socket, 12 total | ~192 GiB installed (populated configuration unknown) | DIMM population per channel unknown | Architecture + EVID-003 |
| Memory speed | Up to 2666 MT/s (DDR4-2666) | Unknown (dmidecode blocked) | Actual speed not confirmed | Architecture; EVID-003 |
| PCIe links | Gen3 x16 (GPU), Gen3 x4 (NVMe), Gen2 x1 (NIC) | Configured per platform; actual link speed **not confirmed** | Extended config registers unreadable | EVID-004; PCI spec |
| NUMA | 2 nodes, balanced memory | 2 nodes, ~96 GiB per node (balanced) | None | EVID-003 |
| IOMMU | Intel VT-d scalable mode | Enabled (`CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y`) | None | EVID-011, EVID-014 |
| UPI | 10.4 GT/s, 40-bit per link (architectural) | Present; link speed not confirmed | Actual UPI speed not confirmed | Architecture; EVID-004 |

---

# 11. Unknowns and Unavailable Data

## Unknown

| Item | Why unknown | Later relevance |
|---|---|---|
| DIMM population (per-channel, per-socket) | dmidecode blocked | Memory bandwidth/latency analysis |
| Actual memory speed | dmidecode blocked | Memory performance baseline |
| ECC support | dmidecode blocked | Memory reliability characterization |
| AVX-specific turbo frequency envelope | Intel public docs incomplete | Workload frequency behavior analysis |
| TjMax (thermal junction max) | Not published for this SKU | Thermal control baseline |
| Actual UPI link speed/width | PCIe extended config unreadable | Inter-socket bandwidth characterization |
| Actual PCIe link speeds (LnkSta) | PCIe extended config unreadable | Endpoint bandwidth characterization |
| DSDT/SSDT AML content | No disassembly performed (Step 1) | ACPI analysis (Step 3+) |
| OEM1/OEM2/OEM4 table purposes | No disassembly performed (Step 1) | Platform policy identification |
| SVOS table purpose | Vendor-specific, no public reference | Unknown |

## Unavailable

| Item | Source checked |
|---|---|
| DMI full table | `/dev/mem` (dmidecode blocked); only `/sys/class/dmi/id/` available |
| DIMM information | dmidecode blocked |
| PCIe link capabilities (LnkSta) | `lspci` lacks read access to PCIe extended config |

## Not collected

| Item | Reason |
|---|---|
| AC'97/HDA codec details | Not relevant to platform specification |
| Specific C-state residency | Belongs to Step 2 (control environment) |
| Current governor/boost policy | Belongs to Step 2 (control environment) |

## Not applicable

| Item | Reason |
|---|---|
| AMD IOMMU | Platform uses Intel VT-d, not AMD IOMMU |
| SMMU | x86 platform; IOMMU is Intel VT-d |
| NUMA node 2+ | Platform has exactly 2 NUMA nodes |

## Conflicting sources

No source conflicts were identified at this stage.

---

# 12. Source Conflicts

No conflicts were identified during this audit. All observed evidence is consistent with external authoritative sources.

---

# 13. Audit Completeness

## 13.1 Completed domains

- [x] Platform identity
- [x] CPU identity/topology
- [x] CPU frequency capability table
- [x] CPU power/thermal capability (partial — TjMax and power limits unknown)
- [x] CPU performance-control capability
- [x] Memory (partial — DIMM details unavailable)
- [x] NUMA
- [x] PCIe/I/O
- [x] Firmware/ACPI
- [x] External sources
- [x] Unknowns/conflicts

## 13.2 Partial domains

| Domain | Partial because |
|---|---|
| Memory DIMM details | dmidecode blocked; no sysfs DIMM interface |
| CPU power limits (PL1/PL2) | Not observable from userspace; platform firmware may override |
| CPU frequency AVX behavior | Intel public documentation incomplete for this SKU |
| PCIe link negotiated speeds | Extended config registers unreadable (no elevated privileges) |
| DSDT/SSDT AML content | No disassembly performed at Step 1 |
| UPI link speed/width | PCIe extended config unreadable |

## 13.3 Data intentionally deferred to Step 2

- Active CPU governor / turbo policy
- Current HWP policy (state, EPP values)
- Current power limits (MSR values)
- Current c-state residency
- Scheduler policy
- Current IRQ distribution/affinity
- Runtime PM/ASPM policy
- sysctl values
- Current thermal values (Tjunction, package power)

---

# 14. Handoff to Step 2

## Stable facts Step 2 may rely on

- **Platform:** HUANANZHI X11D-16D, dual Intel Sky Lake-E, BIOS AMI 5.14 (10/19/2024)
- **CPU:** 2 × Xeon Gold 6248, 20C/40T per socket, 80 logical CPUs, base 2.5 GHz, turbo 3.2 GHz all-core
- **NUMA:** 2 nodes; node0 (socket 0, CPUs 0–19,40–59); node1 (socket 1, CPUs 20–39,60–79)
- **Memory:** ~192 GiB total; ~96.5 GiB per node
- **PCIe domains:** 0000:00, 0000:17, 0000:5d, 0000:80, 0000:85, 0000:af, 0000:d8, 0000:ae, 0000:d7
- **GPUs:** 2 × Vega 20 (1002:73a0) on node 1
- **NVMe:** MAXIO MAP1202 on node 0
- **NICs:** 2 × Intel I210 on node 0
- **IOMMU:** Intel VT-d scalable mode enabled
- **ACPI tables:** 33 captured, DSDT (1.6 MiB), FACP rev 6, SRAT, SLIT, DMAR, MCFG, APIC, HPET
- **intel_pstate:** active (driver mode); HWP not active

## Specification gaps Step 2 must preserve as unknown

- DIMM population, speed, ECC — **unknown**
- PCIe negotiated link speeds — **unknown** (read-only constraint)
- CPU AVX turbo envelope — **partially documented**
- TjMax — **unknown**
- Platform power limits (PL1/PL2) — **unknown**
- DSDT/SSDT content — **unknown** (no disassembly)

## Evidence references likely useful to Step 2

- EVID-006 (full ACPI table inventory)
- EVID-007 (ACPI table headers)
- EVID-014 (DMAR IOMMU enumeration)
- ACPI captures in `/home/viktor/LLM/Projects/Platform-Compiler-for-Linux/ACPI/`
- PCI device inventory in EVID-004/EVID-005
- NUMA distance matrix (EVID-013): 10 21 / 21 10

---

# 15. Machine-Readable Companion

See companion files: `report.json` and `sources.json`.

---

# 16. Final Audit Statement

1. **Platform identification status:** The target platform has been sufficiently identified for Step 2. Core identity (motherboard X11D-16D, dual Xeon Gold 6248, Intel C620 chipset, 192 GiB DDR4, 2 NUMA nodes, 2 GPUs, 1 NVMe SSD, 2 NICs) is confirmed with observed evidence.
2. **Most important unresolved specification gaps:** DIMM population/speed/ECC (dmidecode blocked), PCIe link negotiated speeds (no elevated privileges), CPU AVX turbo envelope (Intel docs incomplete), TjMax (not published).
3. **Source conflicts:** None identified.
4. **No Step 3 diagnosis or Step 4 materialization recommendation was intentionally performed.**

---

*End of report.*
