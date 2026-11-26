#include "collectors/pcm.h"

#include <cassert>
#include <cerrno>
#include <cstdarg>
#include <cstring>
#include <fcntl.h>
#include <linux/perf_event.h>
#include <map>
#include <mutex>
#include <set>
#include <string>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <unistd.h>

namespace {

std::mutex guard;
std::set<int> msr_fds;
std::set<int> perf_fds;
std::map<int, unsigned> leaders;
int fail_perf = 0;
bool fail_read = false;
int attempted_writes = 0;

bool is_msr(const char *path) {
    const std::string value(path);
    return value.rfind("/dev/cpu/", 0) == 0 && value.size() >= 4 && value.substr(value.size() - 4) == "/msr";
}

int mock_msr(int flags) {
    assert((flags & O_ACCMODE) == O_RDONLY);
    assert(flags & O_NOFOLLOW);
    const int descriptor = open("/dev/null", O_RDONLY);
    assert(descriptor >= 0);
    std::lock_guard<std::mutex> lock(guard);
    msr_fds.insert(descriptor);
    return descriptor;
}

}

extern "C" int __real_access(const char *, int);
extern "C" int __wrap_access(const char *path, int mode) {
    return is_msr(path) ? 0 : __real_access(path, mode);
}

extern "C" int __real_open(const char *, int, ...);
extern "C" int __wrap_open(const char *path, int flags, ...) {
    if (is_msr(path)) return mock_msr(flags);
    if (flags & O_CREAT) {
        va_list args;
        va_start(args, flags);
        const auto mode = va_arg(args, int);
        va_end(args);
        return __real_open(path, flags, mode);
    }
    return __real_open(path, flags);
}

extern "C" int __real___open_2(const char *, int);
extern "C" int __wrap___open_2(const char *path, int flags) {
    return is_msr(path) ? mock_msr(flags) : __real___open_2(path, flags);
}

extern "C" ssize_t __real_pread(int, void *, size_t, off_t);
extern "C" ssize_t __wrap_pread(int descriptor, void *buffer, size_t count, off_t offset) {
    {
        std::lock_guard<std::mutex> lock(guard);
        if (msr_fds.count(descriptor)) {
            assert(count == sizeof(std::uint64_t));
            std::memset(buffer, 0, count);
            return static_cast<ssize_t>(count);
        }
    }
    return __real_pread(descriptor, buffer, count, offset);
}

extern "C" ssize_t __wrap_pwrite(int, const void *, size_t, off_t) {
    std::lock_guard<std::mutex> lock(guard);
    ++attempted_writes;
    errno = EPERM;
    return -1;
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
    assert(attr->type == PERF_TYPE_HARDWARE && pid == -1 && cpu >= 0 && flags == 0);
    assert(attr->read_format == (PERF_FORMAT_GROUP | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING));
    std::lock_guard<std::mutex> lock(guard);
    if (fail_perf && !perf_fds.empty()) {
        errno = fail_perf == 1 ? EACCES : EBUSY;
        return -1;
    }
    const int descriptor = __real_open("/dev/null", O_RDONLY);
    assert(descriptor > 0);
    perf_fds.insert(descriptor);
    if (group == -1) leaders.emplace(descriptor, 0);
    else assert(leaders.count(group));
    return descriptor;
}

extern "C" ssize_t __real_read(int, void *, size_t);
extern "C" ssize_t __wrap_read(int descriptor, void *buffer, size_t count) {
    {
        std::lock_guard<std::mutex> lock(guard);
        auto found = leaders.find(descriptor);
        if (found != leaders.end()) {
            if (fail_read) { errno = EIO; return -1; }
            assert(count == 6 * sizeof(std::uint64_t));
            const auto sequence = ++found->second;
            auto *data = static_cast<std::uint64_t *>(buffer);
            data[0] = 3;
            data[1] = sequence * 1000;
            data[2] = sequence * 1000;
            data[3] = sequence * 100;
            data[4] = sequence * 200;
            data[5] = sequence * 300;
            return static_cast<ssize_t>(count);
        }
    }
    return __real_read(descriptor, buffer, count);
}

int main() {
    for (int failure = 0; failure < 3; ++failure) {
        const auto child = fork();
        assert(child >= 0);
        if (child == 0) {
            unsetenv("PCM_NO_MSR");
            unsetenv("PCM_NO_PERF");
            setenv("PCM_QUIET", "1", 1);
            fail_perf = failure;
            auto backend = analyzer::make_pcm_backend();
            const auto status = backend->start();
            if (failure) {
                assert(status.status == (failure == 1 ? "permission_denied" : "conflict"));
                assert(!perf_fds.empty());
            } else {
                assert(status.status == "available");
                assert(!leaders.empty());
                const auto before = backend->sample();
                const auto after = backend->sample();
                assert(!before.empty() && before.size() == after.size());
                for (std::size_t index = 0; index < before.size(); ++index) {
                    assert(before[index].status.status == "available" && after[index].status.status == "available");
                    assert(after[index].instructions - before[index].instructions == 100);
                    assert(after[index].cycles - before[index].cycles == 200);
                    assert(after[index].enabled_ns - before[index].enabled_ns == 1000);
                    assert(after[index].running_ns - before[index].running_ns == 1000);
                }
                fail_read = true;
                const auto failed = backend->sample();
                assert(!failed.empty() && failed.front().status.status == "read_error");
            }
            backend->stop();
            assert(attempted_writes == 0);
            for (const int descriptor : perf_fds) {
                errno = 0;
                assert(fcntl(descriptor, F_GETFD) == -1 && errno == EBADF);
            }
            _exit(0);
        }
        int status = 0;
        assert(waitpid(child, &status, 0) == child);
        assert(WIFEXITED(status) && WEXITSTATUS(status) == 0);
    }
}