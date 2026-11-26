#include <cassert>
#include <cerrno>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <signal.h>
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
    char name[] = "/tmp/analyzer-phi4-test-XXXXXX";
    const auto *created = mkdtemp(name);
    assert(created);
    const std::filesystem::path root(created);
    const auto engine = root / "engine";
    const auto model = root / "model.gguf";
    const auto output = root / "output";
    fixture(engine, R"(#!/usr/bin/env bash
if [[ "$1" == --version ]]; then printf 'fixture version\n'; exit 0; fi
found=0
while (($#)); do if [[ "$1" == --log-verbosity && "${2:-}" == 3 ]]; then found=1; fi; shift; done
if (( !found )); then printf '[ Prompt: 56.5 t/s | Generation: 3.9 t/s ]\n'; exit 0; fi
printf '0.42.721.838 I slot print_timing: id  0 | task 0 |        eval time =   1270.00 ms /   127 tokens (   10.00 ms per token,   100.00 tokens per second)\n' >&2
)" );
    fixture(model, "fixture model\n");
    fixture(root / "bin/sudo", R"(#!/usr/bin/env bash
if [[ "$1" == -v ]]; then exit 0; fi
if [[ "$1" == -n ]]; then shift; fi
if [[ "$1" == -- ]]; then shift; fi
exec "$@"
)" );
    fixture(root / "bin/lscpu", R"(#!/usr/bin/env bash
if [[ "${1:-}" == --parse=CPU ]]; then printf '# CPU\n0\n'; else printf 'fixture CPU\n'; fi
)" );
    const auto child = fork();
    assert(child >= 0);
    if (child == 0) {
        const auto path = (root / "bin").string() + ":" + std::getenv("PATH");
        setenv("PATH", path.c_str(), 1);
        execl("/bin/bash", "bash", PHI4_SCENARIO_PATH, "--engine", engine.c_str(), "--model", model.c_str(),
              "--analyzer", MOCK_ANALYZER_PATH, "--output-base", output.c_str(), "--pairs", "2", static_cast<char *>(nullptr));
        _exit(127);
    }
    int status = 0;
    assert(waitpid(child, &status, 0) == child);
    assert(WIFEXITED(status) && WEXITSTATUS(status) == 0);
    unsigned results = 0;
    for (const auto &entry : std::filesystem::directory_iterator(output)) {
        assert(std::filesystem::exists(entry.path() / "comparison.json"));
        assert(std::filesystem::exists(entry.path() / "pair-01/with/analyzer-manifest.json"));
        assert(std::filesystem::exists(entry.path() / "pair-01/without/workload-result.json"));
        assert(std::filesystem::exists(entry.path() / "pair-02/with/analyzer-manifest.json"));
        assert(std::filesystem::exists(entry.path() / "pair-02/without/workload-result.json"));
        std::ifstream comparison(entry.path() / "comparison.json");
        const std::string contents((std::istreambuf_iterator<char>(comparison)), std::istreambuf_iterator<char>());
        assert(contents.find("\"pair\": 2") != std::string::npos);
        assert(contents.find("\"mean_change_percent\": 0") != std::string::npos);
        assert(contents.find("\"sample_stddev_change_percent\": 0") != std::string::npos);
        ++results;
    }
    assert(results == 1);

    const auto counter = root / "engine-count";
    fixture(engine, std::string(R"(#!/usr/bin/env bash
if [[ "$1" == --version ]]; then printf 'fixture version\n'; exit 0; fi
counter=')") + counter.string() + R"('
count=0
if [[ -f "$counter" ]]; then read -r count < "$counter"; fi
count=$((count + 1))
printf '%s\n' "$count" > "$counter"
if ((count == 3)); then exit 7; fi
printf 'slot print_timing: id  0 | task 0 |        eval time =   1270.00 ms /   127 tokens (   10.00 ms per token,   100.00 tokens per second)\n' >&2
)" );
    const auto failure_output = root / "failure-output";
    const auto failing_child = fork();
    assert(failing_child >= 0);
    if (failing_child == 0) {
        const auto path = (root / "bin").string() + ":" + std::getenv("PATH");
        setenv("PATH", path.c_str(), 1);
        execl("/bin/bash", "bash", PHI4_SCENARIO_PATH, "--engine", engine.c_str(), "--model", model.c_str(),
              "--analyzer", MOCK_ANALYZER_PATH, "--output-base", failure_output.c_str(), "--pairs", "1", static_cast<char *>(nullptr));
        _exit(127);
    }
    assert(waitpid(failing_child, &status, 0) == failing_child);
    assert(WIFEXITED(status) && WEXITSTATUS(status) == 1);
    unsigned failed_runs = 0;
    for (const auto &entry : std::filesystem::directory_iterator(failure_output)) {
        assert(!std::filesystem::exists(entry.path() / "comparison.json"));
        assert(std::filesystem::exists(entry.path() / "pair-01/with/analyzer/manifest.json"));
        std::ifstream pid_file(entry.path() / "pair-01/with/analyzer.pid");
        pid_t recorder_pid = 0;
        assert(pid_file >> recorder_pid);
        errno = 0;
        assert(kill(recorder_pid, 0) == -1 && errno == ESRCH);
        ++failed_runs;
    }
    assert(failed_runs == 1);

    fixture(engine, R"(#!/usr/bin/env bash
if [[ "$1" == --version ]]; then printf 'fixture version\n'; exit 0; fi
printf 'slot print_timing: id  0 | task 0 |        eval time =   1270.00 ms /   127 tokens (   10.00 ms per token,   100.00 tokens per second)\n' >&2
)" );
    const auto unavailable_output = root / "unavailable-output";
    const auto unavailable_child = fork();
    assert(unavailable_child >= 0);
    if (unavailable_child == 0) {
        const auto path = (root / "bin").string() + ":" + std::getenv("PATH");
        setenv("PATH", path.c_str(), 1);
        setenv("MOCK_PCM_FAILURE", "1", 1);
        execl("/bin/bash", "bash", PHI4_SCENARIO_PATH, "--engine", engine.c_str(), "--model", model.c_str(),
              "--analyzer", MOCK_ANALYZER_PATH, "--output-base", unavailable_output.c_str(), "--pairs", "1", static_cast<char *>(nullptr));
        _exit(127);
    }
    assert(waitpid(unavailable_child, &status, 0) == unavailable_child);
    assert(WIFEXITED(status) && WEXITSTATUS(status) == 1);
    unsigned unavailable_runs = 0;
    for (const auto &entry : std::filesystem::directory_iterator(unavailable_output)) {
        assert(!std::filesystem::exists(entry.path() / "comparison.json"));
        assert(!std::filesystem::exists(entry.path() / "pair-01/with/workload-start.json"));
        ++unavailable_runs;
    }
    assert(unavailable_runs == 1);
    std::filesystem::remove_all(root);
}