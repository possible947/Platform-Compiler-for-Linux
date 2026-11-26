#pragma once

#include "collectors/pcm.h"

#include <filesystem>
#include <memory>
#include <string>

namespace analyzer {

int record(const std::string &config_path, const std::string &output_path,
		   const std::filesystem::path &source_root = "/",
		   std::unique_ptr<PcmBackend> pcm_backend = {});
int probe();
int clock_snapshot();

}