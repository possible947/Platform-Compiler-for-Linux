#pragma once

#include <string>

namespace analyzer {

struct ResourceRecord;
void write_resource_artifact(const std::string &path, const ResourceRecord &record);
int resource_record(const std::string &scenario,
                    double duration_seconds,
                    const std::string &output_path,
                    const std::string &metadata_path);

}
