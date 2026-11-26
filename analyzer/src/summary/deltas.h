#pragma once

#include <array>
#include <cstdint>
#include <optional>

namespace analyzer {

using CpuCounters = std::array<std::uint64_t, 8>;

std::optional<double> cpu_load(const CpuCounters &before, const CpuCounters &after);
std::optional<double> rapl_watts(std::uint64_t before, std::uint64_t after,
                                 std::uint64_t range, double seconds,
                                 double max_power_watts);

}