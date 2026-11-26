#include "collectors/linux.h"

#include <cerrno>
#include <cstring>
#include <iostream>
#include <linux/perf_event.h>
#include <stdexcept>
#include <string>
#include <sys/syscall.h>
#include <time.h>
#include <unistd.h>

namespace {

class Counter {
public:
    Counter(int cpu, std::uint64_t event) {
        perf_event_attr attr{};
        attr.type = PERF_TYPE_HARDWARE;
        attr.size = sizeof(attr);
        attr.config = event;
        attr.exclude_hv = 1;
        attr.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING;
        descriptor_ = static_cast<int>(syscall(SYS_perf_event_open, &attr, -1, cpu, -1, PERF_FLAG_FD_CLOEXEC));
        if (descriptor_ < 0) throw std::runtime_error("perf_event_open: " + std::string(std::strerror(errno)));
    }
    ~Counter() { if (descriptor_ >= 0) close(descriptor_); }
    Counter(const Counter &) = delete;
    Counter &operator=(const Counter &) = delete;
    void sample(const char *name, int index, int cpu) const {
        struct Reading { std::uint64_t value, enabled_ns, running_ns; } reading{};
        if (read(descriptor_, &reading, sizeof(reading)) != static_cast<ssize_t>(sizeof(reading)))
            throw std::runtime_error("perf counter read failed");
        const auto timestamp = analyzer::now();
        std::cout << name << '\t' << index << '\t' << cpu << '\t' << timestamp.monotonic_ns
                  << '\t' << timestamp.realtime_ns << '\t' << reading.value << '\t'
                  << reading.enabled_ns << '\t' << reading.running_ns << '\n';
    }
private:
    int descriptor_ = -1;
};

}

int main(int argc, char **argv) {
    if (argc == 2 && std::string(argv[1]) == "--help") {
        std::cout << "Usage: pmu-perf-check\nReads system-wide cycles and instructions on the first online CPU through perf_event_open.\n";
        return 0;
    }
    if (argc != 1) {
        std::cerr << "Usage: pmu-perf-check [--help]\n";
        return 1;
    }
    try {
        const auto cpus = analyzer::read_cpu("/");
        if (!cpus.error.empty() || cpus.cpus.empty()) throw std::runtime_error("cannot discover online CPUs");
        const int cpu = cpus.cpus.begin()->first;
        Counter cycles(cpu, PERF_COUNT_HW_CPU_CYCLES);
        Counter instructions(cpu, PERF_COUNT_HW_INSTRUCTIONS);
        std::cout << "# type\tsample\tcpu\tmonotonic_ns\trealtime_ns\tvalue\tenabled_ns\trunning_ns\n";
        cycles.sample("cycles", 0, cpu);
        instructions.sample("instructions", 0, cpu);
        timespec interval{1, 0};
        while (nanosleep(&interval, &interval) != 0) {
            if (errno != EINTR) throw std::runtime_error("nanosleep failed");
        }
        cycles.sample("cycles", 1, cpu);
        instructions.sample("instructions", 1, cpu);
        std::cout.flush();
        if (!std::cout) throw std::runtime_error("output write failed");
        return 0;
    } catch (const std::exception &error) {
        std::cerr << "pmu-perf-check: " << error.what() << '\n';
        return 1;
    }
}