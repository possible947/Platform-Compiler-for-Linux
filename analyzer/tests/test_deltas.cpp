#include "summary/deltas.h"

#include <cassert>
#include <cmath>
#include <limits>

int main() {
    using namespace analyzer;
    const CpuCounters before{100, 0, 25, 425, 0, 0, 0, 0};
    const CpuCounters after{120, 0, 30, 430, 0, 0, 0, 0};
    assert(std::abs(*cpu_load(before, after) - 100.0 * 25.0 / 30.0) < 1e-10);
    assert(!cpu_load(before, before));
    assert(!cpu_load(after, before));
    assert(std::abs(*rapl_watts(1000000, 3000000, 1000000000, 2, 100) - 1.0) < 1e-10);
    assert(!rapl_watts(900, 100, 1000, 1, 100));
    assert(!rapl_watts(0, 100, 1000, 0, 100));
    assert(!rapl_watts(0, 100, 1000, 1, 0));
    assert(!rapl_watts(0, 100, 1000, 1, 100));
    assert(!rapl_watts(0, 100, 1000000000, std::numeric_limits<double>::quiet_NaN(), 100));
    assert(!rapl_watts(0, 2000000, 1000000000, 1, 1));
}