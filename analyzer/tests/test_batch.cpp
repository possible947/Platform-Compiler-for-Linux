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
}
