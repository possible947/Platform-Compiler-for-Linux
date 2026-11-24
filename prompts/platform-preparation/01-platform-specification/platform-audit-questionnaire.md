# Platform Audit Questionnaire v1

## Contract
This is the mandatory coverage specification for Step 1. Each item must be represented in `questionnaire.json`. Fields marked **documented** require external research where network access is available. Fields marked **target** require target observation or an explicit unavailable/unknown disposition.

For every item record: `id`, `value`, `unit`, `status`, `scope`, `evidence_refs`, `source_refs`, `acquisition_attempts`, `notes`.

## SYS — Platform identity
- `SYS.001` Architecture — target
- `SYS.002` Board vendor — target
- `SYS.003` Board model — target
- `SYS.004` Board revision — target
- `SYS.005` Product/system identity — target
- `SYS.006` BIOS/firmware vendor — target
- `SYS.007` BIOS/firmware version — target
- `SYS.008` BIOS release date — target
- `SYS.009` UEFI presence/runtime visibility — target
- `SYS.010` ACPI/FADT revision and preferred PM profile — target
- `SYS.011` CPU platform/chipset/PCH family — target + documented
- `SYS.012` BMC/service processor identity — target

## CPU — Processor identity and topology
- `CPU.001` Exact CPU marketing/SKU identity — target
- `CPU.002` Vendor/family/model/stepping — target
- `CPU.003` Microarchitecture/generation — documented
- `CPU.004` Package/socket — documented
- `CPU.005` Process node — documented
- `CPU.006` S-Spec/part identifier, if observable — target/documented
- `CPU.010` Socket count — target
- `CPU.011` Dies per socket — target
- `CPU.012` Physical cores per socket — target
- `CPU.013` Threads per core and SMT state — target
- `CPU.014` Total online logical CPUs — target
- `CPU.015` CPU→core→die→socket mapping — target
- `CPU.016` CPU→NUMA mapping — target
- `CPU.017` APIC/x2APIC IDs for online CPUs — target

## CPU-FREQ — Frequency capability
Acquisition priority: local architectural/read-only interface → manufacturer specification/ARK/datasheet → trusted secondary source. Do not invent turbo bins.
- `CPU.020` Base frequency — documented + target identity cross-check
- `CPU.021` Maximum turbo frequency — documented
- `CPU.022` Turbo ratio/frequency by active-core count — documented/architectural
- `CPU.023` Documented all-core turbo — documented
- `CPU.024` Minimum ratio/frequency capability — target/architectural
- `CPU.025` Nominal ratio — target/architectural
- `CPU.026` Maximum ratio — target/architectural
- `CPU.027` AVX2 frequency/ratio envelope — documented/architectural
- `CPU.028` AVX-512 frequency/ratio envelope — documented/architectural
- `CPU.029` Uncore/domain frequency capability — documented/architectural

## CPU-POWER — Power, thermal and control capability
- `CPU.030` TDP — documented
- `CPU.031` Tcase — documented
- `CPU.032` TjMax/temperature-target information — target/documented
- `CPU.033` RAPL/package energy domains — target
- `CPU.034` Architectural package power-limit capability — documented/architectural
- `CPU.035` PL1/PL2 target values — target if safely readable, otherwise unavailable
- `CPU.036` Turbo Boost capability — target/documented
- `CPU.037` EIST/P-state capability — target
- `CPU.038` HWP capability — target
- `CPU.039` CPPC capability/interface presence — target + firmware
- `CPU.040` HWP/CPPC highest_perf — target if available
- `CPU.041` HWP/CPPC guaranteed_perf — target if available
- `CPU.042` HWP/CPPC nominal_perf — target if applicable
- `CPU.043` HWP/CPPC lowest_nonlinear_perf — target if available
- `CPU.044` HWP/CPPC lowest_perf — target if available
- `CPU.045` RDT/RDT allocation/monitoring capabilities — target

## CPU-CACHE/INTERCONNECT
- `CPU.050` L1D size per core — target
- `CPU.051` L1I size per core — target
- `CPU.052` L2 size per core — target
- `CPU.053` LLC size and sharing scope — target
- `CPU.054` UPI links per processor — documented
- `CPU.055` UPI maximum documented rate — documented
- `CPU.056` UPI live link state/rate — target if observable

## MEM — Memory
Acquisition fallbacks for installed topology: SMBIOS → EDAC → SPD/read-only hardware interface → unknown.
- `MEM.001` Kernel MemTotal, raw and normalized — target
- `MEM.002` Physical/EDAC installed capacity if available — target
- `MEM.003` Memory capacity per NUMA node — target
- `MEM.004` IMCs per socket — target/documented
- `MEM.005` Channels per IMC/socket — target/documented
- `MEM.006` Populated channels — target
- `MEM.007` DIMMs per channel — target
- `MEM.008` DIMM capacities/organization — target
- `MEM.009` DIMM type/ECC/buffering — target
- `MEM.010` Configured memory speed — target
- `MEM.011` CPU documented maximum memory speed — documented
- `MEM.012` CPU documented maximum memory bandwidth per socket — documented
- `MEM.013` DIMM manufacturer/part data — target if safely available

## NUMA — NUMA topology
- `NUMA.001` Node count — target
- `NUMA.002` CPU membership per node — target
- `NUMA.003` Memory capacity per node — target
- `NUMA.004` Kernel distance matrix — target
- `NUMA.005` SRAT CPU affinity summary — deterministic derived
- `NUMA.006` SRAT memory affinity summary — deterministic derived
- `NUMA.007` SLIT matrix — deterministic derived
- `NUMA.008` Memoryless nodes — target

## PCI — PCIe/I/O architecture
- `PCI.001` PCI segment count — target
- `PCI.002` MCFG ECAM windows — deterministic derived
- `PCI.003` Kernel-visible PCI root buses — target
- `PCI.004` ACPI PNP0A08 root-bridge count — deterministic derived
- `PCI.005` ACPI root `_SEG`/`_BBN` summary — deterministic derived
- `PCI.006` Total PCI functions — target

For every major endpoint (GPU, NVMe/storage controller, NIC, USB/external-I/O controller, BMC, other high-impact accelerator), record:
- `PCI.EP.*.BDF` BDF
- `PCI.EP.*.ID` VID:DID/subsystem when available
- `PCI.EP.*.CLASS` class/role
- `PCI.EP.*.NUMA` NUMA node
- `PCI.EP.*.PATH` upstream bridge/root path
- `PCI.EP.*.MAX_SPEED` maximum supported link speed
- `PCI.EP.*.MAX_WIDTH` maximum supported width
- `PCI.EP.*.CUR_SPEED` current negotiated speed
- `PCI.EP.*.CUR_WIDTH` current negotiated width
- `PCI.EP.*.BAR` BAR/resource summary if collected
- `PCI.EP.*.IRQ` interrupt/MSI/MSI-X capability summary if collected
- `PCI.EP.*.IOMMU_GROUP` IOMMU group if visible

## IOMMU
- `IOMMU.001` Hardware/firmware VT-d capability — target/firmware
- `IOMMU.002` DMAR presence — target/capture
- `IOMMU.003` DRHD count and include-all flags — deterministic derived
- `IOMMU.004` DMA-remapping host address width — deterministic derived
- `IOMMU.005` Interrupt-remapping capability/flag — deterministic derived
- `IOMMU.006` Kernel-visible IOMMU instances — target
- `IOMMU.007` Kernel IOMMU groups/count — target

## ACPI — Firmware structural inventory
- `ACPI.001` Captured table count — target/capture
- `ACPI.002` Exact table inventory with signature, length, revision, OEM ID, OEM table ID, hash — deterministic derived
- `ACPI.003` AML-bearing definition-block inventory — deterministic derived
- `ACPI.004` Disassembly disposition/errors per definition block — deterministic derived
- `ACPI.005` FADT/FACP key revision/profile facts — deterministic derived
- `ACPI.006` MADT enabled/disabled processor/APIC summary — deterministic derived
- `ACPI.007` IOAPIC summary — deterministic derived
- `ACPI.008` HPET address/capability summary — deterministic derived
- `ACPI.009` SRAT summary — deterministic derived
- `ACPI.010` SLIT summary — deterministic derived
- `ACPI.011` DMAR summary — deterministic derived
- `ACPI.012` MCFG summary — deterministic derived

## ACPI-CPU — Processor namespace/control inventory
Inventory only; no diagnosis.
- `ACPI.CPU.001` Processor object count
- `ACPI.CPU.002` `_PSS` count and owning tables
- `ACPI.CPU.003` `_PPC` count and owning tables
- `ACPI.CPU.004` `_PCT` count and owning tables
- `ACPI.CPU.005` `_CPC` count and owning tables
- `ACPI.CPU.006` `_CST` count and owning tables
- `ACPI.CPU.007` `_OSC`/`_PDC` processor-policy interface summary
- `ACPI.CPU.008` `LoadTable` occurrence/path summary
- `ACPI.CPU.009` OEM1/OEM2/OEM4 identity and semantic labels from table headers/structure

## ACPI-PCI — PCI namespace inventory
- `ACPI.PCI.001` PNP0A08/PNP0A03 root count
- `ACPI.PCI.002` Root bridge path list
- `ACPI.PCI.003` `_SEG` values
- `ACPI.PCI.004` `_BBN` values
- `ACPI.PCI.005` Root `_CRS` availability summary

## CHECK — Mandatory cross-checks
Every check returns `consistent`, `inconsistent`, `not_comparable`, or `unknown`, plus both sides and evidence. Do not diagnose inconsistent results.
- `CHECK.001` Kernel CPU count/IDs ↔ MADT enabled processors/APIC IDs
- `CHECK.002` Kernel CPU→NUMA mapping ↔ SRAT affinity
- `CHECK.003` Kernel NUMA distance matrix ↔ SLIT
- `CHECK.004` Kernel memory-per-node ↔ SRAT memory affinity totals
- `CHECK.005` Kernel PCI root buses ↔ ACPI root bridges (`PNP0A08`/`_SEG`/`_BBN`)
- `CHECK.006` CPU capability flags ↔ ACPI processor control interfaces (`_PSS/_CPC/...`)
- `CHECK.007` Online logical CPUs ↔ firmware Processor objects/slots
- `CHECK.008` DMAR/DRHD firmware description ↔ kernel-visible IOMMU instances/groups
- `CHECK.009` Device sysfs NUMA locality ↔ owning root/ACPI/SRAT locality where comparable
- `CHECK.010` MCFG ECAM coverage ↔ observed PCI segment/bus space

## Terminal review
Before completion, enumerate:
1. all inconsistent checks;
2. all conflicting values;
3. all required unknown/unavailable items and acquisition attempts;
4. all expected sources that were inaccessible;
5. confirmation that no diagnosis, tuning, or materialization recommendation was performed.
