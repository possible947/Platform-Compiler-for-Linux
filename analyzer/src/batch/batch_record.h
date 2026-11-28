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

enum class CombinedLoopAction {
    continue_running,
    restart_gpu,
    stop_cpu_completed,
    stop_failed
};

std::vector<std::string> expand_batch_scenarios(const std::string &scenario);
std::vector<std::string> llama_process_args(const std::string &cli,
                                            const BatchRecordOptions &options,
                                            bool numactl);
CombinedLoopAction combined_loop_action(bool cpu_exited, int cpu_exit_code,
                                        bool gpu_exited, int gpu_exit_code);
int batch_record(const BatchRecordOptions &options);

}
