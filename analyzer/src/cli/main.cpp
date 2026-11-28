#include "session/session.h"
#include "cli/resource_record.h"
#include "comparison/resource_comparison.h"

#include <exception>
#include <filesystem>
#include <iostream>
#include <string>

int main(int argc, char **argv) {
    try {
        if (argc == 2 && std::string(argv[1]) == "probe") return analyzer::probe();
        if (argc == 2 && std::string(argv[1]) == "clock") return analyzer::clock_snapshot();
        if (argc == 6 && std::string(argv[1]) == "record" &&
            std::string(argv[2]) == "--config" && std::string(argv[4]) == "--output")
            return analyzer::record(argv[3], argv[5]);
        if (argc >= 8 && std::string(argv[1]) == "record" && std::string(argv[2]) == "--scenario") {
            std::string scenario, output, metadata;
            double duration = 0.0;
            for (int i = 2; i + 1 < argc; i += 2) {
                const std::string flag(argv[i]);
                const std::string value(argv[i + 1]);
                if (flag == "--scenario") scenario = value;
                else if (flag == "--duration") duration = std::stod(value);
                else if (flag == "--output") output = value;
                else if (flag == "--metadata-json") metadata = value;
                else throw std::runtime_error("unknown record option: " + flag);
            }
            if (scenario.empty() || duration <= 0.0 || output.empty())
                throw std::runtime_error("record requires --scenario, --duration and --output");
            return analyzer::resource_record(scenario, duration, output, metadata);
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
                  << "  analyzer probe\n"
                  << "  analyzer clock\n"
                  << "  analyzer record --config FILE --output NEW_DIRECTORY\n"
                  << "  analyzer record --scenario idle|cpu|gpu|cpu-gpu --duration SECONDS --output NEW_DIRECTORY [--metadata-json FILE]\n"
                  << "  analyzer compare --idle FILE --cpu FILE --gpu FILE --cpu-gpu FILE --output FILE\n";
        return 1;
    } catch (const std::exception &error) {
        std::cerr << "analyzer: " << error.what() << '\n';
        return 1;
    }
}