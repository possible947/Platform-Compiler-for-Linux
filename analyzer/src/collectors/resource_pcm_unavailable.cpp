#include "collectors/resource_pcm.h"

namespace analyzer {

ResourcePcmStatus ResourcePcmCollector::start() {
    return {"unsupported", "analyzer built without PCM library"};
}

ResourceRecord ResourcePcmCollector::measure(const std::string &scenario, double,
                                               const WorkloadMetadata &metadata) {
    ResourceRecord record;
    record.schema_version = "3";
    record.scenario = scenario;
    record.workload_metadata = metadata;
    record.limitations.push_back("analyzer built without PCM library");
    return record;
}

void ResourcePcmCollector::stop() {
}

}
