#include "session/session.h"

#include <systemd/sd-json.h>

#include <cassert>
#include <csignal>
#include <filesystem>
#include <fstream>
#include <stdexcept>
#include <string>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>

namespace {

class FakePcm final : public analyzer::PcmBackend {
public:
    FakePcm(std::string behavior, std::filesystem::path marker)
        : behavior_(std::move(behavior)), marker_(std::move(marker)) {}
    ~FakePcm() override { stop(); }
    analyzer::PcmStatus start() override {
        if (behavior_ == "denied") return {"permission_denied", "fixture denied"};
        if (behavior_ == "conflict") return {"conflict", "fixture busy"};
        return {"available", ""};
    }
    std::vector<analyzer::PcmReading> sample() override {
        ++count_;
        if (behavior_ == "exception") throw std::runtime_error("fixture read failed");
        analyzer::PcmReading reading;
        reading.cpu = 0;
        reading.start = analyzer::now();
        reading.end = analyzer::now();
        if (behavior_ == "read_error" && count_ == 2) {
            reading.status = {"read_error", "fixture read failed"};
            return {reading};
        }
        reading.instructions = count_ * 100;
        reading.cycles = count_ * 200;
        reading.enabled_ns = count_ * 100000000;
        reading.running_ns = behavior_ == "not_running" ? 0 :
            count_ * (behavior_ == "multiplexed" ? 50000000 : 100000000);
        if (behavior_ == "regression" && count_ == 2) reading.instructions = 0;
        reading.status = {"available", ""};
        return {reading};
    }
    void stop() override {
        std::ofstream output(marker_);
        output << "stopped";
    }
    std::string version() const override { return "fixture-pcm"; }
private:
    std::string behavior_;
    std::filesystem::path marker_;
    std::uint64_t count_ = 0;
};

void write_file(const std::filesystem::path &path, const std::string &data) {
    std::filesystem::create_directories(path.parent_path());
    std::ofstream output(path);
    output << data;
    assert(output.good());
}

std::string manifest_status(const std::filesystem::path &path) {
    sd_json_variant *value = nullptr;
    assert(sd_json_parse_file(nullptr, path.c_str(), SD_JSON_PARSE_MUST_BE_OBJECT, &value, nullptr, nullptr) >= 0);
    auto *entry = sd_json_variant_by_key(value, "status");
    assert(entry && sd_json_variant_is_string(entry));
    const std::string result(sd_json_variant_string(entry));
    sd_json_variant_unref(value);
    return result;
}

int wait_for(pid_t child) {
    int result = 0;
    assert(waitpid(child, &result, 0) == child);
    assert(WIFEXITED(result));
    return WEXITSTATUS(result);
}

pid_t launch(const std::filesystem::path &config, const std::filesystem::path &output,
             const std::filesystem::path &root, bool limit_output = false,
             const std::string &pcm_behavior = "") {
    const auto child = fork();
    assert(child >= 0);
    if (child == 0) {
        if (limit_output) {
            signal(SIGXFSZ, SIG_IGN);
            const rlim_t maximum = pcm_behavior.empty() ? 16 : 256;
            rlimit limit{maximum, maximum};
            if (setrlimit(RLIMIT_FSIZE, &limit) != 0) _exit(99);
        }
        try {
            std::unique_ptr<analyzer::PcmBackend> pcm;
            if (!pcm_behavior.empty()) pcm = std::make_unique<FakePcm>(pcm_behavior, output.string() + ".stopped");
            _exit(analyzer::record(config, output, root, std::move(pcm)));
        } catch (const std::exception &) {
            _exit(1);
        }
    }
    return child;
}

}

int main() {
    char name[] = "/tmp/analyzer-session-XXXXXX";
    const auto *created = mkdtemp(name);
    assert(created);
    const std::filesystem::path root(created);
    const auto fake = root / "fake";
    const auto config = root / "config.json";
    write_file(config, R"({"run_id":"test","scenario":"IDLE","interval_ms":100,"duration_ms":200,"cpu_required":true,"rapl_required":true,"rapl_max_power_watts":100})");
    write_file(fake / "proc/stat", "cpu0 1 2 3 4 5 6 7 8\n");
    const auto domain = fake / "sys/class/powercap/intel-rapl:0";
    write_file(domain / "name", "package-0\n");
    write_file(domain / "energy_uj", "123\n");
    write_file(domain / "max_energy_range_uj", "1000000000\n");
    const auto output = root / "complete";
    assert(wait_for(launch(config, output, fake)) == 0);
    assert(manifest_status(output / "manifest.json") == "complete");
    sd_json_variant *resource_manifest = nullptr;
    assert(sd_json_parse_file(nullptr, (output / "manifest.json").c_str(), SD_JSON_PARSE_MUST_BE_OBJECT,
                              &resource_manifest, nullptr, nullptr) >= 0);
    assert(sd_json_variant_by_key(resource_manifest, "recorder_user_usec"));
    assert(sd_json_variant_by_key(resource_manifest, "recorder_system_usec"));
    assert(sd_json_variant_by_key(resource_manifest, "recorder_max_rss_kib"));
    sd_json_variant_unref(resource_manifest);
    assert(std::filesystem::exists(output / "measurements.jsonl"));
    assert(std::filesystem::exists(output / "summary.json"));
    struct stat mode{};
    assert(stat(output.c_str(), &mode) == 0 && (mode.st_mode & 0777) == 0700);
    assert(stat((output / "manifest.json").c_str(), &mode) == 0 && (mode.st_mode & 0777) == 0600);
    sd_json_variant *summary = nullptr;
    assert(sd_json_parse_file(nullptr, (output / "summary.json").c_str(), SD_JSON_PARSE_MUST_BE_OBJECT,
                              &summary, nullptr, nullptr) >= 0);
    auto *items = sd_json_variant_by_key(summary, "derived");
    assert(items && sd_json_variant_is_array(items));
    bool found_power = false;
    for (std::size_t index = 0; index < sd_json_variant_elements(items); ++index) {
        auto *item = sd_json_variant_by_index(items, index);
        auto *metric = sd_json_variant_by_key(item, "metric");
        if (metric && std::string(sd_json_variant_string(metric)) == "rapl.power") {
            found_power = true;
            assert(std::string(sd_json_variant_string(sd_json_variant_by_key(item, "status"))) == "available");
            assert(sd_json_variant_is_number(sd_json_variant_by_key(item, "value")));
            assert(sd_json_variant_by_key(item, "before_sample_index"));
            assert(sd_json_variant_by_key(item, "after_sample_index"));
        }
    }
    assert(found_power);
    sd_json_variant_unref(summary);
    assert(wait_for(launch(config, output, fake)) == 1);

    const auto invalid = root / "invalid";
    std::filesystem::remove(fake / "proc/stat");
    assert(wait_for(launch(config, invalid, fake)) == 1);
    assert(manifest_status(invalid / "manifest.json") == "failed");
    write_file(config, R"({"run_id":"partial","scenario":"IDLE","interval_ms":100,"duration_ms":200,"cpu_required":false})");
    const auto partial = root / "partial";
    assert(wait_for(launch(config, partial, fake)) == 2);
    assert(manifest_status(partial / "manifest.json") == "partial");
    write_file(fake / "proc/stat", "cpu0 1 2 3 4 5 6 7 8\n");

    const auto limited = root / "limited";
    assert(wait_for(launch(config, limited, fake, true)) == 1);
    assert(!std::filesystem::exists(limited / "manifest.json"));

    write_file(config, R"({"run_id":"signal","scenario":"CPU","interval_ms":100,"duration_ms":10000})");
    const auto interrupted = root / "interrupted";
    const auto child = launch(config, interrupted, fake);
    for (int attempt = 0; attempt < 200 && !std::filesystem::exists(interrupted / "events.jsonl"); ++attempt) usleep(10000);
    assert(std::filesystem::exists(interrupted / "events.jsonl"));
    usleep(50000);
    assert(kill(child, SIGTERM) == 0);
    assert(wait_for(child) == 143);
    assert(manifest_status(interrupted / "manifest.json") == "interrupted");

    write_file(config, R"({"run_id":"bad","scenario":"IDLE","interval_ms":100,"duration_ms":200,"unknown":1})");
    assert(wait_for(launch(config, root / "bad-config", fake)) == 1);
    assert(!std::filesystem::exists(root / "bad-config"));
    write_file(config, R"({"run_id":"bad","run_id":"duplicate","scenario":"IDLE","interval_ms":100,"duration_ms":200})");
    assert(wait_for(launch(config, root / "duplicate-config", fake)) == 1);
    assert(!std::filesystem::exists(root / "duplicate-config"));

    for (const auto &behavior : {"ok", "multiplexed", "not_running", "regression", "denied", "conflict", "read_error", "exception"}) {
        const auto pcm_output = root / (std::string("pcm-") + behavior);
        write_file(config, R"({"run_id":"pcm","scenario":"IDLE","interval_ms":100,"duration_ms":200,"pcm_enabled":true,"pcm_required":true})");
        const bool succeeds = std::string(behavior) == "ok" || std::string(behavior) == "multiplexed" ||
                      std::string(behavior) == "not_running" || std::string(behavior) == "regression";
        assert(wait_for(launch(config, pcm_output, fake, false, behavior)) == (succeeds ? 0 : 1));
        assert(manifest_status(pcm_output / "manifest.json") == (succeeds ? "complete" : "failed"));
        assert(std::filesystem::exists(pcm_output.string() + ".stopped"));
        sd_json_variant *pcm_manifest = nullptr;
        assert(sd_json_parse_file(nullptr, (pcm_output / "manifest.json").c_str(), SD_JSON_PARSE_MUST_BE_OBJECT,
                                  &pcm_manifest, nullptr, nullptr) >= 0);
        assert(sd_json_variant_unsigned(sd_json_variant_by_key(pcm_manifest, "schema_version")) == 2);
        const std::string pcm_status(sd_json_variant_string(sd_json_variant_by_key(pcm_manifest, "pcm_status")));
        if (std::string(behavior) == "denied") assert(pcm_status == "permission_denied");
        if (std::string(behavior) == "conflict") assert(pcm_status == "conflict");
        if (std::string(behavior) == "read_error" || std::string(behavior) == "exception") assert(pcm_status == "read_error");
        sd_json_variant_unref(pcm_manifest);
        if (succeeds) {
            std::ifstream observations(pcm_output / "measurements.jsonl");
            std::string observation_line;
            unsigned pcm_raw_count = 0;
            while (std::getline(observations, observation_line)) {
                sd_json_variant *raw = nullptr;
                assert(sd_json_parse(observation_line.c_str(), SD_JSON_PARSE_MUST_BE_OBJECT, &raw, nullptr, nullptr) >= 0);
                auto *source = sd_json_variant_by_key(raw, "source");
                if (source && std::string(sd_json_variant_string(source)) == "intel_pcm_perf") {
                    ++pcm_raw_count;
                    assert(sd_json_variant_by_key(raw, "value"));
                    assert(sd_json_variant_by_key(raw, "time_enabled_ns"));
                    assert(sd_json_variant_by_key(raw, "time_running_ns"));
                    assert(sd_json_variant_by_key(raw, "read_start_monotonic_ns"));
                    assert(std::string(sd_json_variant_string(sd_json_variant_by_key(raw, "source_version"))) == "fixture-pcm");
                }
                sd_json_variant_unref(raw);
            }
            assert(pcm_raw_count >= 4);
            sd_json_variant *pcm_summary = nullptr;
            assert(sd_json_parse_file(nullptr, (pcm_output / "summary.json").c_str(), SD_JSON_PARSE_MUST_BE_OBJECT,
                                      &pcm_summary, nullptr, nullptr) >= 0);
            auto *entries = sd_json_variant_by_key(pcm_summary, "derived");
            bool found = false, found_invalid = false;
            for (std::size_t index = 0; index < sd_json_variant_elements(entries); ++index) {
                auto *entry = sd_json_variant_by_index(entries, index);
                auto *metric = sd_json_variant_by_key(entry, "metric");
                if (metric && std::string(sd_json_variant_string(metric)) == "pcm.instructions.delta") {
                    found = true;
                    const std::string state(sd_json_variant_string(sd_json_variant_by_key(entry, "status")));
                    if (state == "invalid_delta") found_invalid = true;
                    if (std::string(behavior) != "regression")
                        assert(state == (std::string(behavior) == "ok" ? "available" :
                                         std::string(behavior) == "not_running" ? "not_running" : "multiplexed"));
                    auto *value = sd_json_variant_by_key(entry, "value");
                    if (state == "available") {
                        assert(value);
                        if (std::string(behavior) == "ok") assert(sd_json_variant_unsigned(value) == 100);
                    }
                    else assert(!value);
                }
            }
            assert(found);
            if (std::string(behavior) == "regression") assert(found_invalid);
            sd_json_variant_unref(pcm_summary);
        }
    }

    write_file(config, R"({"run_id":"optional","scenario":"IDLE","interval_ms":100,"duration_ms":200,"pcm_enabled":true})");
    const auto pcm_optional = root / "pcm-optional";
    assert(wait_for(launch(config, pcm_optional, fake, false, "denied")) == 2);
    assert(manifest_status(pcm_optional / "manifest.json") == "partial");
    std::ifstream optional_measurements(pcm_optional / "measurements.jsonl");
    const std::string optional_raw((std::istreambuf_iterator<char>(optional_measurements)), std::istreambuf_iterator<char>());
    assert(optional_raw.find("proc_stat") != std::string::npos);
    assert(optional_raw.find("linux_powercap") != std::string::npos);
    assert(optional_raw.find("permission_denied") != std::string::npos);

    write_file(config, R"({"run_id":"signal-pcm","scenario":"CPU","interval_ms":100,"duration_ms":10000,"pcm_enabled":true})");
    for (const int signal : {SIGINT, SIGTERM}) {
        const auto pcm_interrupted = root / ("pcm-interrupted-" + std::to_string(signal));
        const auto pcm_child = launch(config, pcm_interrupted, fake, false, "ok");
        for (int attempt = 0; attempt < 200 && !std::filesystem::exists(pcm_interrupted / "events.jsonl"); ++attempt) usleep(10000);
        assert(std::filesystem::exists(pcm_interrupted / "events.jsonl"));
        usleep(50000);
        assert(kill(pcm_child, signal) == 0);
        assert(wait_for(pcm_child) == 128 + signal);
        assert(manifest_status(pcm_interrupted / "manifest.json") == "interrupted");
        assert(std::filesystem::exists(pcm_interrupted.string() + ".stopped"));
    }
    const auto pcm_storage_failure = root / "pcm-storage-failure";
    assert(wait_for(launch(config, pcm_storage_failure, fake, true, "ok")) == 1);
    assert(!std::filesystem::exists(pcm_storage_failure / "manifest.json"));
    assert(std::filesystem::exists(pcm_storage_failure.string() + ".stopped"));
    std::filesystem::remove_all(root);
}