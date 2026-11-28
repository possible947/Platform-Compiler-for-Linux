#pragma once

#include <string>
#include <vector>

namespace analyzer {

struct BatchRecordOptions {
    std::string scenario = "all";
    std::string model;
    std::string output;
    double idle_duration_seconds = 60.0;
    std::string prompt = "show me detailed descriptions about C programing language";
    std::string cpu_cli = "/home/viktor/Applications/llama.cpp/cpu/bin/llama-cli";
    std::string gpu_cli = "/home/viktor/Applications/llama.cpp/hip/bin/llama-cli";
    std::string metadata_path;
};

std::vector<std::string> expand_batch_scenarios(const std::string &scenario);
int batch_record(const BatchRecordOptions &options);

}
