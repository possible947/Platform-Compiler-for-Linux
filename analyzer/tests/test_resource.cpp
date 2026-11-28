#include "comparison/resource_comparison.h"
#include "resource/resource_types.h"

#include <cassert>
#include <cmath>
#include <filesystem>
#include <fstream>
#include <string>

namespace {

void write_record(const std::filesystem::path &path,
                  const std::string &scenario,
                  double socket0_read,
                  double socket0_write,
                  double socket1_read,
                  double socket1_write) {
    std::ofstream output(path);
    output << "{\"schema_version\":\"3\",\"scenario\":\"" << scenario
           << "\",\"measurement_start_monotonic_ns\":100,\"measurement_end_monotonic_ns\":1100"
           << ",\"measurement_start_realtime_ns\":100,\"measurement_end_realtime_ns\":1100"
           << ",\"pcm_version\":\"test\",\"cpu_model\":\"test\","
           << "\"memory\":["
           << "{\"socket\":0,\"dram_read_bytes_per_second\":" << socket0_read
           << ",\"dram_write_bytes_per_second\":" << socket0_write
           << ",\"imcs\":[],\"channels\":[]},"
           << "{\"socket\":1,\"dram_read_bytes_per_second\":" << socket1_read
           << ",\"dram_write_bytes_per_second\":" << socket1_write
           << ",\"imcs\":[],\"channels\":[]}],"
           << "\"numa\":[{\"socket\":0,\"local_memory_bytes\":100,\"remote_memory_bytes\":10,\"local_memory_request_ratio\":0.9}],"
           << "\"upi\":[{\"socket\":0,\"link\":0,\"incoming_bytes_per_second\":20,\"outgoing_bytes_per_second\":30,\"incoming_utilization\":0.2,\"outgoing_utilization\":0.3}],"
           << "\"iio\":[{\"socket\":0,\"stack\":1,\"name\":\"PCIe0\",\"inbound_dma_read_bytes_per_second\":40,\"inbound_dma_write_bytes_per_second\":50,\"outbound_dma_read_bytes_per_second\":60,\"outbound_dma_write_bytes_per_second\":70}],"
           << "\"gpu_devices\":[],\"cache_fabric\":[{\"socket\":0,\"l3_misses\":80,\"l3_hits\":20,\"l3_hit_ratio\":0.2}],"
           << "\"workload_metadata\":{\"encoder_fps\":-1,\"inference_tokens_per_second\":-1,\"nvme_mb_per_second\":-1,\"operator_note\":\"test\"},"
           << "\"limitations\":[]}\n";
}

}

int main() {
    using namespace analyzer;

    assert(valid_resource_scenario("idle"));
    assert(valid_resource_scenario("cpu"));
    assert(valid_resource_scenario("gpu"));
    assert(valid_resource_scenario("cpu-gpu"));
    assert(!valid_resource_scenario("CPU"));
    assert(!valid_resource_scenario("cpu_io"));

    assert(std::abs(cache_lines_to_bytes_per_second(1000, 2.0) - 32000.0) < 1e-9);
    assert(cache_lines_to_bytes_per_second(1000, 0.0) == 0.0);
    assert(isolated_s1_plus_s2(30.0, 40.0) == 70.0);
    assert(resource_delta(75.0, 70.0) == 5.0);
    assert(resource_ratio(70.0, 70.0) == 1.0);
    assert(resource_ratio(70.0, 0.0) == 0.0);

    char name[] = "/tmp/analyzer-resource-test-XXXXXX";
    const auto *created = mkdtemp(name);
    assert(created);
    const std::filesystem::path root(created);

    write_record(root / "idle.json", "idle", 100.0, 10.0, 200.0, 20.0);
    write_record(root / "cpu.json", "cpu", 300.0, 30.0, 400.0, 40.0);
    write_record(root / "gpu.json", "gpu", 500.0, 50.0, 600.0, 60.0);
    write_record(root / "cpu-gpu.json", "cpu-gpu", 900.0, 90.0, 1100.0, 110.0);

    ResourceRecord idle, cpu, gpu, cpuGpu;
    assert(load_resource_record((root / "idle.json").string(), idle));
    assert(load_resource_record((root / "cpu.json").string(), cpu));
    assert(load_resource_record((root / "gpu.json").string(), gpu));
    assert(load_resource_record((root / "cpu-gpu.json").string(), cpuGpu));

    assert(idle.memory.size() == 2);
    assert(idle.numa.size() == 1);
    assert(idle.upi.size() == 1);
    assert(idle.iio.size() == 1);
    assert(idle.cache_fabric.size() == 1);

    const ResourceComparison comparison = compare_four_resource_runs(idle, cpu, gpu, cpuGpu);
    assert(comparison.metrics.size() >= 8);

    bool found_socket0 = false;
    bool found_socket1 = false;
    bool found_upi = false;
    bool found_iio = false;
    bool found_cache = false;
    for (const auto &metric : comparison.metrics) {
        if (metric.key == "memory.socket.0.dram_read") {
            found_socket0 = true;
            assert(metric.idle == 100.0);
            assert(metric.cpu == 300.0);
            assert(metric.gpu == 500.0);
            assert(metric.cpu_gpu == 900.0);
            assert(metric.isolated_sum == 800.0);
            assert(metric.absolute_delta == 100.0);
            assert(metric.ratio_to_isolated_sum == 900.0 / 800.0);
        }
        if (metric.key == "memory.socket.1.dram_read") found_socket1 = true;
        if (metric.key == "upi.socket.0.link.0.incoming") found_upi = true;
        if (metric.key.find("iio.socket.0.stack.1") == 0) found_iio = true;
        if (metric.key == "cache_fabric.socket.0.l3_misses") found_cache = true;
    }
    assert(found_socket0 && found_socket1 && found_upi && found_iio && found_cache);

    const std::filesystem::path output = root / "comparison.json";
    assert(write_resource_comparison(comparison,
                                     (root / "idle.json").string(),
                                     (root / "cpu.json").string(),
                                     (root / "gpu.json").string(),
                                     (root / "cpu-gpu.json").string(),
                                     output.string()) == 0);

    ResourceRecord missing;
    const std::filesystem::path missing_path = root / "missing.json";
    std::ofstream missing_output(missing_path);
    missing_output << "{\"schema_version\":\"3\",\"scenario\":\"idle\",\"memory\":[],\"limitations\":[\"unsupported\"]}\n";
    missing_output.close();
    assert(load_resource_record(missing_path.string(), missing));
    assert(missing.memory.empty());
    assert(missing.limitations.size() == 1 && missing.limitations[0] == "unsupported");

    std::filesystem::remove_all(root);
}
