#include "collectors/resource_pcm.h"

#include "cpucounters.h"
#include "pcm-iio-pmu.h"
#include "version.h"

#include <cerrno>
#include <cstdlib>
#include <cstring>
#include <dirent.h>
#include <filesystem>
#include <fstream>
#include <map>
#include <set>
#include <thread>
#include <unistd.h>
#include <sys/utsname.h>

namespace analyzer {
namespace {

std::filesystem::path find_pcm_source_dir() {
    const std::filesystem::path candidates[] = {
        "third_party/pcm/src",
        "analyzer/third_party/pcm/src",
        "/home/viktor/LLM/Projects/Platform-Compiler-for-Linux/analyzer/third_party/pcm/src"
    };
    for (const auto &candidate : candidates) {
        if (std::filesystem::is_regular_file(candidate / "opCode-6-85.txt")) return candidate;
    }
    char buffer[4096] = {};
    const ssize_t size = readlink("/proc/self/exe", buffer, sizeof(buffer) - 1);
    if (size > 0) {
        auto exe = std::filesystem::path(std::string(buffer, size));
        for (auto dir = exe.parent_path(); !dir.empty(); dir = dir.parent_path()) {
            auto candidate = dir / "third_party/pcm/src";
            if (std::filesystem::is_regular_file(candidate / "opCode-6-85.txt")) return candidate;
            candidate = dir / "analyzer/third_party/pcm/src";
            if (std::filesystem::is_regular_file(candidate / "opCode-6-85.txt")) return candidate;
        }
    }
    return {};
}

std::string read_hex_id(const std::filesystem::path &path) {
    std::ifstream input(path);
    std::string value;
    if (input >> value) return value;
    return "";
}

std::string format_bdf(const pcm::bdf &bdf) {
    char buffer[32];
    std::snprintf(buffer, sizeof(buffer), "%04x:%02x:%02x.%x",
                  bdf.domainno, bdf.busno, bdf.devno, bdf.funcno);
    return buffer;
}

void collect_gpu_device(const pcm::pci &device,
                        uint32_t socket,
                        uint32_t stack,
                        std::vector<GpuIioDevice> &devices) {
    if (device.exist) {
        if (device.vendor_id == 0x1002 || device.vendor_id == 0x10de) {
            GpuIioDevice record;
            record.bdf = format_bdf(device.bdf);
            record.vendor = "0x" + [&]() {
                char b[16]; std::snprintf(b, sizeof(b), "%04x", device.vendor_id); return std::string(b);
            }();
            record.device = "0x" + [&]() {
                char b[16]; std::snprintf(b, sizeof(b), "%04x", device.device_id); return std::string(b);
            }();
            record.socket = socket;
            record.stack = stack;
            devices.push_back(record);
        }
    }
    for (const auto &child : device.child_pci_devs)
        collect_gpu_device(child, socket, stack, devices);
}

std::string normalize_iio_name(const std::string &name) {
    if (name.find("IB write") == 0) return "inbound_dma_write";
    if (name.find("IB read") == 0) return "inbound_dma_read";
    if (name.find("OB write") == 0) return "outbound_dma_write";
    if (name.find("OB read") == 0) return "outbound_dma_read";
    return "";
}

}

ResourcePcmStatus ResourcePcmCollector::start() {
    setenv("PCM_KEEP_NMI_WATCHDOG", "1", 1);
    unsetenv("PCM_NO_MSR");

    pcm::PCM *monitor = pcm::PCM::getInstance();
    if (!monitor || !monitor->good())
        return {"permission_denied", "PCM could not open MSR/PCI access"};

    pcm::PCM::ExtendedCustomCoreEventDescription numa;
    pcm::EventSelectRegister regs[4];
    numa.fixedCfg = nullptr;
    numa.nGPCounters = 2;
    numa.gpCounterCfg = regs;
    try {
        monitor->setupCustomCoreEventsForNuma(numa);
    } catch (const std::exception &error) {
        return {"unsupported", std::string("NUMA core events unavailable: ") + error.what()};
    }

    const pcm::PCM::ErrorCode status = monitor->program(pcm::PCM::EXT_CUSTOM_CORE_EVENTS, &numa, true);
    if (status != pcm::PCM::Success)
        return {status == pcm::PCM::PMUBusy ? "conflict" : "permission_denied",
                "PCM full resource program failed (code " + std::to_string(status) + ")"};

    started_ = true;
    return {"available", ""};
}

ResourceRecord ResourcePcmCollector::measure(const std::string &scenario, double duration_seconds,
                                              const WorkloadMetadata &metadata) {
    ResourceRecord record;
    record.schema_version = "3";
    record.scenario = scenario;
    record.workload_metadata = metadata;

    pcm::PCM *monitor = pcm::PCM::getInstance();
    if (!monitor) {
        record.limitations.push_back("PCM unavailable");
        return record;
    }

    utsname kernel{};
    if (uname(&kernel) == 0) record.cpu_model = std::string(kernel.machine);
    std::ifstream cpuinfo("/proc/cpuinfo");
    std::string cpuinfo_line;
    while (std::getline(cpuinfo, cpuinfo_line)) {
        if (cpuinfo_line.rfind("model name", 0) == 0) {
            const auto colon = cpuinfo_line.find(':');
            if (colon != std::string::npos) {
                record.cpu_model = cpuinfo_line.substr(colon + 1);
                while (!record.cpu_model.empty() && (record.cpu_model.front() == ' ' || record.cpu_model.front() == '\t'))
                    record.cpu_model.erase(record.cpu_model.begin());
            }
            break;
        }
    }

    record.pcm_version = PCM_VERSION;

    timespec real_start{}, mono_start{}, real_end{}, mono_end{};
    clock_gettime(CLOCK_REALTIME, &real_start);
    clock_gettime(CLOCK_MONOTONIC, &mono_start);

    pcm::SystemCounterState system_before;
    std::vector<pcm::SocketCounterState> socket_before;
    std::vector<pcm::CoreCounterState> core_before;
    monitor->getAllCounterStates(system_before, socket_before, core_before, true);
    std::vector<pcm::ServerUncoreCounterState> server_before(monitor->getNumSockets());
    for (uint32_t socket = 0; socket < monitor->getNumSockets(); ++socket)
        server_before[socket] = monitor->getServerUncoreCounterState(socket);

    struct pcm_iio_config iio_config;
    iio_config.pmu_config.delay = duration_seconds;
    std::filesystem::path pcm_dir = find_pcm_source_dir();
    std::error_code ec;
    const auto original_cwd = std::filesystem::current_path(ec);
    if (!ec && !pcm_dir.empty()) {
        std::filesystem::current_path(pcm_dir, ec);
    }

    bool iio_supported = false;
    std::unique_ptr<PcmIioDataCollector> iio_collector;
    if (!ec && monitor->IIOEventsAvailable()) {
        iio_supported = initializePCIeBWCounters(iio_config.pmu_config);
        if (iio_supported) {
            std::vector<struct iio_counter> filtered;
            for (const auto &counter : iio_config.pmu_config.evt_ctx.ctrs) {
                const std::string name = normalize_iio_name(counter.h_event_name);
                if (!name.empty()) filtered.push_back(counter);
            }
            iio_config.pmu_config.evt_ctx.ctrs.swap(filtered);
            if (!iio_config.pmu_config.evt_ctx.ctrs.empty()) {
                iio_collector = std::make_unique<PcmIioDataCollector>(iio_config.pmu_config);
                iio_collector->collectData();
            } else {
                iio_supported = false;
            }
        }
    } else {
        iio_supported = false;
    }

    if (!ec && !pcm_dir.empty()) std::filesystem::current_path(original_cwd);

    pcm::SystemCounterState system_after;
    std::vector<pcm::SocketCounterState> socket_after;
    std::vector<pcm::CoreCounterState> core_after;
    monitor->getAllCounterStates(system_after, socket_after, core_after, true);
    std::vector<pcm::ServerUncoreCounterState> server_after(monitor->getNumSockets());
    for (uint32_t socket = 0; socket < monitor->getNumSockets(); ++socket)
        server_after[socket] = monitor->getServerUncoreCounterState(socket);

    clock_gettime(CLOCK_REALTIME, &real_end);
    clock_gettime(CLOCK_MONOTONIC, &mono_end);

    record.measurement_start_realtime_ns = uint64_t(real_start.tv_sec) * 1000000000ULL + real_start.tv_nsec;
    record.measurement_end_realtime_ns = uint64_t(real_end.tv_sec) * 1000000000ULL + real_end.tv_nsec;
    record.measurement_start_monotonic_ns = uint64_t(mono_start.tv_sec) * 1000000000ULL + mono_start.tv_nsec;
    record.measurement_end_monotonic_ns = uint64_t(mono_end.tv_sec) * 1000000000ULL + mono_end.tv_nsec;

    const double elapsed = duration_seconds > 0.0 ? duration_seconds :
        (record.measurement_end_monotonic_ns > record.measurement_start_monotonic_ns
            ? double(record.measurement_end_monotonic_ns - record.measurement_start_monotonic_ns) / 1e9 : 0.0);

    for (uint32_t socket = 0; socket < monitor->getNumSockets(); ++socket) {
        SocketMemoryTraffic memory;
        memory.socket = socket;
        if (elapsed > 0.0) {
            memory.dram_read_bytes_per_second = double(pcm::getBytesReadFromMC(socket_before[socket], socket_after[socket])) / elapsed;
            memory.dram_write_bytes_per_second = double(pcm::getBytesWrittenToMC(socket_before[socket], socket_after[socket])) / elapsed;
            const uint32_t controller_count = monitor->getMCPerSocket();
            uint32_t channel_offset = 0;
            for (uint32_t controller = 0; controller < controller_count; ++controller) {
                const size_t channels = monitor->getMCChannels(socket, controller);
                double read = 0.0;
                double write = 0.0;
                for (uint32_t channel = 0; channel < channels; ++channel) {
                    const uint32_t flat = channel_offset + channel;
                    const double channel_read = double(pcm::getMCCounter(flat, pcm::ServerUncorePMUs::EventPosition::READ,
                                                                     server_before[socket], server_after[socket]) * 64ULL) / elapsed;
                    const double channel_write = double(pcm::getMCCounter(flat, pcm::ServerUncorePMUs::EventPosition::WRITE,
                                                                     server_before[socket], server_after[socket]) * 64ULL) / elapsed;
                    ChannelTraffic channel_record;
                    channel_record.channel = flat;
                    channel_record.read_bytes_per_second = channel_read;
                    channel_record.write_bytes_per_second = channel_write;
                    memory.channels.push_back(channel_record);
                    read += channel_read;
                    write += channel_write;
                }
                memory.imcs.push_back({controller, read, write});
                channel_offset += static_cast<uint32_t>(channels);
            }
        }
        record.memory.push_back(memory);

        SocketNumaTraffic numa;
        numa.socket = socket;
        for (uint32_t core = 0; core < monitor->getNumCores(); ++core) {
            if (monitor->getSocketId(core) == static_cast<int32_t>(socket)) {
                numa.local_memory_bytes += pcm::getLocalMemoryBW(core_before[core], core_after[core]);
                numa.remote_memory_bytes += pcm::getRemoteMemoryBW(core_before[core], core_after[core]);
            }
        }
        const double ratio = pcm::getLocalMemoryRequestRatio(socket_before[socket], socket_after[socket]);
        numa.local_memory_request_ratio = ratio;
        record.numa.push_back(numa);

        SocketCacheFabricTraffic cache;
        cache.socket = socket;
        for (uint32_t core = 0; core < monitor->getNumCores(); ++core) {
            if (monitor->getSocketId(core) == static_cast<int32_t>(socket)) {
                cache.l3_misses += pcm::getL3CacheMisses(core_before[core], core_after[core]);
                cache.l3_hits += pcm::getL3CacheHits(core_before[core], core_after[core]);
            }
        }
        const uint64_t total = cache.l3_hits + cache.l3_misses;
        cache.l3_hit_ratio = total ? double(cache.l3_hits) / double(total) : -1.0;
        record.cache_fabric.push_back(cache);

        const uint32_t links = monitor->getQPILinksPerSocket();
        for (uint32_t link = 0; link < links; ++link) {
            UpilinkTraffic traffic;
            traffic.socket = socket;
            traffic.link = link;
            traffic.incoming_bytes_per_second = elapsed > 0.0
                ? double(pcm::getIncomingQPILinkBytes(socket, link, system_before, system_after)) / elapsed : 0.0;
            traffic.outgoing_bytes_per_second = elapsed > 0.0
                ? double(pcm::getOutgoingQPILinkBytes(socket, link, system_before, system_after)) / elapsed : 0.0;
            traffic.incoming_utilization = pcm::getIncomingQPILinkUtilization(socket, link, system_before, system_after);
            traffic.outgoing_utilization = pcm::getOutgoingQPILinkUtilization(socket, link, system_before, system_after);
            record.upi.push_back(traffic);
        }
    }

    if (!iio_supported) {
        record.limitations.push_back("IIO/PCIe/DMA counters unavailable or unsupported on this target");
    } else if (iio_collector) {
        std::vector<IioStackTraffic> stacks;
        for (const auto &socket : iio_config.pmu_config.iios) {
            for (const auto &stack : socket.stacks) {
                IioStackTraffic traffic;
                traffic.socket = socket.socket_id;
                traffic.stack = stack.iio_unit_id;
                traffic.name = stack.stack_name;
                for (const auto &counter : iio_config.pmu_config.evt_ctx.ctrs) {
                    if (!counter.data.empty()) {
                        const auto &sample = counter.data[0];
                        uint64_t sum = 0;
                        if (socket.socket_id < sample.size() && stack.iio_unit_id < sample[socket.socket_id].size()) {
                            for (const auto &entry : sample[socket.socket_id][stack.iio_unit_id]) {
                                if (entry.first.first == counter.h_id) sum += entry.second;
                            }
                        }
                        const std::string name = normalize_iio_name(counter.h_event_name);
                        if (name == "inbound_dma_read") traffic.inbound_dma_read_bytes_per_second += sum;
                        else if (name == "inbound_dma_write") traffic.inbound_dma_write_bytes_per_second += sum;
                        else if (name == "outbound_dma_read") traffic.outbound_dma_read_bytes_per_second += sum;
                        else if (name == "outbound_dma_write") traffic.outbound_dma_write_bytes_per_second += sum;
                    }
                }
                stacks.push_back(traffic);

                for (const auto &part : stack.parts) {
                    for (const auto &device : part.child_pci_devs)
                        collect_gpu_device(device, socket.socket_id, stack.iio_unit_id, record.gpu_devices);
                }
            }
        }
        record.iio = stacks;

        for (uint32_t socket = 0; socket < monitor->getNumSockets(); ++socket) {
            const std::string gpu_path = "/sys/bus/pci/devices";
            DIR *dir = opendir(gpu_path.c_str());
            if (!dir) break;
            dirent *entry;
            while ((entry = readdir(dir))) {
                if (entry->d_name[0] == '.') continue;
                const std::filesystem::path pci(entry->d_name);
                const std::string vendor = read_hex_id(gpu_path + "/" + pci.string() + "/vendor");
                const std::string class_id = read_hex_id(gpu_path + "/" + pci.string() + "/class");
                if ((vendor == "0x1002" || vendor == "0x10de") && class_id.rfind("0x0300", 0) == 0) {
                    GpuIioDevice record_device;
                    record_device.bdf = pci.string();
                    record_device.vendor = vendor;
                    record_device.device = read_hex_id(gpu_path + "/" + pci.string() + "/device");
                    record_device.socket = socket;
                    bool duplicate = false;
                    for (const auto &existing : record.gpu_devices)
                        if (existing.bdf == record_device.bdf) duplicate = true;
                    if (!duplicate) record.gpu_devices.push_back(record_device);
                }
            }
            closedir(dir);
            break;
        }
    }

    if (!monitor->incomingQPITrafficMetricsAvailable()) record.limitations.push_back("UPI incoming traffic unsupported");
    if (!monitor->outgoingQPITrafficMetricsAvailable()) record.limitations.push_back("UPI outgoing traffic unsupported");
    if (!monitor->localMemoryRequestRatioMetricAvailable()) record.limitations.push_back("Local/remote request ratio unsupported");
    if (!monitor->isL3CacheMissesAvailable()) record.limitations.push_back("L3 cache miss counters unavailable");

    return record;
}

void ResourcePcmCollector::stop() {
    pcm::PCM *monitor = pcm::PCM::getInstance();
    if (monitor) monitor->cleanup(true);
    started_ = false;
}

}
