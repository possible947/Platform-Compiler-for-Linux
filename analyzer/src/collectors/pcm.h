#pragma once

#include "collectors/linux.h"

#include <cstdint>
#include <memory>
#include <string>
#include <vector>

namespace analyzer {

struct PcmStatus {
    std::string status;
    std::string error;
};

struct PcmReading {
    int cpu = -1;
    TimePoint start{};
    TimePoint end{};
    std::uint64_t instructions = 0;
    std::uint64_t cycles = 0;
    std::uint64_t enabled_ns = 0;
    std::uint64_t running_ns = 0;
    PcmStatus status;
};

class PcmBackend {
public:
    virtual ~PcmBackend() = default;
    virtual PcmStatus start() = 0;
    virtual std::vector<PcmReading> sample() = 0;
    virtual void stop() = 0;
    virtual std::string version() const = 0;
};

std::unique_ptr<PcmBackend> make_pcm_backend();

}