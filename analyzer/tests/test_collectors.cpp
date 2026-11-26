#include "collectors/linux.h"

#include <cassert>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <string>
#include <unistd.h>

int main() {
    char name[] = "/tmp/analyzer-collector-XXXXXX";
    const auto *created = mkdtemp(name);
    assert(created);
    const std::filesystem::path root(created);
    std::filesystem::create_directories(root / "proc");
    std::filesystem::create_directories(root / "sys/class/powercap/intel-rapl:0");
    std::ofstream(root / "proc/stat") << "cpu 1 2 3 4 5 6 7 8\ncpu0 1 2 3 4 5 6 7 8\n";
    std::ofstream(root / "sys/class/powercap/intel-rapl:0/name") << "package-0\n";
    std::ofstream(root / "sys/class/powercap/intel-rapl:0/energy_uj") << "123\n";
    std::ofstream(root / "sys/class/powercap/intel-rapl:0/max_energy_range_uj") << "1000\n";
    const auto cpu = analyzer::read_cpu(root);
    assert(cpu.error.empty() && cpu.cpus.at(0)[7] == 8);
    std::ofstream(root / "proc/stat") << "cpu0 -1 2 3 4 5 6 7 8\n";
    assert(!analyzer::read_cpu(root).error.empty());
    std::string error;
    const auto domains = analyzer::discover_rapl(root, error);
    assert(error.empty() && domains.size() == 1 && domains[0].package == "package-0");
    const auto sample = analyzer::read_rapl(domains[0]);
    assert(sample.error.empty() && sample.energy == 123 && sample.range == 1000);
    std::filesystem::remove(root / "sys/class/powercap/intel-rapl:0/max_energy_range_uj");
    const auto missing_range = analyzer::read_rapl(domains[0]);
    assert(missing_range.error.empty() && missing_range.energy == 123 && !missing_range.range_error.empty());
    std::ofstream(root / "sys/class/powercap/intel-rapl:0/energy_uj") << "bad\n";
    assert(!analyzer::read_rapl(domains[0]).error.empty());
    std::filesystem::remove_all(root);
}