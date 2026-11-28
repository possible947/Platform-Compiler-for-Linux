#pragma once

#include "resource/resource_types.h"

#include <string>
#include <vector>

namespace analyzer {

struct NumericDelta {
    std::string key;
    double idle = 0.0;
    double cpu = 0.0;
    double gpu = 0.0;
    double cpu_gpu = 0.0;
    double absolute_delta = 0.0;
    double ratio_to_isolated_sum = 0.0;
    double isolated_sum = 0.0;
};

struct ResourceComparison {
    std::string schema_version = "1";
    std::vector<NumericDelta> metrics;
};

bool load_resource_record(const std::string &path, ResourceRecord &record);
ResourceComparison compare_four_resource_runs(const ResourceRecord &idle,
                                               const ResourceRecord &cpu,
                                               const ResourceRecord &gpu,
                                               const ResourceRecord &cpuGpu);
int write_resource_comparison(const ResourceComparison &comparison,
                              const std::string &idle_path,
                              const std::string &cpu_path,
                              const std::string &gpu_path,
                              const std::string &cpuGpu_path,
                              const std::string &output_path);

}
