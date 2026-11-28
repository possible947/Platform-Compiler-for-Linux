#pragma once

#include "resource/resource_types.h"

#include <chrono>
#include <functional>
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
    ResourceRecord measure_until(const std::string &scenario,
                                 double iio_sampling_seconds,
                                 const WorkloadMetadata &metadata,
                                 const std::function<bool()> &keep_running,
                                 const std::function<void()> &on_window,
                                 const std::function<void()> &on_measurement_start = {});
    void stop();

private:
    bool started_ = false;
};

}
