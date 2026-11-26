#include "msr.h"

#include <cassert>
#include <cerrno>
#include <cstdlib>
#include <cstring>
#include <fcntl.h>
#include <sys/types.h>

namespace {
bool opened = false;
void validate_open(const char *path, int flags) {
    assert(std::strcmp(path, "/dev/cpu/0/msr") == 0);
    assert((flags & O_ACCMODE) == O_RDONLY);
    assert((flags & O_NOFOLLOW) != 0);
    opened = true;
}
}

extern "C" int __real___open_2(const char *path, int flags);
extern "C" int __real_open(const char *path, int flags, ...);
extern "C" int __wrap___open_2(const char *path, int flags) {
    validate_open(path, flags);
    return __real___open_2("/dev/null", O_RDONLY);
}
extern "C" int __wrap_open(const char *path, int flags, ...) {
    validate_open(path, flags);
    return __real_open("/dev/null", O_RDONLY);
}

int main() {
    assert(unsetenv("PCM_NO_MSR") == 0);
    pcm::MsrHandle handle(0, true);
    assert(opened);
    errno = 0;
    assert(handle.write(0x611, 0) == -1 && errno == EBADF);
}