#include "collectors/linux.h"
#include "msr.h"
#include "version.h"

#include <cpuid.h>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <iostream>
#include <map>
#include <memory>
#include <stdexcept>
#include <string>
#include <time.h>
#include <unistd.h>

namespace {

void check_cpu() {
    unsigned eax = 0, ebx = 0, ecx = 0, edx = 0;
    if (!__get_cpuid(0, &eax, &ebx, &ecx, &edx) || ebx != 0x756e6547 ||
        edx != 0x49656e69 || ecx != 0x6c65746e ||
        !__get_cpuid(1, &eax, &ebx, &ecx, &edx))
        throw std::runtime_error("Intel CPUID unavailable");
    const unsigned family = (eax >> 8) & 0xf;
    const unsigned model = ((eax >> 4) & 0xf) | (((eax >> 16) & 0xf) << 4);
    if (family != 6 || model != 85)
        throw std::runtime_error("this diagnostic supports only Intel family 6 model 85");
}

std::map<int, int> representatives() {
    const auto cpu = analyzer::read_cpu("/");
    if (!cpu.error.empty()) throw std::runtime_error("cannot read online CPUs: " + cpu.error);
    std::map<int, int> result;
    for (const auto &[id, counters] : cpu.cpus) {
        (void)counters;
        const auto path = "/sys/devices/system/cpu/cpu" + std::to_string(id) + "/topology/physical_package_id";
        std::ifstream input(path);
        int package = -1;
        if (!(input >> package) || package < 0) throw std::runtime_error("cannot read " + path);
        result.emplace(package, id);
    }
    if (result.empty()) throw std::runtime_error("no online packages");
    return result;
}

pcm::uint64 read_register(pcm::MsrHandle &handle, pcm::uint64 reg) {
    pcm::uint64 value = 0;
    errno = 0;
    if (handle.read(reg, &value) != static_cast<int>(sizeof(value)))
        throw std::runtime_error("MSR read failed for CPU " + std::to_string(handle.getCoreId()) +
                                 " register " + std::to_string(reg) + ": " + std::strerror(errno ? errno : EIO));
    return value;
}

void sample(int sample_index, const std::map<int, int> &cpus,
            std::map<int, std::unique_ptr<pcm::MsrHandle>> &handles,
            const std::vector<analyzer::RaplDomain> &domains) {
    for (const auto &[package, cpu] : cpus) {
        auto &handle = *handles.at(package);
        for (const auto reg : {pcm::MSR_RAPL_POWER_UNIT, pcm::MSR_PKG_ENERGY_STATUS, pcm::MSR_DRAM_ENERGY_STATUS}) {
            const auto value = read_register(handle, reg);
            const auto timestamp = analyzer::now();
            std::cout << "msr\t" << sample_index << '\t' << package << '\t' << cpu << '\t'
                      << timestamp.monotonic_ns << '\t' << timestamp.realtime_ns << "\t0x"
                      << std::hex << reg << "\t0x" << value << std::dec << '\n';
        }
        const auto package_name = "package-" + std::to_string(package);
        for (const auto &domain : domains) {
            if (domain.package != package_name || (domain.name != package_name && domain.name != "dram")) continue;
            const auto value = analyzer::read_rapl(domain);
            if (!value.error.empty()) {
                std::cerr << "powercap " << domain.id << ": " << value.error << '\n';
                continue;
            }
            std::cout << "powercap\t" << sample_index << '\t' << package << '\t' << cpu << '\t'
                      << value.time.monotonic_ns << '\t' << value.time.realtime_ns << '\t'
                      << domain.id << '\t' << value.energy << '\n';
        }
    }
    std::cout.flush();
    if (!std::cout) throw std::runtime_error("output write failed");
}

}

int main(int argc, char **argv) {
    if (argc == 2 && std::string(argv[1]) == "--help") {
        std::cout << "Usage: pcm-msr-check\nReads MSR 0x606, 0x611 and 0x619 twice through PCM on Intel family 6 model 85.\n"
                     "The tool opens MSR read-only; it does not initialize PCM or program PMUs.\n";
        return 0;
    }
    if (argc != 1) {
        std::cerr << "Usage: pcm-msr-check [--help]\n";
        return 1;
    }
    try {
        check_cpu();
        if (unsetenv("PCM_NO_MSR") != 0) throw std::runtime_error("cannot clear PCM_NO_MSR");
        const auto cpus = representatives();
        std::map<int, std::unique_ptr<pcm::MsrHandle>> handles;
        for (const auto &[package, cpu] : cpus) {
            const auto path = "/dev/cpu/" + std::to_string(cpu) + "/msr";
            if (access(path.c_str(), R_OK) != 0)
                throw std::runtime_error("cannot read " + path + ": " + std::strerror(errno));
            handles.emplace(package, std::make_unique<pcm::MsrHandle>(static_cast<pcm::uint32>(cpu), true));
        }
        std::string error;
        const auto domains = analyzer::discover_rapl("/", error);
        if (!error.empty()) std::cerr << "powercap discovery: " << error << '\n';
        std::cout << "# PCM " << PCM_VERSION << "\n# type\tsample\tpackage\tcpu\tmonotonic_ns\trealtime_ns\tregister_or_domain\tvalue\n";
        sample(0, cpus, handles, domains);
        timespec interval{1, 0};
        while (nanosleep(&interval, &interval) != 0) {
            if (errno != EINTR) throw std::runtime_error("nanosleep failed");
        }
        sample(1, cpus, handles, domains);
        return 0;
    } catch (const std::exception &error) {
        std::cerr << "pcm-msr-check: " << error.what() << '\n';
        return 1;
    }
}