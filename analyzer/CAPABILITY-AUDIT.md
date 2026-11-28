# Memory / UPI / IIO Capability Audit

## Scope

This milestone covers only memory-controller bandwidth, NUMA locality,
UPI traffic, IIO/DMA traffic, and a minimal LLC/fabric observable. It does
not include performance scores or workload orchestration.

## Classification summary

| Observable | Classification | Existing implementation |
| --- | --- | --- |
| Per-socket DRAM read/write | SMALL_ADAPTER_REQUIRED | `getBytesReadFromMC`, `getBytesWrittenToMC` in `third_party/pcm/src/cpucounters.h/cpp` |
| Per-memory-controller read/write | SMALL_ADAPTER_REQUIRED | `ServerUncorePMUs::getNumMC`, `getMCChannels`, `getMCCounter` |
| Per-channel read/write | SMALL_ADAPTER_REQUIRED | `ServerUncoreCounterState::MCCounter`, `getMCCounter(... READ/WRITE ...)` |
| Local memory bandwidth | SMALL_ADAPTER_REQUIRED | `getLocalMemoryBW` in `cpucounters.h/cpp` |
| Remote memory bandwidth | SMALL_ADAPTER_REQUIRED | `getRemoteMemoryBW` in `cpucounters.h/cpp` |
| Local/remote HA request ratio | SMALL_ADAPTER_REQUIRED | `getLocalMemoryRequestRatio` and `localMemoryRequestRatioMetricAvailable` |
| UPI incoming traffic per link | ALREADY_AVAILABLE | `getIncomingQPILinkBytes`, `getIncomingQPILinkUtilization` |
| UPI outgoing traffic per link | ALREADY_AVAILABLE | `getOutgoingQPILinkBytes`, `getOutgoingQPILinkUtilization` |
| UPI link utilization | SEMANTICS_UNCLEAR | PCM helper estimates it from link speed/flits; target stepping and counter validity must be checked |
| IIO/PCIe aggregate stack traffic | SMALL_ADAPTER_REQUIRED | `PcmIioDataCollector`, `initializePCIeBWCounters`, `PcmIioDataCollector::collectData` |
| IIO inbound DMA read/write | SMALL_ADAPTER_REQUIRED | `opCode-6-85.txt` plus `IB read (bytes)` / `IB write (bytes)` |
| IIO outbound CPU-to-device | SMALL_ADAPTER_REQUIRED | `opCode-6-85.txt` plus `OB read (bytes)` / `OB write (bytes)` |
| PCI device/IIO mapping | SMALL_ADAPTER_REQUIRED | `iio_stacks_on_socket`, `iio_stack`, `pci::child_pci_devs`, `PcmIioCsvBuilder` topology |
| GPU BDF attribution | SEMANTICS_UNCLEAR | PCI vendor/device can identify AMD/NVIDIA endpoints, but exact IIO-stack ownership must be verified |
| L3 misses/hits | ALREADY_AVAILABLE | `getL3CacheMisses`, `getL3CacheHits`, `getL3CacheHitRatio` |
| LLC read-miss latency | UNSUPPORTED for the two-socket SKX configuration | `LLCReadMissLatencyMetricsAvailable` excludes multi-socket SKX unless the compile feature is enabled |

## Existing source locations

### DRAM and channels

- `third_party/pcm/src/cpucounters.h`:
  - `ServerUncorePMUs::getMCPerSocket()`;
  - `ServerUncorePMUs::getMCChannels()`;
  - `ServerUncorePMUs::getNumMCChannels()`;
  - `ServerUncoreCounterState::MCCounter`;
  - `getBytesReadFromMC()`;
  - `getBytesWrittenToMC()`;
  - `getMCCounter(channel, counter, before, after)`.
- `third_party/pcm/src/cpucounters.cpp`:
  - `ServerUncorePMUs::getImcReadsForController()`;
  - `ServerUncorePMUs::getImcReadsForChannels()`;
  - `PCM::getServerUncoreCounterState()`;
  - memory bandwidth value is cache-line count converted by the existing PCM memory utility to 64 bytes per cache line.

The adapter converts cache lines to bytes and divides by the actual fixed
measurement interval. It reports per socket and, where the target exposes
channel topology, per flat channel. Per-controller totals are derived from
controller channel ranges.

### NUMA/locality

- `cpucounters.h/cpp`: `getLocalMemoryBW()`, `getRemoteMemoryBW()`,
  `getLocalMemoryRequestRatio()` and the HA/CHA request counters.
- `pcm-numa.cpp`: existing NUMA utility uses
  `PCM::setupCustomCoreEventsForNuma()` and
  `getLocalMemoryBW()` / `getRemoteMemoryBW()` patterns.

The resource adapter uses the same NUMA setup and preserves local/remote byte
counts separately per socket. `local_memory_request_ratio` is included only
when PCM reports support.

### UPI

- `cpucounters.h/cpp`: `getIncomingQPILinkBytes()`,
  `getOutgoingQPILinkBytes()`, `getIncomingQPILinkUtilization()` and
  `getOutgoingQPILinkUtilization()`.
- `ServerUncorePMUs::getIncomingDataFlits()`,
  `getOutgoingFlits()`, `getUPIL0TxCycles()` and `getQPILinkSpeed()`.

The adapter exposes per-socket/per-link bytes and utilization. Outgoing traffic
is retained as an estimate with its PCM semantics explicitly recorded. No
unverified link utilization is invented.

### IIO / DMA

- `pcm-iio-pmu.h`: `PcmIioDataCollector`,
  `initializePCIeBWCounters()`, `PcmIioDataCollector::collectData()`.
- `cpucounters.h/cpp`: `PCM::IIOEventsAvailable()`,
  `PCM::programIIOCounters()`, `PCM::getIIOCounterStates()`.
- `opCode-6-85.txt`: the bundled target-family event file for model 85
  identifies inbound write/read and outbound read/write events.
- `pcm-iio-topology.cpp`: maps IIO stack/socket/root topology and PCI devices.

The adapter filters the existing IIO event set to four payload directions:
IB write, IB read, OB read and OB write. It aggregates existing event values
by socket/IIO stack. It does not emit VT-d, clocktick or unrelated IIO events.

### Cache/fabric

- `cpucounters.h/cpp`: `getL3CacheMisses()`, `getL3CacheHits()`,
  `getL3CacheHitRatio()` and local/remote memory bandwidth helpers.

The adapter exposes only per-socket L3 miss, L3 hit and hit ratio. It does
not add a general cache profiler or classifications.

## Intentionally excluded

- DIMM-rank traffic is excluded because it is not required to distinguish the
  stated DRAM/UPI/IIO question and is not retained as a default fixed metric.
- CXL traffic is not required and is excluded.
- Package C-state, CPU frequency and thermal data are outside this milestone.
- VT-d/IOTLB events are excluded.
- Arbitrary IIO event names are excluded.
- GPU device-name attribution is not promoted to a guarantee. It is recorded
  only when vendor/device and IIO topology mapping agree.
- Bottleneck, performance and remediation conclusions are excluded.
