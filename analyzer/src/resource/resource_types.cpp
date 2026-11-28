#include "resource/resource_types.h"

namespace analyzer {

bool valid_resource_scenario(const std::string &scenario) {
    return scenario == "idle" || scenario == "cpu" || scenario == "cpu-numactl" ||
           scenario == "gpu" || scenario == "gpu-numactl" ||
           scenario == "cpu-gpu" || scenario == "cpu-gpu-numactl";
}

bool valid_batch_scenario(const std::string &scenario) {
    return scenario == "all" || valid_resource_scenario(scenario);
}

double cache_lines_to_bytes_per_second(uint64_t cache_lines, double elapsed_seconds) {
    if (elapsed_seconds <= 0.0) return 0.0;
    return static_cast<double>(cache_lines) * 64.0 / elapsed_seconds;
}

double isolated_s1_plus_s2(double isolated_cpu, double isolated_gpu) {
    return isolated_cpu + isolated_gpu;
}

double resource_delta(double cpu_gpu, double isolated_sum) {
    return cpu_gpu - isolated_sum;
}

double resource_ratio(double cpu_gpu, double isolated_sum) {
    return isolated_sum != 0.0 ? cpu_gpu / isolated_sum : 0.0;
}

}
