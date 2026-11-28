#include "batch/batch_record.h"

#include <cassert>
#include <string>
#include <vector>

int main() {
    using namespace analyzer;

    const std::vector<std::string> all{
        "idle", "cpu", "cpu-numactl", "gpu", "gpu-numactl",
        "cpu-gpu", "cpu-gpu-numactl"};
    assert(expand_batch_scenarios("all") == all);
    for (const auto &scenario : all)
        assert(expand_batch_scenarios(scenario) == std::vector<std::string>{scenario});

    assert(expand_batch_scenarios("gpu-numaclt").empty());
    assert(expand_batch_scenarios("CPU").empty());
    assert(expand_batch_scenarios("cpu-numa").empty());

    BatchRecordOptions defaults;
    assert(defaults.idle_duration_seconds == 60.0);
    assert(defaults.prompt == "show me detailed descriptions about C programing language");

    defaults.model = "/models/test.gguf";
    const std::vector<std::string> default_args = llama_process_args("llama-cli", defaults, false);
    assert((default_args == std::vector<std::string>{
        "llama-cli", "-m", "/models/test.gguf", "-p",
        "show me detailed descriptions about C programing language", "-st"}));
    const std::vector<std::string> numactl_args = llama_process_args("llama-cli", defaults, true);
    assert((numactl_args == std::vector<std::string>{
        "llama-cli", "-m", "/models/test.gguf", "-p",
        "show me detailed descriptions about C programing language", "-st",
        "--numa", "numactl"}));

    assert(combined_loop_action(false, -1, false, -1) ==
           CombinedLoopAction::continue_running);
    assert(combined_loop_action(false, -1, true, 0) ==
           CombinedLoopAction::restart_gpu);
    assert(combined_loop_action(true, 0, false, -1) ==
           CombinedLoopAction::stop_cpu_completed);
    assert(combined_loop_action(true, 0, true, 0) ==
           CombinedLoopAction::stop_cpu_completed);
    assert(combined_loop_action(false, -1, true, 7) ==
           CombinedLoopAction::stop_failed);
    assert(combined_loop_action(true, 1, false, -1) ==
           CombinedLoopAction::stop_failed);
    assert(combined_loop_action(true, 0, true, 9) ==
           CombinedLoopAction::stop_failed);
}
