#pragma once

#include <cstdint>
#include <string>
#include <vector>

namespace analyzer {

struct ImcTraffic {
    uint32_t controller = 0;
    double read_bytes_per_second = 0.0;
    double write_bytes_per_second = 0.0;
};

struct ChannelTraffic {
    uint32_t channel = 0;
    double read_bytes_per_second = 0.0;
    double write_bytes_per_second = 0.0;
};

struct SocketMemoryTraffic {
    uint32_t socket = 0;
    double dram_read_bytes_per_second = 0.0;
    double dram_write_bytes_per_second = 0.0;
    std::vector<ImcTraffic> imcs;
    std::vector<ChannelTraffic> channels;
};

struct SocketNumaTraffic {
    uint32_t socket = 0;
    double local_memory_bytes = 0.0;
    double remote_memory_bytes = 0.0;
    double local_memory_request_ratio = -1.0;
};

struct UpilinkTraffic {
    uint32_t socket = 0;
    uint32_t link = 0;
    double incoming_bytes_per_second = 0.0;
    double outgoing_bytes_per_second = 0.0;
    double incoming_utilization = -1.0;
    double outgoing_utilization = -1.0;
};

struct IioStackTraffic {
    uint32_t socket = 0;
    uint32_t stack = 0;
    std::string name;
    double inbound_dma_read_bytes_per_second = 0.0;
    double inbound_dma_write_bytes_per_second = 0.0;
    double outbound_dma_read_bytes_per_second = 0.0;
    double outbound_dma_write_bytes_per_second = 0.0;
};

struct GpuIioDevice {
    std::string bdf;
    std::string vendor;
    std::string device;
    uint32_t socket = 0;
    uint32_t stack = 0;
};

struct SocketCacheFabricTraffic {
    uint32_t socket = 0;
    uint64_t l3_misses = 0;
    uint64_t l3_hits = 0;
    double l3_hit_ratio = -1.0;
};

struct WorkloadMetadata {
    double encoder_fps = -1.0;
    double inference_tokens_per_second = -1.0;
    double nvme_mb_per_second = -1.0;
    std::string operator_note;
};

struct ResourceRecord {
    std::string schema_version = "3";
    std::string scenario;
    uint64_t measurement_start_monotonic_ns = 0;
    uint64_t measurement_end_monotonic_ns = 0;
    uint64_t measurement_start_realtime_ns = 0;
    uint64_t measurement_end_realtime_ns = 0;
    std::string pcm_version;
    std::string cpu_model;
    std::vector<SocketMemoryTraffic> memory;
    std::vector<SocketNumaTraffic> numa;
    std::vector<UpilinkTraffic> upi;
    std::vector<IioStackTraffic> iio;
    std::vector<GpuIioDevice> gpu_devices;
    std::vector<SocketCacheFabricTraffic> cache_fabric;
    WorkloadMetadata workload_metadata;
    std::vector<std::string> limitations;
};

bool valid_resource_scenario(const std::string &scenario);
double cache_lines_to_bytes_per_second(uint64_t cache_lines, double elapsed_seconds);
double isolated_s1_plus_s2(double isolated_cpu, double isolated_gpu);
double resource_delta(double cpu_gpu, double isolated_sum);
double resource_ratio(double cpu_gpu, double isolated_sum);

}
