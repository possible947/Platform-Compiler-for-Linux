# Platform Specification Report (Step 1)

## Executive Summary
This document provides a technical platform passport for the current physical machine, derived from direct hardware observation, deterministic derivation, captured firmware data, and authoritative technical sources. The report is presented in accordance with the Step 1 output contract and marks the completion of the Platform Specification stage under the Platform Preparation Protocol.

## 1. Platform Identity
- **Architecture**: x86_64
- **Board / System Identifier**: X11D-16D
- **UEFI Firmware**: Present (UEFI runtime visible under /sys/firmware/efi)
- **Firmware Version**: 5.14 (as reported by DMI)
- **ACPI Revision**: RSDP revision 2, with a full inventory of ACPI tables (DSDT, SSDT1‑SSDT4, FACP, HPET, MCFG, APIC, SLIT, SRAT, DMAR, FADT, and others)

## 2. CPU Subsystem
- **Model**: Intel(R) Xeon(R) Gold 6248 CPU @ 2.50GHz
- **Stepping**: 7
- **Microarchitecture**: Skylake (Xeon Gold 6248)
- **Socket Count**: 2
- **Physical Cores per Socket**: 20
- **Logical CPUs**: 80 (Hyper‑Threading enabled)
- **NUMA Mapping**:
  - Node 0: CPUs 0‑19, 40‑59
  - Node 1: CPUs 20‑39, 60‑79
- **Frequency Capability**:
  - Base frequency: *unknown* (no authoritative source)
  - Turbo envelope: *unknown* (no authoritative source)
  - All‑core capability: *unknown*
- **Performance Interfaces**:
  - HWP: supported
  - CPPC: unknown
  - EIST/P‑state: present
  - AVX / AVX2 / AVX‑512: supported (flags indicate capability)
- **Cache Hierarchy**:
  - L1 Data Cache: 1.3 MiB, 40 instances
  - L1 Instruction Cache: 1.3 MiB, 40 instances
  - L2 Cache: 40 MiB, 40 instances
  - L3 Cache: 55 MiB, 2 instances
- **Socket Interconnect**: Ultra‑Path Interconnect (UPI)

## 3. Memory Subsystem
- **Total Installed Memory**: 196 623 476 kB (≈196 GB)
- **Per‑NUMA‑Node Memory**:
  - Node 0: 97 615 056 kB
  - Node 1: 99 008 420 kB
- **Memory Speed**: *unknown* (no authoritative source)
- **Theoretical Bandwidth**: *unknown*

## 4. NUMA Topology
- **Node Count**: 2
- **CPU Membership**:
  - Node 0: CPUs 0‑19, 40‑59
  - Node 1: CPUs 20‑39, 60‑79
- **Memory Membership**:
  - Node 0 hosts ≈50 % of total memory
  - Node 1 hosts ≈50 % of total memory
- **Memory Capacity per Node**:
  - Node 0: 97 615 056 kB
  - Node 1: 99 008 420 kB
- **Distance Matrix**: Observed via `/sys/devices/system/node/node0/distance`; values indicate node‑to‑node distance (e.g., distance 1 for remote node).

## 5. PCIe and I/O Topology
- **Root Complexes**: Present at bus 00:00.0 (host bridge)
- **Major Endpoints**:
  - **GPU 0**: 04:00.0 – ASPEED Graphics Family [1a03:2000]
  - **GPU 1**: b1:00.0 – AMD Radeon Pro VII / Instinct MI50 [1002:66a1]
  - **GPU 2**: da:00.0 – AMD Radeon Pro VII / Instinct MI50 [1002:66a1]
  - **NVMe Controller**: 5e:00.0 – MAXIO NVMe SSD Controller [1e4b:1202]
  - **Network 0**: 01:00.0 – Intel I210 Gigabit NIC [8086:1533]
  - **Network 1**: 02:00.0 – Intel I210 Gigabit NIC [8086:1533]
  - **USB 3.0 Controller**: 00:14.0 – Intel C620 Series xHCI [8086:a1af]
- **Negotiated Link Width/Speed**: Partially observed; several endpoints show x8 negotiation at Gen3 (8 GT/s) but full enumeration pending.
- **IOMMU Capability**: Unknown (no IOMMU group information available).

## 6. Firmware and ACPI Inventory
- **ACPI Tables Captured** (disassembled DSL files):
  - DSDT (revision 2)
  - SSDT1, SSDT2, SSDT3, SSDT4
  - FACP, HPET, MCFG, APIC, SLIT, SRAT, DMAR, FADT, and others
- **Semantic Inventory**: The ACPI namespace includes the above tables; no unexpected semantic discrepancies observed at this stage.
- **External Reference Platform**: Primary reference selected is the *MacPro7,1* platform dump, chosen based on project‑specific similarity and prior successful DSDT adaptation.

## 7. Known Contradictions
- **None identified** at this stage. All observed relationships are internally consistent.

## 8. Unknowns / Unavailable Evidence
| Field | Status | Reason |
|-------|--------|--------|
| Exact CPU base frequency | Unknown | No authoritative source established |
| Detailed memory controller topology | Unknown | Not directly observable via sysfs |
| Precise negotiated PCIe link width/speed for all devices | Partially observed | Some endpoints only |
| Full IOMMU group mapping | Unknown | Kernel interface not available |
| Exact TDP / power envelope values | Unknown | Not directly exposed |
| Full ACPI AML semantics for unresolved methods | Unknown | Requires deeper analysis |
| Complete DMI identifiers (vendor, serial numbers) | Partially unavailable | Access restrictions |

## 9. Limitations Encountered
1. **Raw ACPI Table Access**: Binary ACPI tables under `/sys/firmware/acpi/tables/` are readable only by root; we relied on disassembled DSL outputs for evidence.
2. **DMI Information**: Some DMI fields (e.g., full vendor string, serial numbers) could not be read without elevated privileges.
3. **PCIe Link Parameters**: Full link width and speed negotiation for all devices could not be verified automatically.
4. **Power / Thermal Data**: Package power limits, thermal design power (TDP), and current temperature readings were not directly observable.
5. **CPU Frequency Scaling**: While scaling driver and governor are present, the exact turbo envelope and frequency scaling behavior could not be fully characterized without additional runtime telemetry.

## 10. Evidence References
All evidence used in this report is listed in `sources.json` with cryptographic hashes and locators, ensuring traceability and reproducibility.

