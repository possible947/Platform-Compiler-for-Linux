#pragma once

#include "summary/deltas.h"

#include <cstdint>
#include <filesystem>
#include <map>
#include <string>
#include <vector>

namespace analyzer {

struct TimePoint {
    std::uint64_t monotonic_ns;
    std::uint64_t realtime_ns;
};

struct CpuSample {
    TimePoint time;
    std::map<int, CpuCounters> cpus;
    std::string error;
};

struct RaplDomain {
    std::filesystem::path path;
    std::string id;
    std::string name;
    std::string package;
};

struct RaplSample {
    TimePoint time;
    RaplDomain domain;
    std::uint64_t energy = 0;
    std::uint64_t range = 0;
    std::string error;
    std::string range_error;
};

TimePoint now();
CpuSample read_cpu(const std::filesystem::path &root);
std::vector<RaplDomain> discover_rapl(const std::filesystem::path &root,
                                      std::string &error);
RaplSample read_rapl(const RaplDomain &domain);

}