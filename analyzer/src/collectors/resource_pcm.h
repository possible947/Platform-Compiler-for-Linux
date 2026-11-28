#pragma once

#include "resource/resource_types.h"

#include <chrono>
#include <string>

namespace analyzer {

struct ResourcePcmStatus {
    std::string status;
    std::string error;
};

class ResourcePcmCollector {
public:
    ResourcePcmStatus start();
    ResourceRecord measure(const std::string &scenario, double duration_seconds,
                           const WorkloadMetadata &metadata);
    void stop();

private:
    bool started_ = false;
};

}
