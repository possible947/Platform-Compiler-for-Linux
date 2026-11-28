#pragma once

#include <string>

namespace analyzer {

int resource_record(const std::string &scenario,
                    double duration_seconds,
                    const std::string &output_path,
                    const std::string &metadata_path);

}
