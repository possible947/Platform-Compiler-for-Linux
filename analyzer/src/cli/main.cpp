#include "batch/batch_record.h"
#include "session/session.h"
#include "cli/resource_record.h"
#include "comparison/resource_comparison.h"

#include <exception>
#include <iostream>
#include <stdexcept>
#include <string>

int main(int argc, char **argv) {
    try {
        if (argc == 2 && std::string(argv[1]) == "probe") return analyzer::probe();
        if (argc == 2 && std::string(argv[1]) == "clock") return analyzer::clock_snapshot();
        if (argc >= 3 && std::string(argv[1]) == "record") {
            if (argc == 6 && std::string(argv[2]) == "--config" && std::string(argv[4]) == "--output")
                return analyzer::record(argv[3], argv[5]);

            analyzer::BatchRecordOptions options;
            bool duration_seen = false;
            for (int i = 2; i < argc; i += 2) {
                if (i + 1 >= argc) throw std::runtime_error("missing value for option: " + std::string(argv[i]));
                const std::string flag(argv[i]);
                const std::string value(argv[i + 1]);
                if (flag == "--scenario") options.scenario = value;
                else if (flag == "--model") options.model = value;
                else if (flag == "--output") options.output = value;
                else if (flag == "--duration") {
                    options.idle_duration_seconds = std::stod(value);
                    duration_seen = true;
                } else throw std::runtime_error("unknown record option: " + flag);
            }
            if (options.scenario.empty() || options.output.empty())
                throw std::runtime_error("record requires --scenario and --output");
            if (options.scenario == "idle" && duration_seen == false)
                throw std::runtime_error("idle recording requires --duration");
            return analyzer::batch_record(options);
        }
        if (argc == 12 && std::string(argv[1]) == "compare") {
            std::string idle, cpu, gpu, cpuGpu, output;
            for (int i = 2; i + 1 < argc; i += 2) {
                const std::string flag(argv[i]);
                const std::string value(argv[i + 1]);
                if (flag == "--idle") idle = value;
                else if (flag == "--cpu") cpu = value;
                else if (flag == "--gpu") gpu = value;
                else if (flag == "--cpu-gpu") cpuGpu = value;
                else if (flag == "--output") output = value;
                else throw std::runtime_error("unknown compare option: " + flag);
            }
            analyzer::ResourceRecord idleRecord, cpuRecord, gpuRecord, cpuGpuRecord;
            if (!analyzer::load_resource_record(idle, idleRecord) ||
                !analyzer::load_resource_record(cpu, cpuRecord) ||
                !analyzer::load_resource_record(gpu, gpuRecord) ||
                !analyzer::load_resource_record(cpuGpu, cpuGpuRecord))
                throw std::runtime_error("one or more resource artifacts are invalid");
            analyzer::ResourceComparison comparison = analyzer::compare_four_resource_runs(
                idleRecord, cpuRecord, gpuRecord, cpuGpuRecord);
            if (analyzer::write_resource_comparison(comparison, idle, cpu, gpu, cpuGpu, output) != 0)
                throw std::runtime_error("cannot write comparison artifact");
            std::cout << output << " comparison complete\n";
            return 0;
        }
        std::cerr << "Usage:\n"
                  << "  analyzer record --scenario all|idle|cpu|cpu-numactl|gpu|gpu-numactl|cpu-gpu|cpu-gpu-numactl "
                     "--model MODEL.gguf --output NEW_DIRECTORY [--duration IDLE_SECONDS]\n"
                  << "  analyzer probe\n"
                  << "  analyzer clock\n"
                  << "  analyzer compare --idle FILE --cpu FILE --gpu FILE --cpu-gpu FILE --output FILE\n"
                  << "  analyzer record --config FILE --output NEW_DIRECTORY  (legacy compatibility)\n";
        return 1;
    } catch (const std::exception &error) {
        std::cerr << "analyzer: " << error.what() << '\n';
        return 1;
    }
}