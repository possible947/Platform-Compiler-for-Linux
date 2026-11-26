#include <cassert>
#include <chrono>
#include <csignal>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <string>
#include <thread>
#include <time.h>

namespace {
volatile std::sig_atomic_t stopped = 0;
void handle_signal(int) { stopped = 1; }
std::uint64_t clock_ns(clockid_t clock) {
    timespec value{};
    assert(clock_gettime(clock, &value) == 0);
    return static_cast<std::uint64_t>(value.tv_sec) * 1000000000ULL + value.tv_nsec;
}
}

int main(int argc, char **argv) {
    if (argc == 2 && std::string(argv[1]) == "clock") {
        std::cout << "{\"monotonic_ns\":" << clock_ns(CLOCK_MONOTONIC)
                  << ",\"realtime_ns\":" << clock_ns(CLOCK_REALTIME) << "}\n";
        return 0;
    }
    if (argc != 6 || std::string(argv[1]) != "record") return 1;
    std::signal(SIGINT, handle_signal);
    std::signal(SIGTERM, handle_signal);
    const std::filesystem::path output(argv[5]);
    std::filesystem::create_directories(output);
    if (std::getenv("MOCK_PCM_FAILURE")) {
        std::ofstream(output / "measurements.jsonl") << "{\"source\":\"intel_pcm_perf\",\"status\":\"permission_denied\"}\n";
        while (!stopped) std::this_thread::sleep_for(std::chrono::milliseconds(20));
        return 130;
    }
    const auto started = clock_ns(CLOCK_MONOTONIC);
    std::ofstream measurements(output / "measurements.jsonl");
    std::ofstream events(output / "events.jsonl");
    assert(measurements && events);
    unsigned sample = 0;
    while (!stopped) {
        const auto timestamp = clock_ns(CLOCK_MONOTONIC);
        for (const char *metric : {"pcm.instructions", "pcm.cycles"})
            measurements << "{\"source\":\"intel_pcm_perf\",\"metric\":\"" << metric
                         << "\",\"scope\":\"cpu:0\",\"sample_index\":" << sample << ",\"status\":\"available\",\"monotonic_ns\":" << timestamp << "}\n";
        measurements.flush();
        ++sample;
        std::this_thread::sleep_for(std::chrono::milliseconds(20));
    }
    const auto finished = clock_ns(CLOCK_MONOTONIC);
    std::ofstream(output / "manifest.json") << "{\"status\":\"interrupted\",\"pcm_status\":\"available\",\"pcm_error\":false,\"cpu_error\":false,\"rapl_error\":false,\"start_monotonic_ns\":" << started << ",\"end_monotonic_ns\":" << finished << "}\n";
    std::ofstream(output / "summary.json") << "{\"derived\":[{\"metric\":\"pcm.instructions.delta\",\"status\":\"available\",\"start_monotonic_ns\":" << started << ",\"end_monotonic_ns\":" << finished << "},{\"metric\":\"pcm.cycles.delta\",\"status\":\"available\",\"start_monotonic_ns\":" << started << ",\"end_monotonic_ns\":" << finished << "}]}\n";
    return 130;
}