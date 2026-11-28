#include "comparison/resource_comparison.h"

#include <systemd/sd-json.h>

#include <cerrno>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <map>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string>

namespace analyzer {
namespace {

sd_json_variant *member(sd_json_variant *object, const char *key) {
    return sd_json_variant_by_key(object, key);
}

double number(sd_json_variant *object, const char *key, double fallback = 0.0) {
    sd_json_variant *value = member(object, key);
    if (!value || !sd_json_variant_is_number(value)) return fallback;
    if (sd_json_variant_is_real(value)) return sd_json_variant_real(value);
    if (sd_json_variant_is_unsigned(value)) return static_cast<double>(sd_json_variant_unsigned(value));
    if (sd_json_variant_is_integer(value)) return static_cast<double>(sd_json_variant_integer(value));
    return fallback;
}

std::string text(sd_json_variant *object, const char *key, const std::string &fallback = {}) {
    sd_json_variant *value = member(object, key);
    if (!value || !sd_json_variant_is_string(value)) return fallback;
    return sd_json_variant_string(value);
}

uint64_t unsigned_number(sd_json_variant *object, const char *key, uint64_t fallback = 0) {
    sd_json_variant *value = member(object, key);
    if (!value) return fallback;
    if (sd_json_variant_is_unsigned(value)) return sd_json_variant_unsigned(value);
    if (sd_json_variant_is_integer(value) && sd_json_variant_integer(value) >= 0)
        return static_cast<uint64_t>(sd_json_variant_integer(value));
    return fallback;
}

std::string escape_json(const std::string &value) {
    std::ostringstream out;
    for (unsigned char ch : value) {
        switch (ch) {
        case '"': out << "\\\""; break;
        case '\\': out << "\\\\"; break;
        case '\b': out << "\\b"; break;
        case '\f': out << "\\f"; break;
        case '\n': out << "\\n"; break;
        case '\r': out << "\\r"; break;
        case '\t': out << "\\t"; break;
        default:
            if (ch < 0x20) out << "\\u" << std::hex << std::setw(4) << std::setfill('0') << int(ch) << std::dec;
            else out << ch;
        }
    }
    return out.str();
}

}

bool load_resource_record(const std::string &path, ResourceRecord &record) {
    sd_json_variant *root = nullptr;
    unsigned line = 0, column = 0;
    if (sd_json_parse_file(nullptr, path.c_str(), SD_JSON_PARSE_MUST_BE_OBJECT,
                           &root, &line, &column) < 0) return false;

    record.schema_version = text(root, "schema_version", "3");
    record.scenario = text(root, "scenario");
    record.measurement_start_monotonic_ns = unsigned_number(root, "measurement_start_monotonic_ns");
    record.measurement_end_monotonic_ns = unsigned_number(root, "measurement_end_monotonic_ns");
    record.measurement_start_realtime_ns = unsigned_number(root, "measurement_start_realtime_ns");
    record.measurement_end_realtime_ns = unsigned_number(root, "measurement_end_realtime_ns");
    record.pcm_version = text(root, "pcm_version");
    record.cpu_model = text(root, "cpu_model");

    sd_json_variant *memory = member(root, "memory");
    if (memory && sd_json_variant_is_array(memory)) {
        for (size_t i = 0; i < sd_json_variant_elements(memory); ++i) {
            sd_json_variant *socket = sd_json_variant_by_index(memory, i);
            SocketMemoryTraffic value;
            value.socket = static_cast<uint32_t>(unsigned_number(socket, "socket"));
            value.dram_read_bytes_per_second = number(socket, "dram_read_bytes_per_second");
            value.dram_write_bytes_per_second = number(socket, "dram_write_bytes_per_second");
            sd_json_variant *imcs = member(socket, "imcs");
            if (imcs && sd_json_variant_is_array(imcs)) {
                for (size_t j = 0; j < sd_json_variant_elements(imcs); ++j) {
                    sd_json_variant *item = sd_json_variant_by_index(imcs, j);
                    ImcTraffic imc;
                    imc.controller = static_cast<uint32_t>(unsigned_number(item, "controller"));
                    imc.read_bytes_per_second = number(item, "read_bytes_per_second");
                    imc.write_bytes_per_second = number(item, "write_bytes_per_second");
                    value.imcs.push_back(imc);
                }
            }
            sd_json_variant *channels = member(socket, "channels");
            if (channels && sd_json_variant_is_array(channels)) {
                for (size_t j = 0; j < sd_json_variant_elements(channels); ++j) {
                    sd_json_variant *item = sd_json_variant_by_index(channels, j);
                    ChannelTraffic channel;
                    channel.channel = static_cast<uint32_t>(unsigned_number(item, "channel"));
                    channel.read_bytes_per_second = number(item, "read_bytes_per_second");
                    channel.write_bytes_per_second = number(item, "write_bytes_per_second");
                    value.channels.push_back(channel);
                }
            }
            record.memory.push_back(value);
        }
    }

    sd_json_variant *numa = member(root, "numa");
    if (numa && sd_json_variant_is_array(numa)) {
        for (size_t i = 0; i < sd_json_variant_elements(numa); ++i) {
            sd_json_variant *item = sd_json_variant_by_index(numa, i);
            SocketNumaTraffic value;
            value.socket = static_cast<uint32_t>(unsigned_number(item, "socket"));
            value.local_memory_bytes = number(item, "local_memory_bytes");
            value.remote_memory_bytes = number(item, "remote_memory_bytes");
            value.local_memory_request_ratio = number(item, "local_memory_request_ratio", -1.0);
            record.numa.push_back(value);
        }
    }

    sd_json_variant *upi = member(root, "upi");
    if (upi && sd_json_variant_is_array(upi)) {
        for (size_t i = 0; i < sd_json_variant_elements(upi); ++i) {
            sd_json_variant *item = sd_json_variant_by_index(upi, i);
            UpilinkTraffic value;
            value.socket = static_cast<uint32_t>(unsigned_number(item, "socket"));
            value.link = static_cast<uint32_t>(unsigned_number(item, "link"));
            value.incoming_bytes_per_second = number(item, "incoming_bytes_per_second");
            value.outgoing_bytes_per_second = number(item, "outgoing_bytes_per_second");
            value.incoming_utilization = number(item, "incoming_utilization", -1.0);
            value.outgoing_utilization = number(item, "outgoing_utilization", -1.0);
            record.upi.push_back(value);
        }
    }

    sd_json_variant *iio = member(root, "iio");
    if (iio && sd_json_variant_is_array(iio)) {
        for (size_t i = 0; i < sd_json_variant_elements(iio); ++i) {
            sd_json_variant *item = sd_json_variant_by_index(iio, i);
            IioStackTraffic value;
            value.socket = static_cast<uint32_t>(unsigned_number(item, "socket"));
            value.stack = static_cast<uint32_t>(unsigned_number(item, "stack"));
            value.name = text(item, "name");
            value.inbound_dma_read_bytes_per_second = number(item, "inbound_dma_read_bytes_per_second");
            value.inbound_dma_write_bytes_per_second = number(item, "inbound_dma_write_bytes_per_second");
            value.outbound_dma_read_bytes_per_second = number(item, "outbound_dma_read_bytes_per_second");
            value.outbound_dma_write_bytes_per_second = number(item, "outbound_dma_write_bytes_per_second");
            record.iio.push_back(value);
        }
    }

    sd_json_variant *gpu = member(root, "gpu_devices");
    if (gpu && sd_json_variant_is_array(gpu)) {
        for (size_t i = 0; i < sd_json_variant_elements(gpu); ++i) {
            sd_json_variant *item = sd_json_variant_by_index(gpu, i);
            GpuIioDevice value;
            value.bdf = text(item, "bdf");
            value.vendor = text(item, "vendor");
            value.device = text(item, "device");
            value.socket = static_cast<uint32_t>(unsigned_number(item, "socket"));
            value.stack = static_cast<uint32_t>(unsigned_number(item, "stack"));
            record.gpu_devices.push_back(value);
        }
    }

    sd_json_variant *cache = member(root, "cache_fabric");
    if (cache && sd_json_variant_is_array(cache)) {
        for (size_t i = 0; i < sd_json_variant_elements(cache); ++i) {
            sd_json_variant *item = sd_json_variant_by_index(cache, i);
            SocketCacheFabricTraffic value;
            value.socket = static_cast<uint32_t>(unsigned_number(item, "socket"));
            value.l3_misses = unsigned_number(item, "l3_misses");
            value.l3_hits = unsigned_number(item, "l3_hits");
            value.l3_hit_ratio = number(item, "l3_hit_ratio", -1.0);
            record.cache_fabric.push_back(value);
        }
    }

    sd_json_variant *metadata = member(root, "workload_metadata");
    if (metadata) {
        record.workload_metadata.encoder_fps = number(metadata, "encoder_fps", -1.0);
        record.workload_metadata.inference_tokens_per_second = number(metadata, "inference_tokens_per_second", -1.0);
        record.workload_metadata.nvme_mb_per_second = number(metadata, "nvme_mb_per_second", -1.0);
        record.workload_metadata.operator_note = text(metadata, "operator_note");
    }

    sd_json_variant *limitations = member(root, "limitations");
    if (limitations && sd_json_variant_is_array(limitations)) {
        for (size_t i = 0; i < sd_json_variant_elements(limitations); ++i) {
            sd_json_variant *item = sd_json_variant_by_index(limitations, i);
            if (sd_json_variant_is_string(item)) record.limitations.push_back(sd_json_variant_string(item));
        }
    }

    sd_json_variant_unref(root);
    return true;
}

ResourceComparison compare_four_resource_runs(const ResourceRecord &idle,
                                               const ResourceRecord &cpu,
                                               const ResourceRecord &gpu,
                                               const ResourceRecord &cpuGpu) {
    ResourceComparison comparison;
    std::map<std::string, std::vector<double>> idle_values, cpu_values, gpu_values, combined_values;

    for (const auto &socket : idle.memory) {
        idle_values["memory.socket." + std::to_string(socket.socket) + ".dram_read"] = {socket.dram_read_bytes_per_second};
        idle_values["memory.socket." + std::to_string(socket.socket) + ".dram_write"] = {socket.dram_write_bytes_per_second};
    }
    for (const auto &socket : cpu.memory) {
        cpu_values["memory.socket." + std::to_string(socket.socket) + ".dram_read"] = {socket.dram_read_bytes_per_second};
        cpu_values["memory.socket." + std::to_string(socket.socket) + ".dram_write"] = {socket.dram_write_bytes_per_second};
        for (const auto &channel : socket.channels)
            cpu_values["memory.socket." + std::to_string(socket.socket) + ".channel." + std::to_string(channel.channel) + ".read"] = {channel.read_bytes_per_second};
    }
    for (const auto &socket : gpu.memory) {
        gpu_values["memory.socket." + std::to_string(socket.socket) + ".dram_read"] = {socket.dram_read_bytes_per_second};
        gpu_values["memory.socket." + std::to_string(socket.socket) + ".dram_write"] = {socket.dram_write_bytes_per_second};
        for (const auto &channel : socket.channels)
            gpu_values["memory.socket." + std::to_string(socket.socket) + ".channel." + std::to_string(channel.channel) + ".read"] = {channel.read_bytes_per_second};
    }
    for (const auto &socket : cpuGpu.memory) {
        combined_values["memory.socket." + std::to_string(socket.socket) + ".dram_read"] = {socket.dram_read_bytes_per_second};
        combined_values["memory.socket." + std::to_string(socket.socket) + ".dram_write"] = {socket.dram_write_bytes_per_second};
        for (const auto &channel : socket.channels)
            combined_values["memory.socket." + std::to_string(socket.socket) + ".channel." + std::to_string(channel.channel) + ".read"] = {channel.read_bytes_per_second};
    }

    for (const auto &socket : idle.numa) idle_values["numa.socket." + std::to_string(socket.socket) + ".local"] = {socket.local_memory_bytes};
    for (const auto &socket : cpu.numa) cpu_values["numa.socket." + std::to_string(socket.socket) + ".local"] = {socket.local_memory_bytes};
    for (const auto &socket : gpu.numa) gpu_values["numa.socket." + std::to_string(socket.socket) + ".local"] = {socket.local_memory_bytes};
    for (const auto &socket : cpuGpu.numa) combined_values["numa.socket." + std::to_string(socket.socket) + ".local"] = {socket.local_memory_bytes};

    for (const auto &link : idle.upi) idle_values["upi.socket." + std::to_string(link.socket) + ".link." + std::to_string(link.link) + ".incoming"] = {link.incoming_bytes_per_second};
    for (const auto &link : cpu.upi) cpu_values["upi.socket." + std::to_string(link.socket) + ".link." + std::to_string(link.link) + ".incoming"] = {link.incoming_bytes_per_second};
    for (const auto &link : gpu.upi) gpu_values["upi.socket." + std::to_string(link.socket) + ".link." + std::to_string(link.link) + ".incoming"] = {link.incoming_bytes_per_second};
    for (const auto &link : cpuGpu.upi) combined_values["upi.socket." + std::to_string(link.socket) + ".link." + std::to_string(link.link) + ".incoming"] = {link.incoming_bytes_per_second};

    for (const auto &stack : idle.iio) idle_values["iio.socket." + std::to_string(stack.socket) + ".stack." + std::to_string(stack.stack) + ".inbound_dma_write"] = {stack.inbound_dma_write_bytes_per_second};
    for (const auto &stack : cpu.iio) cpu_values["iio.socket." + std::to_string(stack.socket) + ".stack." + std::to_string(stack.stack) + ".inbound_dma_write"] = {stack.inbound_dma_write_bytes_per_second};
    for (const auto &stack : gpu.iio) gpu_values["iio.socket." + std::to_string(stack.socket) + ".stack." + std::to_string(stack.stack) + ".inbound_dma_write"] = {stack.inbound_dma_write_bytes_per_second};
    for (const auto &stack : cpuGpu.iio) combined_values["iio.socket." + std::to_string(stack.socket) + ".stack." + std::to_string(stack.stack) + ".inbound_dma_write"] = {stack.inbound_dma_write_bytes_per_second};

    for (const auto &socket : idle.cache_fabric) idle_values["cache_fabric.socket." + std::to_string(socket.socket) + ".l3_misses"] = {static_cast<double>(socket.l3_misses)};
    for (const auto &socket : cpu.cache_fabric) cpu_values["cache_fabric.socket." + std::to_string(socket.socket) + ".l3_misses"] = {static_cast<double>(socket.l3_misses)};
    for (const auto &socket : gpu.cache_fabric) gpu_values["cache_fabric.socket." + std::to_string(socket.socket) + ".l3_misses"] = {static_cast<double>(socket.l3_misses)};
    for (const auto &socket : cpuGpu.cache_fabric) combined_values["cache_fabric.socket." + std::to_string(socket.socket) + ".l3_misses"] = {static_cast<double>(socket.l3_misses)};

    std::set<std::string> keys;
    for (const auto &entry : idle_values) keys.insert(entry.first);
    for (const auto &entry : cpu_values) keys.insert(entry.first);
    for (const auto &entry : gpu_values) keys.insert(entry.first);
    for (const auto &entry : combined_values) keys.insert(entry.first);

    for (const auto &key : keys) {
        NumericDelta metric;
        metric.key = key;
        auto value = [&](const std::map<std::string, std::vector<double>> &values) {
            auto found = values.find(key);
            if (found == values.end() || found->second.empty()) return 0.0;
            double sum = 0.0;
            for (double item : found->second) sum += item;
            return sum / double(found->second.size());
        };
        metric.idle = value(idle_values);
        metric.cpu = value(cpu_values);
        metric.gpu = value(gpu_values);
        metric.cpu_gpu = value(combined_values);
        metric.isolated_sum = metric.cpu + metric.gpu;
        metric.absolute_delta = metric.cpu_gpu - metric.isolated_sum;
        metric.ratio_to_isolated_sum = metric.isolated_sum != 0.0
            ? metric.cpu_gpu / metric.isolated_sum : 0.0;
        comparison.metrics.push_back(metric);
    }
    return comparison;
}

int write_resource_comparison(const ResourceComparison &comparison,
                              const std::string &idle_path,
                              const std::string &cpu_path,
                              const std::string &gpu_path,
                              const std::string &cpuGpu_path,
                              const std::string &output_path) {
    std::ofstream output(output_path);
    if (!output) return 1;
    output << std::setprecision(17) << "{\n";
    output << "  \"schema_version\":\"" << escape_json(comparison.schema_version) << "\",\n";
    output << "  \"runs\":{\"idle\":\"" << escape_json(idle_path)
           << "\",\"cpu\":\"" << escape_json(cpu_path)
           << "\",\"gpu\":\"" << escape_json(gpu_path)
           << "\",\"cpu-gpu\":\"" << escape_json(cpuGpu_path) << "\"},\n";
    output << "  \"resource_delta_matrix\":[";
    for (size_t i = 0; i < comparison.metrics.size(); ++i) {
        if (i) output << ',';
        const auto &metric = comparison.metrics[i];
        output << "{\"key\":\"" << escape_json(metric.key)
               << "\",\"idle\":" << metric.idle
               << ",\"cpu\":" << metric.cpu
               << ",\"gpu\":" << metric.gpu
               << ",\"cpu-gpu\":" << metric.cpu_gpu
               << ",\"isolated_sum_s1_plus_s2\":" << metric.isolated_sum
               << ",\"absolute_delta\":" << metric.absolute_delta
               << ",\"ratio_to_isolated_sum\":" << metric.ratio_to_isolated_sum << '}';
    }
    output << "],\n";
    output << "  \"important_cpu_gpu_minus_isolated_sum\":true\n";
    output << "}\n";
    return 0;
}

}
