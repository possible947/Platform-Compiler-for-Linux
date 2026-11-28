#include "cli/resource_record.h"

#include "collectors/resource_pcm.h"
#include "resource/resource_types.h"

#include <systemd/sd-json.h>

#include <cerrno>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <sys/stat.h>
#include <unistd.h>

namespace analyzer {
namespace {

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

WorkloadMetadata read_metadata(const std::string &path) {
    WorkloadMetadata metadata;
    if (path.empty()) return metadata;
    sd_json_variant *root = nullptr;
    unsigned line = 0, column = 0;
    if (sd_json_parse_file(nullptr, path.c_str(), SD_JSON_PARSE_MUST_BE_OBJECT,
                           &root, &line, &column) < 0)
        throw std::runtime_error("metadata JSON must be an object");

    struct Entry { const char *key; double *target; } entries[] = {
        {"encoder_fps", &metadata.encoder_fps},
        {"inference_tokens_per_second", &metadata.inference_tokens_per_second},
        {"nvme_mb_per_second", &metadata.nvme_mb_per_second}
    };
    for (const auto &entry : entries) {
        sd_json_variant *value = sd_json_variant_by_key(root, entry.key);
        if (!value) continue;
        if (!sd_json_variant_is_number(value)) {
            sd_json_variant_unref(root);
            throw std::runtime_error(std::string("metadata field must be numeric: ") + entry.key);
        }
        *entry.target = sd_json_variant_real(value);
    }
    sd_json_variant *note = sd_json_variant_by_key(root, "operator_note");
    if (note) {
        if (!sd_json_variant_is_string(note)) {
            sd_json_variant_unref(root);
            throw std::runtime_error("metadata field must be a string: operator_note");
        }
        metadata.operator_note = sd_json_variant_string(note);
    }
    sd_json_variant_unref(root);
    return metadata;
}

void write_resource_json(const std::string &path, const ResourceRecord &record) {
    std::ofstream output(path);
    if (!output) throw std::runtime_error("cannot create resource artifact");
    output << std::setprecision(17);
    output << "{\n";
    output << "  \"schema_version\":\"" << escape_json(record.schema_version) << "\",\n";
    output << "  \"scenario\":\"" << escape_json(record.scenario) << "\",\n";
    output << "  \"measurement_start_monotonic_ns\":" << record.measurement_start_monotonic_ns << ",\n";
    output << "  \"measurement_end_monotonic_ns\":" << record.measurement_end_monotonic_ns << ",\n";
    output << "  \"measurement_start_realtime_ns\":" << record.measurement_start_realtime_ns << ",\n";
    output << "  \"measurement_end_realtime_ns\":" << record.measurement_end_realtime_ns << ",\n";
    output << "  \"pcm_version\":\"" << escape_json(record.pcm_version) << "\",\n";
    output << "  \"cpu_model\":\"" << escape_json(record.cpu_model) << "\",\n";

    output << "  \"memory\":[";
    for (size_t i = 0; i < record.memory.size(); ++i) {
        const auto &socket = record.memory[i];
        if (i) output << ',';
        output << "{\"socket\":" << socket.socket
               << ",\"dram_read_bytes_per_second\":" << socket.dram_read_bytes_per_second
               << ",\"dram_write_bytes_per_second\":" << socket.dram_write_bytes_per_second
               << ",\"imcs\":[";
        for (size_t j = 0; j < socket.imcs.size(); ++j) {
            if (j) output << ',';
            const auto &imc = socket.imcs[j];
            output << "{\"controller\":" << imc.controller
                   << ",\"read_bytes_per_second\":" << imc.read_bytes_per_second
                   << ",\"write_bytes_per_second\":" << imc.write_bytes_per_second << '}';
        }
        output << "],\"channels\":[";
        for (size_t j = 0; j < socket.channels.size(); ++j) {
            if (j) output << ',';
            const auto &channel = socket.channels[j];
            output << "{\"channel\":" << channel.channel
                   << ",\"read_bytes_per_second\":" << channel.read_bytes_per_second
                   << ",\"write_bytes_per_second\":" << channel.write_bytes_per_second << '}';
        }
        output << "]}";
    }
    output << "],\n";

    output << "  \"numa\":[";
    for (size_t i = 0; i < record.numa.size(); ++i) {
        if (i) output << ',';
        const auto &entry = record.numa[i];
        output << "{\"socket\":" << entry.socket
               << ",\"local_memory_bytes\":" << entry.local_memory_bytes
               << ",\"remote_memory_bytes\":" << entry.remote_memory_bytes
               << ",\"local_memory_request_ratio\":" << entry.local_memory_request_ratio << '}';
    }
    output << "],\n";

    output << "  \"upi\":[";
    for (size_t i = 0; i < record.upi.size(); ++i) {
        if (i) output << ',';
        const auto &entry = record.upi[i];
        output << "{\"socket\":" << entry.socket << ",\"link\":" << entry.link
               << ",\"incoming_bytes_per_second\":" << entry.incoming_bytes_per_second
               << ",\"outgoing_bytes_per_second\":" << entry.outgoing_bytes_per_second
               << ",\"incoming_utilization\":" << entry.incoming_utilization
               << ",\"outgoing_utilization\":" << entry.outgoing_utilization << '}';
    }
    output << "],\n";

    output << "  \"iio\":[";
    for (size_t i = 0; i < record.iio.size(); ++i) {
        if (i) output << ',';
        const auto &entry = record.iio[i];
        output << "{\"socket\":" << entry.socket << ",\"stack\":" << entry.stack
               << ",\"name\":\"" << escape_json(entry.name)
               << "\",\"inbound_dma_read_bytes_per_second\":" << entry.inbound_dma_read_bytes_per_second
               << ",\"inbound_dma_write_bytes_per_second\":" << entry.inbound_dma_write_bytes_per_second
               << ",\"outbound_dma_read_bytes_per_second\":" << entry.outbound_dma_read_bytes_per_second
               << ",\"outbound_dma_write_bytes_per_second\":" << entry.outbound_dma_write_bytes_per_second << '}';
    }
    output << "],\n";

    output << "  \"gpu_devices\":[";
    for (size_t i = 0; i < record.gpu_devices.size(); ++i) {
        if (i) output << ',';
        const auto &entry = record.gpu_devices[i];
        output << "{\"bdf\":\"" << escape_json(entry.bdf)
               << "\",\"vendor\":\"" << escape_json(entry.vendor)
               << "\",\"device\":\"" << escape_json(entry.device)
               << "\",\"socket\":" << entry.socket << ",\"stack\":" << entry.stack << '}';
    }
    output << "],\n";

    output << "  \"cache_fabric\":[";
    for (size_t i = 0; i < record.cache_fabric.size(); ++i) {
        if (i) output << ',';
        const auto &entry = record.cache_fabric[i];
        output << "{\"socket\":" << entry.socket
               << ",\"l3_misses\":" << entry.l3_misses
               << ",\"l3_hits\":" << entry.l3_hits
               << ",\"l3_hit_ratio\":" << entry.l3_hit_ratio << '}';
    }
    output << "],\n";

    output << "  \"workload_metadata\":{"
           << "\"encoder_fps\":" << record.workload_metadata.encoder_fps
           << ",\"inference_tokens_per_second\":" << record.workload_metadata.inference_tokens_per_second
           << ",\"nvme_mb_per_second\":" << record.workload_metadata.nvme_mb_per_second
           << ",\"operator_note\":\"" << escape_json(record.workload_metadata.operator_note) << "\"},\n";

    output << "  \"limitations\":[";
    for (size_t i = 0; i < record.limitations.size(); ++i) {
        if (i) output << ',';
        output << "\"" << escape_json(record.limitations[i]) << "\"";
    }
    output << "]\n";
    output << "}\n";
}

}

int resource_record(const std::string &scenario,
                    double duration_seconds,
                    const std::string &output_path,
                    const std::string &metadata_path) {
    if (!valid_resource_scenario(scenario)) {
        std::cerr << "scenario must be one of: idle, cpu, gpu, cpu-gpu\n";
        return 1;
    }
    if (duration_seconds < 1.0 || duration_seconds > 3600.0) {
        std::cerr << "duration must be between 1 and 3600 seconds\n";
        return 1;
    }

    if (mkdir(output_path.c_str(), 0700) != 0) {
        std::cerr << "cannot create output directory: " << std::strerror(errno) << '\n';
        return 1;
    }

    try {
        WorkloadMetadata metadata = read_metadata(metadata_path);
        ResourcePcmCollector collector;
        ResourcePcmStatus status = collector.start();
        if (status.status != "available") {
            ResourceRecord record;
            record.schema_version = "3";
            record.scenario = scenario;
            record.workload_metadata = metadata;
            record.limitations.push_back(status.error.empty() ? status.status : status.error);
            write_resource_json(output_path + "/resource.json", record);
            collector.stop();
            std::cerr << "PCM resource measurement unavailable: " << status.status;
            if (!status.error.empty()) std::cerr << " (" << status.error << ')';
            std::cerr << '\n';
            return 2;
        }

        ResourceRecord record = collector.measure(scenario, duration_seconds, metadata);
        collector.stop();
        write_resource_json(output_path + "/resource.json", record);
        std::cout << output_path << " " << scenario << " complete\n";
        return 0;
    } catch (const std::exception &error) {
        std::cerr << "analyzer resource record failed: " << error.what() << '\n';
        return 1;
    }
}

}
