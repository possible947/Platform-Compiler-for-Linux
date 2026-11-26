#include "summary/deltas.h"

#include <cmath>

namespace analyzer {

std::optional<double> cpu_load(const CpuCounters &before, const CpuCounters &after) {
    long double total = 0;
    long double idle = 0;
    for (std::size_t index = 0; index < before.size(); ++index) {
        if (after[index] < before[index]) return std::nullopt;
        const auto delta = after[index] - before[index];
        total += delta;
        if (index == 3 || index == 4) idle += delta;
    }
    if (total == 0) return std::nullopt;
    return static_cast<double>(100.0L * (total - idle) / total);
}

std::optional<double> rapl_watts(std::uint64_t before, std::uint64_t after,
                                 std::uint64_t range, double seconds,
                                 double max_power_watts) {
    if (range == 0 || before >= range || after >= range || after < before ||
        !std::isfinite(seconds) || seconds <= 0 ||
        !std::isfinite(max_power_watts) || max_power_watts <= 0 ||
        max_power_watts * seconds * 1000000.0 >= static_cast<double>(range)) {
        return std::nullopt;
    }
    const double power = static_cast<double>(after - before) / 1000000.0 / seconds;
    if (power > max_power_watts) return std::nullopt;
    return power;
}

}