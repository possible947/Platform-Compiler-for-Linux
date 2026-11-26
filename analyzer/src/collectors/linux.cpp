#include "collectors/linux.h"

#include <cerrno>
#include <cstring>
#include <fstream>
#include <sstream>
#include <stdexcept>
#include <time.h>

namespace analyzer {
namespace {

std::string read_text(const std::filesystem::path &path, std::string &error) {
    errno = 0;
    std::ifstream input(path);
    if (!input) {
        error = std::strerror(errno ? errno : EIO);
        return {};
    }
    std::string line;
    if (!std::getline(input, line)) error = "empty or unreadable file";
    return line;
}

bool read_unsigned(const std::filesystem::path &path, std::uint64_t &value,
                   std::string &error) {
    const auto text = read_text(path, error);
    if (!error.empty()) return false;
    if (text.empty() || text.find_first_not_of("0123456789") != std::string::npos) {
        error = "invalid unsigned integer";
        return false;
    }
    try {
        value = std::stoull(text);
    } catch (const std::exception &) {
        error = "unsigned integer out of range";
        return false;
    }
    return true;
}

}

TimePoint now() {
    timespec monotonic{}, realtime{};
    if (clock_gettime(CLOCK_MONOTONIC, &monotonic) || clock_gettime(CLOCK_REALTIME, &realtime))
        throw std::runtime_error("clock_gettime failed");
    return {static_cast<std::uint64_t>(monotonic.tv_sec) * 1000000000ULL + monotonic.tv_nsec,
            static_cast<std::uint64_t>(realtime.tv_sec) * 1000000000ULL + realtime.tv_nsec};
}

CpuSample read_cpu(const std::filesystem::path &root) {
    CpuSample sample{};
    errno = 0;
    std::ifstream input(root / "proc/stat");
    if (!input) {
        sample.error = std::strerror(errno ? errno : EIO);
        sample.time = now();
        return sample;
    }
    std::string line;
    while (std::getline(input, line)) {
        std::istringstream parser(line);
        std::string label;
        parser >> label;
        if (label.size() <= 3 || label.compare(0, 3, "cpu") != 0 ||
            label.find_first_not_of("0123456789", 3) != std::string::npos) continue;
        CpuCounters counters{};
        for (auto &counter : counters) {
            std::string token;
            if (!(parser >> token) || token.find_first_not_of("0123456789") != std::string::npos) {
                sample.error = "invalid CPU counters";
                sample.cpus.clear();
                sample.time = now();
                return sample;
            }
            try {
                counter = std::stoull(token);
            } catch (const std::exception &) {
                sample.error = "CPU counter out of range";
                sample.cpus.clear();
                sample.time = now();
                return sample;
            }
        }
        try {
            const auto id = std::stoi(label.substr(3));
            if (!sample.cpus.emplace(id, counters).second) throw std::invalid_argument("duplicate");
        } catch (const std::exception &) {
            sample.error = "invalid or duplicate CPU id";
            sample.cpus.clear();
            sample.time = now();
            return sample;
        }
    }
    if (input.bad() || sample.cpus.empty()) sample.error = "no readable CPU counters";
    sample.time = now();
    return sample;
}

std::vector<RaplDomain> discover_rapl(const std::filesystem::path &root, std::string &error) {
    std::vector<RaplDomain> domains;
    std::error_code ec;
    const auto base = root / "sys/class/powercap";
    std::filesystem::directory_iterator iterator(base, ec), end;
    if (ec) {
        error = ec.message();
        return domains;
    }
    for (; iterator != end; iterator.increment(ec)) {
        if (ec) break;
        const auto id = iterator->path().filename().string();
        if (id.rfind("intel-rapl:", 0) != 0) continue;
        std::string name_error;
        const auto name = read_text(iterator->path() / "name", name_error);
        const auto delimiter = id.find(':', 11);
        const auto package_id = id.substr(0, delimiter);
        std::string package_error;
        const auto package = read_text(base / package_id / "name", package_error);
        domains.push_back({iterator->path(), id, name, package});
    }
    if (ec) error = ec.message();
    if (domains.empty() && error.empty()) error = "no RAPL domains";
    return domains;
}

RaplSample read_rapl(const RaplDomain &domain) {
    RaplSample sample{};
    sample.domain = domain;
    if (domain.name.empty() || domain.package.empty()) {
        sample.error = "domain or package name unavailable";
    } else if (read_unsigned(domain.path / "energy_uj", sample.energy, sample.error)) {
        sample.time = now();
        read_unsigned(domain.path / "max_energy_range_uj", sample.range, sample.range_error);
    }
    if (!sample.time.monotonic_ns) sample.time = now();
    return sample;
}

}