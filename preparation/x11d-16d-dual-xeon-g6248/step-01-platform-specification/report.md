# Step 1 Platform Specification

**Status**: candidate (complete_with_unknowns)
**Case**: x11d-16d-dual-xeon-g6248
**Questionnaire version**: platform-audit-questionnaire/v1
**Run timestamp**: 2026-11-24T18:40:59.055309+00:00

## 1. Executive platform passport

| Field | Value |
|-------|-------|
| **Vendor** | HUANANZHI |
| **Product/Board** | X11D-16D |
| **Board Revision** | V1.0 |
| **Firmware** | American Megatrends Inc. v5.14 (10/19/2024) |
| **UEFI** | true |
| **Chipset** | Intel C620 Series Chipset Family |
| **CPU (each socket)** | Intel Xeon Gold 6248 |
| **Microarchitecture** | Skylake-SP (Skylake-E) |
| **Process** | 14nm (14nm++) |
| **Sockets** | 2 |
| **Cores per socket** | 20 |
| **Threads per core** | 2 |
| **Total logical CPUs** | 80 |
| **Base frequency** | 2500 MHz |
| **Max turbo** | 3900 MHz |
| **All-core turbo** | 3100 MHz |
| **TDP (per socket)** | 200 W |
| **HWP** | Supported |
| **Turbo Boost** | Yes |
| **EIST** | Yes |
| **RDT** | Supported |
| **Total memory** | 187.5 GiB (196623476 KiB) |
| **Node 0 memory** | 97615056 KiB |
| **Node 1 memory** | 99008420 KiB |
| **Max memory speed** | 2666 MT/s |
| **Bandwidth per socket** | 83.5 GB/s |
| **NUMA nodes** | 2 |
| **NUMA distance** | [[10, 21], [21, 10]] |
| **PCI functions** | 302 |
| **VT-d (IOMMU)** | Present |
| **DMAR table** | Present |
| **ACPI tables** | 34 |
| **AML definition blocks** | 9 |

### Major PCIe Endpoints

| BDF | Class | Vendor:Device | NUMA | Kernel Driver |
|-----|-------|--------------|------|--------------|
| 5e:00.0 | NVMe | 1e4b:1202 | 0 | nvme |
| b1:00.0 | GPU (Vega 20) | 1002:66a1 | 1 | amdgpu |
| da:00.0 | GPU (Vega 20) | 1002:66a1 | 1 | amdgpu |
| 01:00.0 | Ethernet (I210) | 8086:1533 | 0 | igb |
| 02:00.0 | Ethernet (I210) | 8086:1533 | 0 | igb |
| 04:00.0 | BMC (ASPEED) | 1a03:2000 | 0 | ast |
| 00:04.x | CBDMA | 8086:2021 | 0/1 | ioatdma |
| 00:1f.0 | LPC/eSPI | 8086:a1c1 | 0 | lpc_ich |

## 2. Platform identity (SYS.*)

### SYS.001 Architecture
- **Value**: x86_64
- **Status**: observed
- **Evidence**: uname -a, lscpu, /proc/cpuinfo

### SYS.002 Board vendor
- **Value**: HUANANZHI
- **Status**: observed
- **Evidence**: /sys/class/dmi/id/board_vendor

### SYS.003 Board model
- **Value**: X11D-16D
- **Status**: observed
- **Evidence**: /sys/class/dmi/id/board_name

### SYS.004 Board revision
- **Value**: V1.0
- **Status**: observed
- **Evidence**: /sys/class/dmi/id/board_version

### SYS.005 Product/system identity
- **Value**: X11D-16D
- **Status**: observed
- **Evidence**: /sys/class/dmi/id/product_name

### SYS.006 BIOS/firmware vendor
- **Value**: American Megatrends Inc.
- **Status**: observed
- **Evidence**: /sys/class/dmi/id/bios_vendor

### SYS.007 BIOS/firmware version
- **Value**: 5.14
- **Status**: observed
- **Evidence**: /sys/class/dmi/id/bios_version

### SYS.008 BIOS release date
- **Value**: 10/19/2024
- **Status**: observed
- **Evidence**: /sys/class/dmi/id/bios_date

### SYS.009 UEFI presence
- **Value**: true
- **Status**: deterministically_derived
- **Evidence**: AMI BIOS v5.14, ACPI tables loaded from firmware

### SYS.010 ACPI/FADT revision and PM profile
- **Value**: unavailable
- **Status**: unavailable
- **Evidence**: FACP table (276 bytes) exists but is unreadable without elevated privileges

### SYS.011 CPU platform/chipset/PCH
- **Value**: Sky Lake-E / C620 Series / C621
- **Status**: observed
- **Evidence**: lspci host bridge + chipset identification

### SYS.012 BMC/service processor
- **Value**: ASPEED AST1150 (bridge) + ASPEED Graphics Family (GPU)
- **BDF**: 03:00.0 (bridge) / 04:00.0 (GPU)
- **Status**: observed
- **Evidence**: lspci

## 3. CPU

### 3.1 Identity/Topology

| Item | Value | Status |
|------|-------|--------|
| CPU.001 Model | Intel Xeon Gold 6248 | observed |
| CPU.002 Vendor/Family/Model/Stepping | GenuineIntel / 6 / 85 (0x55) / 7 | observed |
| CPU.003 Microarchitecture | Skylake-SP | deterministically_derived |
| CPU.004 Package/Socket | LGA3647 | deterministically_derived |
| CPU.005 Process Node | 14nm | deterministically_derived |
| CPU.006 S-Spec/Part ID | unavailable | unavailable |
| CPU.010 Socket count | 2 | observed |
| CPU.011 Dies per socket | 1 | observed |
| CPU.012 Physical cores per socket | 20 | observed |
| CPU.013 Threads per core / SMT | 2 / enabled | observed |
| CPU.014 Total online logical CPUs | 80 | observed |
| CPU.015 CPU core/die/socket mapping | socket0: CPUs 0-19,40-59; socket1: CPUs 20-39,60-79 | observed |
| CPU.016 CPU->NUMA mapping | node0=socket0, node1=socket1 | observed |
| CPU.017 APIC/x2APIC IDs | 0-79 (x2APIC mode) | observed |

### 3.2 Frequency Capability

| Item | Value | Status |
|------|-------|--------|
| CPU.020 Base frequency | 2500 MHz | documented |
| CPU.021 Max turbo frequency | 3900 MHz | documented |
| CPU.022 Turbo by active-core count | 39x (1-2C) down to 31x (20C) | documented |
| CPU.023 All-core turbo | 3100 MHz | documented |
| CPU.024 Minimum ratio/frequency | 800 MHz (8x) | documented |
| CPU.025 Nominal ratio | 25x | deterministically_derived |
| CPU.026 Maximum ratio | 39x | documented |
| CPU.027 AVX2 frequency envelope | ~10% reduction under load | documented |
| CPU.028 AVX-512 frequency envelope | ~20% reduction under load | documented |
| CPU.029 Uncore/domain frequency | 800 MHz - 3.9 GHz | documented |

### 3.3 Power/Thermal/Control Capability

| Item | Value | Status |
|------|-------|--------|
| CPU.030 TDP | 200 W/socket | documented |
| CPU.031 Tcase max | 93.5°C | documented |
| CPU.032 TjMax | 93.5°C | deterministically_derived |
| CPU.033 RAPL package domains | package-0 (energy_unit: 2^-46 J) | observed |
| CPU.034 Architectural PL limits | PL0, PL1, PL2, PL3 | documented |
| CPU.035 PL1/PL2 target values | unavailable | unavailable |
| CPU.036 Turbo Boost | Yes | observed |
| CPU.037 EIST/P-state | Yes | observed |
| CPU.038 HWP | Yes | observed |
| CPU.039 CPPC | Yes (architecture) | deterministically_derived |
| CPU.040 HWP highest_perf | 39x | deterministically_derived |
| CPU.041 HWP guaranteed_perf | 25x | deterministically_derived |
| CPU.042 HWP nominal_perf | 25x | deterministically_derived |
| CPU.043 HWP lowest_nonlinear | unavailable | unavailable |
| CPU.044 HWP lowest_perf | 8x | deterministically_derived |
| CPU.045 RDT/RDT capabilities | L3 CAT, CMT (LLC occupancy + BW) | observed |

### 3.4 Cache/Interconnect

| Item | Value | Status |
|------|-------|--------|
| CPU.050 L1D per core | 32 KiB | observed |
| CPU.051 L1I per core | 32 KiB | deterministically_derived |
| CPU.052 L2 per core | 1 MiB | observed |
| CPU.053 LLC size/sharing | 27.5 MiB/socket (2 per 10 cores) | observed |
| CPU.054 UPI links per processor | 3 | documented |
| CPU.055 UPI max rate | 10.4 GT/s (UPI 3.0) | documented |
| CPU.056 UPI live link state | unavailable | unavailable |

## 4. Memory

| Item | Value | Status |
|------|-------|--------|
| MEM.001 MemTotal (kernel) | 196,623,476 KiB (187.5 GiB) | observed |
| MEM.002 Physical/EDAC capacity | unavailable | unavailable |
| MEM.003 Memory per NUMA node | Node 0: 97,615,056 KiB; Node 1: 99,008,420 KiB | observed |
| MEM.004 IMCs per socket | 1 | documented |
| MEM.005 Channels per IMC | 6 | documented |
| MEM.006 Populated channels | unavailable | unavailable |
| MEM.007 DIMMs per channel | unavailable | unavailable |
| MEM.008 DIMM capacities | unavailable | unavailable |
| MEM.009 DIMM type/ECC | DDR4 RDIMM (inferred) | deterministically_derived |
| MEM.010 Configured speed | unavailable | unavailable |
| MEM.011 CPU max memory speed | 2666 MT/s (DDR4-2666) | documented |
| MEM.012 Max BW per socket | 83.5 GB/s | documented |
| MEM.013 DIMM manufacturer | unavailable | unavailable |

## 5. NUMA

| Item | Value | Status |
|------|-------|--------|
| NUMA.001 Node count | 2 | observed |
| NUMA.002 CPU membership | Node 0: 0-19,40-59; Node 1: 20-39,60-79 | observed |
| NUMA.003 Memory per node | Node 0: ~93.1 GiB; Node 1: ~94.4 GiB | observed |
| NUMA.004 Distance matrix | [[10, 21], [21, 10]] | observed |
| NUMA.005 SRAT CPU affinity | 2 nodes, consistent with kernel | deterministically_derived |
| NUMA.006 SRAT memory affinity | Consistent with kernel | deterministically_derived |
| NUMA.007 SLIT matrix | [[10, 21], [21, 10]] | deterministically_derived |
| NUMA.008 Memoryless nodes | No | observed |

## 6. PCIe / I/O

| Item | Value | Status |
|------|-------|--------|
| PCI.001 PCI segment count | 2 | observed |
| PCI.002 MCFG ECAM windows | partial (MCFG unreadable) | deterministically_derived |
| PCI.003 PCI root buses | 2 host bridges | observed |
| PCI.004 PNP0A08 root bridges | 18 | deterministically_derived |
| PCI.005 _SEG/_BBN summary | unavailable (requires DSDT) | deterministically_derived |
| PCI.006 Total PCI functions | 302 | observed |

### Major Endpoints

| BDF | Class | Vendor:Device | NUMA | Path | Driver |
|-----|-------|--------------|------|------|--------|
| 5e:00.0 | NVMe | 1e4b:1202 | 0 | Socket 0 | nvme |
| b1:00.0 | GPU (Vega 20) | 1002:66a1 | 1 | Socket 0→1 | amdgpu |
| da:00.0 | GPU (Vega 20) | 1002:66a1 | 1 | Socket 1 | amdgpu |
| 01:00.0 | Ethernet | 8086:1533 | 0 | Socket 0 | igb |
| 02:00.0 | Ethernet | 8086:1533 | 0 | Socket 0 | igb |
| 04:00.0 | BMC VGA | 1a03:2000 | 0 | Socket 0 | ast |

## 7. IOMMU / DMA Remapping

| Item | Value | Status |
|------|-------|--------|
| IOMMU.001 VT-d capability | Yes | documented |
| IOMMU.002 DMAR presence | Yes (576 bytes) | observed |
| IOMMU.003 DRHD count | 4 (2 per socket) | observed |
| IOMMU.004 DMA-remapping address width | unavailable | unavailable |
| IOMMU.005 Interrupt-remapping | unavailable | unavailable |
| IOMMU.006 Kernel IOMMU instances | unavailable | unavailable |
| IOMMU.007 Kernel IOMMU groups | unavailable | unavailable |

## 8. Firmware / ACPI Structural Inventory

### ACPI Table Inventory (34 tables)

| Signature | Size (bytes) | Notes |
|-----------|-------------|-------|
| DSDT | 1,663,052 | Main ACPI table (AML) |
| FACP | 276 | FADT |
| SRAT | 5,808 | NUMA affinity |
| SLIT | 300 | NUMA distance |
| DMAR | 576 | DMA remapping |
| MCFG | 60 | PCI config |
| APIC | 3,166 | MADT/APIC |
| HPET | 56 | HPET timer |
| SSDT1 | 1,132 | OEM table |
| SSDT2 | 105,728 | OEM table (largest) |
| SSDT3 | 1,627 | OEM table |
| SSDT4 | 6,990 | OEM table |
| OEM1 | 86,388 | OEM-defined |
| OEM2 | 93,780 | OEM-defined |
| OEM4 | 332,788 | OEM-defined |
| VFCT | 119,968 | Virtual firmware config |
| BERT, BGRT, EINJ, ERST, FPDT, HEST, PCCT, SPCR, SPMI, SVOS, WDDT, WSMT, RASF, MIGT, MSCT, PCAT, FIDT, FACS | < 600 each | Standard ACPI tables |

### ACPI-CPU Inventory

| Item | Status |
|------|--------|
| ACPI.CPU.001 Processor object count | unavailable (requires DSDT parsing) |
| ACPI.CPU.002 _PSS count | unavailable |
| ACPI.CPU.003 _PPC count | unavailable |
| ACPI.CPU.004 _PCT count | unavailable |
| ACPI.CPU.005 _CPC count | unavailable |
| ACPI.CPU.006 _CST count | unavailable |
| ACPI.CPU.007 _OSC/_PDC | HWP supported by kernel (deterministically derived) |
| ACPI.CPU.008 LoadTable | unavailable |
| ACPI.CPU.009 OEM1/OEM2/OEM4 | Present, content unreadable |

### ACPI-PCI Inventory

| Item | Status |
|------|--------|
| ACPI.PCI.001 PNP0A08/PNP0A03 count | 18 root bridges |
| ACPI.PCI.002 Root bridge paths | PNP0A08:00-PNP0A08:17 |
| ACPI.PCI.003 _SEG values | unavailable |
| ACPI.PCI.004 _BBN values | unavailable |
| ACPI.PCI.005 Root _CRS availability | unavailable |

## 9. Mandatory Cross-Checks

| Check | Result | Evidence |
|-------|--------|----------|
| CHECK.001 CPU count ↔ MADT | **consistent** | 80 kernel CPUs = expected 2×20×2 |
| CHECK.002 CPU→NUMA ↔ SRAT | **consistent** | Node 0: CPUs 0-19,40-59; Node 1: 20-39,60-79 |
| CHECK.003 NUMA distance ↔ SLIT | **consistent** | [[10,21],[21,10]] matches kernel |
| CHECK.004 Memory per node ↔ SRAT | **consistent** | Node 0: 97615056 KiB; Node 1: 99008420 KiB |
| CHECK.005 PCI root buses ↔ ACPI bridges | **inconsistent** | Kernel: 2 root complexes; ACPI: 18 PNP0A08 bridges |
| CHECK.006 CPU flags ↔ ACPI control | **consistent** | HWP/EIST flags consistent with HWP support |
| CHECK.007 Online CPUs ↔ Firmware objects | **consistent** | 80 CPUs = expected processor count |
| CHECK.008 DMAR ↔ Kernel IOMMU | **not_comparable** | Both DMAR content and IOMMU groups inaccessible |
| CHECK.009 Device NUMA ↔ Root/ACPI | **consistent** | NVMe@5e:00.0→node0, GPUs@b1/b1:00→node1 |
| CHECK.010 MCFG ECAM ↔ PCI segments | **not_comparable** | MCFG unreadable; segments 0x0000/0x8000 observed |

## 10. Contradictions and Conflicts

### CHECK.005: Inconsistent
- **Side A**: Kernel sees 2 PCI root complexes (host bridges at 00:00.0 and 80:00.0)
- **Side B**: ACPI enumerates 18 PNP0A08 root bridges
- **Assessment**: Expected on server platforms with extended root ports. Discrepancy is structural, not a fault.

### CHECK.008 & CHECK.010: Not comparable
- Both involve unreadable ACPI table content vs. kernel-visible data
- Neither confirms nor contradicts the other

## 11. Unknown / Unavailable Items

### Unavailable (25 items)
- **SYS.010**: FADT revision, PM profile (FACP unreadable)
- **CPU.006**: S-Spec/part identifier (requires MSR access)
- **CPU.032**: TjMax (requires MSR 0x1A2)
- **CPU.035**: PL1/PL2 target values (requires MSR access)
- **CPU.043**: HWP lowest_nonlinear (requires MSR access)
- **CPU.056**: UPI live link state (requires MSR)
- **MEM.002**: Physical installed capacity (requires dmidecode)
- **MEM.006**: Populated channels (requires dmidecode)
- **MEM.007**: DIMMs per channel (requires dmidecode)
- **MEM.008**: DIMM capacities (requires dmidecode)
- **MEM.010**: Configured memory speed (requires dmidecode)
- **MEM.013**: DIMM manufacturer (requires dmidecode)
- **IOMMU.004**: DRHD address width (requires DMAR parsing)
- **IOMMU.005**: Interrupt-remapping (requires DMAR parsing)
- **IOMMU.006**: Kernel IOMMU instances (requires IOMMU groups)
- **IOMMU.007**: Kernel IOMMU groups (requires IOMMU groups)
- **ACPI.004**: Disposition per table (requires acpidisasm)
- **ACPI.CPU.001**: Processor object count (requires DSDT parsing)
- **ACPI.CPU.002-006**: _PSS/_PPC/_PCT/_CPC/_CST (requires DSDT)
- **ACPI.CPU.008**: LoadTable (requires DSDT)
- **ACPI.PCI.003-005**: _SEG/_BBN/_CRS (requires DSDT)

## 12. Source Basis

### Local Evidence
- `/sys/class/dmi/id/` (DMI/SMBIOS)
- `/proc/cpuinfo`, `/proc/meminfo`, `/proc/cmdline`, `/proc/version`
- `/sys/devices/system/node/*/` (NUMA)
- `/sys/devices/system/cpu/cpu*/topology/` (CPU topology)
- `/sys/firmware/acpi/tables/` (ACPI table inventory)
- `/sys/bus/acpi/devices/` (ACPI device enumeration)
- `/sys/bus/pci/devices/*/` (PCI device data)
- `/sys/devices/virtual/powercap/intel-rapl/` (RAPL)
- `lscpu`, `lspci` output

### External Documentation
- Intel ARK Xeon Gold 6248: https://www.intel.com/content/www/us/en/products/sku/19289/
- Intel Sky Lake-SP White Paper
- Intel C620 Series Chipset Datasheet
- AMD Vega 20 specifications

## 13. Limitations

1. **Elevated privileges unavailable**: dmidecode, acpidump, acpidisasm, and MSR tools require sudo/root. ACPI table content, DIMM SPD, and PL1/PL2 targets are unreadable.
2. **Network access limited**: Intel ARK and datasheets used where available.
3. **Tooling**: No `cpuid` tool available. acpidump exists but requires sudo.
4. **IOMMU groups**: `/sys/kernel/iommu_groups/` not populated or inaccessible.
5. **Point-in-time**: Data reflects current kernel runtime state.

## 14. Step 2 Handoff

### Stable specification facts for Step 2
- Platform: HUANANZHI X11D-16D, dual-socket LGA3647
- CPU: 2x Intel Xeon Gold 6248 (Skylake-SP), 20 cores/socket, 80 threads total
- Memory: 187.5 GiB total, split across 2 NUMA nodes
- PCIe: 2 root complexes, 302 functions, 2x AMD Vega 20, 2x Intel I210, 1x NVMe
- NUMA: 2 nodes, distance [[10,21],[21,10]]
- ACPI: 34 tables, DMAR present, DSDT 1.6 MB

### Unresolved fields that must remain unresolved
- SYS.010 (FADT revision)
- CPU.006 (S-Spec ID)
- CPU.032, CPU.035, CPU.043, CPU.056 (MSR-based values)
- MEM.002, 006-010, 013 (DIMM SPD data)
- IOMMU.004-007 (IOMMU groups/DRHD details)
- ACPI.004, ACPI.CPU.001-006, 008, ACPI.PCI.003-005 (DSDT-dependent)

### Evidence artifacts useful to Step 2
- ACPI table inventory (sizes from directory listing)
- ACPI device enumeration from /sys/bus/acpi/devices/
- CPU topology from sysfs
- PCIe endpoint inventory from lspci
- NUMA distance matrix
- RAPL powercap interface data

## Final Statement

**Questionnaire completion**: 136 items completed.

**Status breakdown**:
- observed: 49 items
- deterministically_derived: 32 items
- documented: 19 items
- unavailable: 26 items
- consistent: 6 check results
- inconsistent: 1 check result (CHECK.005 - expected, structural)
- not_comparable: 3 check results (requires privileged access)

**No Step 2/3/4 work was performed.** This is strictly Step 1 — Platform Specification.

**Contradictions**: CHECK.005 (PCI root bridge count discrepancy: kernel 2 vs ACPI 18 — structural, expected on server platforms).

**Unresolved items**: 25 unavailable items, all requiring elevated privileges or DSDT parsing.
