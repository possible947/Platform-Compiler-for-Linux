#define main pmu_perf_test_main
#include "../src/cli/pmu_perf_check.cpp"
#undef main

#include <cassert>
#include <cstdarg>
#include <fcntl.h>
#include <map>
#include <sstream>

namespace {
std::map<int, std::uint64_t> descriptors;
bool fail_second = false;
int opens = 0;
}

extern "C" long __wrap_syscall(long number, ...) {
    assert(number == SYS_perf_event_open);
    va_list arguments;
    va_start(arguments, number);
    auto *attr = va_arg(arguments, perf_event_attr *);
    const int pid = va_arg(arguments, int);
    const int cpu = va_arg(arguments, int);
    const int group = va_arg(arguments, int);
    const int flags = va_arg(arguments, int);
    va_end(arguments);
    assert(attr->type == PERF_TYPE_HARDWARE && attr->exclude_hv == 1);
    assert(attr->read_format == (PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING));
    assert(pid == -1 && cpu >= 0 && group == -1 && flags == PERF_FLAG_FD_CLOEXEC);
    ++opens;
    if (fail_second && opens == 2) {
        errno = EACCES;
        return -1;
    }
    const int descriptor = open("/dev/null", O_RDONLY);
    assert(descriptor >= 0);
    descriptors.emplace(descriptor, 0);
    return descriptor;
}

extern "C" ssize_t __wrap_read(int descriptor, void *buffer, size_t count) {
    auto found = descriptors.find(descriptor);
    assert(found != descriptors.end() && count == 3 * sizeof(std::uint64_t));
    auto *values = static_cast<std::uint64_t *>(buffer);
    values[0] = ++found->second * 100;
    values[1] = found->second * 1000;
    values[2] = found->second * 900;
    return static_cast<ssize_t>(count);
}

extern "C" int __wrap_nanosleep(const timespec *, timespec *) { return 0; }

int main() {
    char name[] = "pmu-perf-check";
    char *argv[] = {name, nullptr};
    std::ostringstream output, errors;
    auto *old_out = std::cout.rdbuf(output.rdbuf());
    auto *old_err = std::cerr.rdbuf(errors.rdbuf());
    assert(pmu_perf_test_main(1, argv) == 0);
    assert(opens == 2 && descriptors.size() == 2);
    assert(output.str().find("cycles\t1\t") != std::string::npos);
    assert(output.str().find("instructions\t1\t") != std::string::npos);
    for (const auto &[descriptor, count] : descriptors) {
        assert(count == 2);
        errno = 0;
        assert(fcntl(descriptor, F_GETFD) == -1 && errno == EBADF);
    }
    descriptors.clear();
    opens = 0;
    fail_second = true;
    assert(pmu_perf_test_main(1, argv) == 1);
    assert(descriptors.size() == 1 && errors.str().find("Permission denied") != std::string::npos);
    for (const auto &[descriptor, count] : descriptors) {
        (void)count;
        errno = 0;
        assert(fcntl(descriptor, F_GETFD) == -1 && errno == EBADF);
    }
    std::cout.rdbuf(old_out);
    std::cerr.rdbuf(old_err);
}