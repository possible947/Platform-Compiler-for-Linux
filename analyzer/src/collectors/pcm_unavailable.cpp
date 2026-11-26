#include "collectors/pcm.h"

namespace analyzer {
namespace {

class UnavailablePcm final : public PcmBackend {
public:
    PcmStatus start() override { return {"unsupported", "analyzer built without PCM"}; }
    std::vector<PcmReading> sample() override { return {}; }
    void stop() override {}
    std::string version() const override { return "not_linked"; }
};

}

std::unique_ptr<PcmBackend> make_pcm_backend() {
    return std::make_unique<UnavailablePcm>();
}

}