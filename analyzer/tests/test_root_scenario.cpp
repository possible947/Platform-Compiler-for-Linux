#include <cassert>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <string>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>

namespace {

void fixture(const std::filesystem::path &path, const std::string &contents) {
    std::filesystem::create_directories(path.parent_path());
    std::ofstream output(path);
    output << contents;
    output.close();
    assert(output.good());
    assert(chmod(path.c_str(), 0700) == 0);
}

}

int main() {
    char name[] = "/tmp/analyzer-root-scenario-XXXXXX";
    const auto *created = mkdtemp(name);
    assert(created);
    const std::filesystem::path root(created);
    const auto project = root / "project";
    const auto script = project / "analyzer/tests/root-test.sh";
    std::filesystem::create_directories(script.parent_path());
    std::filesystem::copy_file(ROOT_SCENARIO_PATH, script);
    std::filesystem::create_directories(root / "runs");
    fixture(project / "analyzer/examples/root-test.json", "{}\n");
    fixture(project / "analyzer/examples/pcm.json", "{}\n");
    fixture(project / "analyzer/build/analyzer", R"(#!/usr/bin/env bash
config=
while (($#)); do
    if [[ "$1" == --output ]]; then out=$2; fi
    if [[ "$1" == --config ]]; then config=$2; fi
    shift
done
mkdir "$out"
if [[ "$config" == */pcm.json ]]; then
printf '%s\n' '{"schema_version":2,"status":"complete","sample_count":4,"pcm_status":"available","pcm_error":false}' > "$out/manifest.json"
lscpu --parse=CPU,SOCKET --online | awk -F, '!/^#/ && NF >= 2 && !seen[$2]++ {print $1}' | while read -r cpu; do
for metric in pcm.instructions pcm.cycles; do for sample in 0 1; do
printf '{"source":"intel_pcm_perf","scope":"cpu:%s","status":"available","metric":"%s","sample_index":%s}\n' "$cpu" "$metric" "$sample"
done; done
done > "$out/measurements.jsonl"
printf '%s\n' '{"derived":[{"metric":"pcm.instructions.delta","status":"available","value":100},{"metric":"pcm.cycles.delta","status":"available","value":200}]}' > "$out/summary.json"
exit 0
fi
printf '%s\n' '{"status":"complete","sample_count":4,"cpu_error":false,"rapl_error":false}' > "$out/manifest.json"
)" );
    fixture(project / "analyzer/build/pcm-msr-check", R"fixture(#!/usr/bin/env bash
for package in 0 1; do for sample in 0 1; do for reg in 0x606 0x611 0x619; do
printf 'msr\t%s\t%s\t0\t1\t1\t%s\t0x%s\n' "$sample" "$package" "$reg" "$((sample + 1))"
done
printf 'powercap\t%s\t%s\t0\t1\t1\tdomain0\t100\n' "$sample" "$package"
printf 'powercap\t%s\t%s\t0\t1\t1\tdomain1\t100\n' "$sample" "$package"
done; done
if [[ "${MOCK_POLICY_CHANGE:-0}" == 1 ]]; then : > "$TMPDIR/policy-changed"; fi
)fixture" );
    fixture(project / "analyzer/build/pmu-perf-check", R"(#!/usr/bin/env bash
for metric in cycles instructions; do
printf '%s\t0\t0\t1\t1\t1\t1\t1\n' "$metric"
printf '%s\t1\t0\t2\t2\t2\t2\t2\n' "$metric"
done
)" );
    fixture(root / "bin/sudo", R"(#!/usr/bin/env bash
if [[ "$1" == -v ]]; then exit 0; fi
if [[ "$1" == -n ]]; then shift; fi
if [[ "$1" == -- ]]; then shift; fi
if [[ "$1" == cat && "$2" == /sys/module/msr/parameters/allow_writes ]]; then
    if [[ -e "$TMPDIR/policy-changed" ]]; then printf 'changed\n'; else printf 'default\n'; fi
    exit 0
fi
exec "$@"
)" );
        fixture(root / "bin/lscpu", R"(#!/usr/bin/env bash
if [[ "$1" == --parse=CPU,SOCKET ]]; then printf '# CPU,Socket\n0,0\n20,1\n'; else printf 'mock topology\n'; fi
)" );
        fixture(root / "bin/cat", R"(#!/usr/bin/env bash
case "$1" in
    /proc/sys/kernel/nmi_watchdog) printf '0\n' ;;
    /proc/sys/kernel/perf_event_paranoid) printf '2\n' ;;
    *) exec /usr/bin/cat "$@" ;;
esac
)" );
    for (int changed = 0; changed < 2; ++changed) {
        const auto child = fork();
        assert(child >= 0);
        if (child == 0) {
            const auto path = (root / "bin").string() + ":" + std::getenv("PATH");
            setenv("PATH", path.c_str(), 1);
            setenv("TMPDIR", (root / "runs").c_str(), 1);
            setenv("MOCK_POLICY_CHANGE", changed ? "1" : "0", 1);
            execl("/bin/bash", "bash", script.c_str(), static_cast<char *>(nullptr));
            _exit(127);
        }
        int status = 0;
        assert(waitpid(child, &status, 0) == child);
        assert(WIFEXITED(status) && WEXITSTATUS(status) == changed);
    }
    std::filesystem::remove_all(root);
}