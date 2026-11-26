#include "collectors/pcm.h"

#include "cpucounters.h"
#include "version.h"

#include <cerrno>
#include <cstdlib>
#include <cstring>
#include <string>
#include <unistd.h>

namespace analyzer {
namespace {

class CorePcm final : public PcmBackend {
public:
    ~CorePcm() override { stop(); }

    PcmStatus start() override {
        const char *no_msr = std::getenv("PCM_NO_MSR");
        if (no_msr && std::string(no_msr) == "1")
            return {"unsupported", "PCM_NO_MSR=1 is incompatible with the restricted backend"};
        const auto cpus = read_cpu("/");
        if (!cpus.error.empty()) return {"read_error", "CPU discovery: " + cpus.error};
        for (const auto &[id, counters] : cpus.cpus) {
            (void)counters;
            const auto path = "/dev/cpu/" + std::to_string(id) + "/msr";
            if (access(path.c_str(), R_OK) != 0)
                return {errno == EACCES || errno == EPERM ? "permission_denied" : "unavailable",
                        path + ": " + std::strerror(errno)};
        }
        if (!pcm::PCM::enableAnalyzerCoreOnlyMode())
            return {"conflict", "PCM was already initialized in this process"};
        pcm_ = pcm::PCM::getInstance();
        if (!pcm_ || !pcm_->good()) return {"unavailable", "PCM initialization failed"};
        pcm::EventSelectRegister unused{};
        pcm::PCM::ExtendedCustomCoreEventDescription events;
        events.gpCounterCfg = &unused;
        events.nGPCounters = 0;
        events.defaultUncoreProgramming = false;
        program_attempted_ = true;
        const auto result = pcm_->program(pcm::PCM::EXT_CUSTOM_CORE_EVENTS, &events, true);
        if (result != pcm::PCM::Success) {
            const int error = pcm::PCM::analyzerPerfFailure();
            stop();
            const std::string status = result == pcm::PCM::PMUBusy || error == EBUSY ? "conflict" :
                error == EACCES || error == EPERM ? "permission_denied" :
                error == EINVAL || error == EOPNOTSUPP ? "unsupported" : "unavailable";
            return {status, "PCM perf programming failed (code " + std::to_string(result) + ")" +
                            (error ? ": " + std::string(std::strerror(error)) : "; see stderr")};
        }
        for (const auto &[id, counters] : cpus.cpus) {
            (void)counters;
            if (id >= static_cast<int>(pcm_->getNumCores()) || !pcm_->isCoreOnline(id)) {
                stop();
                return {"unavailable", "PCM and Linux online CPU topology differ"};
            }
            cpus_.push_back(id);
        }
        return {"available", ""};
    }

    std::vector<PcmReading> sample() override {
        std::vector<PcmReading> result;
        for (const int cpu : cpus_) {
            PcmReading reading;
            reading.cpu = cpu;
            reading.start = now();
            pcm::uint64 instructions = 0, cycles = 0, enabled = 0, running = 0;
            const auto status = pcm_->readAnalyzerCoreCounters(cpu, instructions, cycles, enabled, running);
            reading.end = now();
            if (status) reading.status = {"read_error", std::strerror(status)};
            else {
                reading.instructions = instructions;
                reading.cycles = cycles;
                reading.enabled_ns = enabled;
                reading.running_ns = running;
                reading.status = {"available", ""};
            }
            result.push_back(reading);
        }
        return result;
    }

    void stop() override {
        if (program_attempted_ && pcm_) pcm_->cleanup(true);
        program_attempted_ = false;
    }

    std::string version() const override { return std::string(PCM_VERSION) + "+analyzer-core-only-v1"; }

private:
    pcm::PCM *pcm_ = nullptr;
    bool program_attempted_ = false;
    std::vector<int> cpus_;
};

}

std::unique_ptr<PcmBackend> make_pcm_backend() {
    return std::make_unique<CorePcm>();
}

}