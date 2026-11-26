#include "cpucounters.h"

#include <cassert>
#include <cerrno>
#include <cstdlib>

int main() {
    assert(setenv("PCM_QUIET", "1", 1) == 0);
    assert(unsetenv("PCM_NO_MSR") == 0);
    assert(pcm::PCM::enableAnalyzerCoreOnlyMode());
    auto *monitor = pcm::PCM::getInstance();
    assert(monitor);
    assert(!pcm::PCM::enableAnalyzerCoreOnlyMode());
    assert(monitor->program(pcm::PCM::DEFAULT_EVENTS, nullptr, true) == pcm::PCM::UnknownError);
    pcm::PCM::ExtendedCustomCoreEventDescription events;
    assert(monitor->program(pcm::PCM::EXT_CUSTOM_CORE_EVENTS, &events, true) == pcm::PCM::UnknownError);
    pcm::EventSelectRegister placeholder{};
    events.gpCounterCfg = &placeholder;
    events.defaultUncoreProgramming = false;
    events.OffcoreResponseMsrValue[0] = 1;
    assert(monitor->program(pcm::PCM::EXT_CUSTOM_CORE_EVENTS, &events, true) == pcm::PCM::UnknownError);
    pcm::uint64 instructions = 0, cycles = 0, enabled = 0, running = 0;
    assert(monitor->readAnalyzerCoreCounters(0, instructions, cycles, enabled, running) == EINVAL);
    pcm::uint64 data[] = {3, 100, 90, 1000, 2000, 3000};
    assert(pcm::PCM::decodeAnalyzerPerfGroup(data, 6, instructions, cycles, enabled, running) == 0);
    assert(instructions == 1000 && cycles == 2000 && enabled == 100 && running == 90);
    assert(pcm::PCM::decodeAnalyzerPerfGroup(data, 5, instructions, cycles, enabled, running) == EIO);
    data[2] = 101;
    assert(pcm::PCM::decodeAnalyzerPerfGroup(data, 6, instructions, cycles, enabled, running) == EIO);
    data[2] = 90;
    data[0] = 2;
    assert(pcm::PCM::decodeAnalyzerPerfGroup(data, 6, instructions, cycles, enabled, running) == EIO);
    monitor->cleanup(true);
}