#include "session/session.h"

#include "collectors/linux.h"
#include "collectors/pcm.h"
#include "summary/deltas.h"

#include <systemd/sd-json.h>

#include <algorithm>
#include <cerrno>
#include <cmath>
#include <csignal>
#include <cstdlib>
#include <cstring>
#include <fcntl.h>
#include <fstream>
#include <iostream>
#include <map>
#include <memory>
#include <set>
#include <stdexcept>
#include <string>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/utsname.h>
#include <time.h>
#include <unistd.h>

namespace analyzer {
namespace {

using Json = std::unique_ptr<sd_json_variant, decltype(&sd_json_variant_unref)>;

void checked(int result, const char *context) {
    if (result < 0) throw std::runtime_error(std::string(context) + ": " + std::strerror(-result));
}

Json object() {
    sd_json_variant *value = nullptr;
    checked(sd_json_variant_new_object(&value, nullptr, 0), "JSON object");
    return Json(value, sd_json_variant_unref);
}

void text(Json &object_value, const char *key, const std::string &value) {
    auto *raw = object_value.release();
    const int result = sd_json_variant_set_field_string(&raw, key, value.c_str());
    object_value.reset(raw);
    checked(result, "JSON field");
}

void number(Json &object_value, const char *key, std::uint64_t value) {
    auto *raw = object_value.release();
    const int result = sd_json_variant_set_field_unsigned(&raw, key, value);
    object_value.reset(raw);
    checked(result, "JSON field");
}

void flag(Json &object_value, const char *key, bool value) {
    auto *raw = object_value.release();
    const int result = sd_json_variant_set_field_boolean(&raw, key, value);
    object_value.reset(raw);
    checked(result, "JSON field");
}

void field(Json &object_value, const char *key, sd_json_variant *value) {
    auto *raw = object_value.release();
    const int result = sd_json_variant_set_field(&raw, key, value);
    object_value.reset(raw);
    checked(result, "JSON field");
}

void real(Json &object_value, const char *key, double value) {
    sd_json_variant *raw = nullptr;
    checked(sd_json_variant_new_real(&raw, value), "JSON real");
    Json owned(raw, sd_json_variant_unref);
    field(object_value, key, owned.get());
}

std::string encode(sd_json_variant *value) {
    char *result = nullptr;
    checked(sd_json_variant_format(value, static_cast<sd_json_format_flags_t>(0), &result), "JSON format");
    std::string output(result);
    std::free(result);
    return output;
}

void timestamps(Json &value, TimePoint time) {
    number(value, "monotonic_ns", time.monotonic_ns);
    number(value, "realtime_ns", time.realtime_ns);
}

std::string string_field(sd_json_variant *value, const char *key) {
    auto *item = sd_json_variant_by_key(value, key);
    if (!item || !sd_json_variant_is_string(item) || !*sd_json_variant_string(item))
        throw std::runtime_error(std::string("missing or invalid ") + key);
    return sd_json_variant_string(item);
}

std::uint64_t uint_field(sd_json_variant *value, const char *key,
                         std::uint64_t minimum, std::uint64_t maximum) {
    auto *item = sd_json_variant_by_key(value, key);
    if (!item || !sd_json_variant_is_unsigned(item))
        throw std::runtime_error(std::string("missing or invalid ") + key);
    const auto result = sd_json_variant_unsigned(item);
    if (result < minimum || result > maximum) throw std::runtime_error(std::string("out of range ") + key);
    return result;
}

bool bool_field(sd_json_variant *value, const char *key, bool default_value) {
    auto *item = sd_json_variant_by_key(value, key);
    if (!item) return default_value;
    if (!sd_json_variant_is_boolean(item)) throw std::runtime_error(std::string("invalid ") + key);
    return sd_json_variant_boolean(item);
}

struct Config {
    Json json{nullptr, sd_json_variant_unref};
    std::string run_id;
    std::string scenario;
    std::uint64_t interval_ms = 0;
    std::uint64_t duration_ms = 0;
    double max_power = 0;
    bool cpu_required = true;
    bool rapl_required = false;
    bool pcm_enabled = false;
    bool pcm_required = false;
};

Config load_config(const std::string &path) {
    Config config;
    sd_json_variant *raw = nullptr;
    unsigned line = 0, column = 0;
    checked(sd_json_parse_file(nullptr, path.c_str(), SD_JSON_PARSE_MUST_BE_OBJECT, &raw, &line, &column), "config JSON");
    config.json.reset(raw);
    const std::set<std::string> allowed{"run_id", "scenario", "interval_ms", "duration_ms",
                                        "cpu_required", "rapl_required", "rapl_max_power_watts", "metadata",
                                        "pcm_enabled", "pcm_required"};
    std::set<std::string> seen;
    for (std::size_t index = 0; index < sd_json_variant_elements(raw); index += 2) {
        auto *key = sd_json_variant_by_index(raw, index);
        if (!key || !sd_json_variant_is_string(key)) throw std::runtime_error("invalid config field");
        const std::string name = sd_json_variant_string(key);
        if (!allowed.count(name) || !seen.insert(name).second) throw std::runtime_error("unknown or duplicate config field: " + name);
    }
    auto *metadata = sd_json_variant_by_key(raw, "metadata");
    if (metadata && !sd_json_variant_is_object(metadata)) throw std::runtime_error("metadata must be an object");
    config.run_id = string_field(raw, "run_id");
    config.scenario = string_field(raw, "scenario");
    if (config.scenario != "IDLE" && config.scenario != "CPU" && config.scenario != "IO" && config.scenario != "CPU_IO")
        throw std::runtime_error("invalid scenario");
    config.interval_ms = uint_field(raw, "interval_ms", 100, 3600000);
    config.duration_ms = uint_field(raw, "duration_ms", config.interval_ms, 86400000);
    config.cpu_required = bool_field(raw, "cpu_required", true);
    config.rapl_required = bool_field(raw, "rapl_required", false);
    config.pcm_enabled = bool_field(raw, "pcm_enabled", false);
    config.pcm_required = bool_field(raw, "pcm_required", false);
    if (config.pcm_required && !config.pcm_enabled) throw std::runtime_error("pcm_required needs pcm_enabled");
    auto *power = sd_json_variant_by_key(raw, "rapl_max_power_watts");
    if (power) {
        if (!sd_json_variant_is_number(power)) throw std::runtime_error("invalid rapl_max_power_watts");
        config.max_power = sd_json_variant_real(power);
        if (!std::isfinite(config.max_power) || config.max_power <= 0)
            throw std::runtime_error("invalid rapl_max_power_watts");
    }
    return config;
}

class RunFiles {
public:
    explicit RunFiles(const std::string &path) {
        if (mkdir(path.c_str(), 0700) != 0) throw std::runtime_error("cannot create output directory: " + std::string(std::strerror(errno)));
        directory_ = open(path.c_str(), O_RDONLY | O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW);
        if (directory_ < 0) throw std::runtime_error("cannot open output directory");
    }
    ~RunFiles() {
        for (const int descriptor : files_) if (descriptor >= 0) close(descriptor);
        if (directory_ >= 0) close(directory_);
    }
    int create(const char *name) {
        const int descriptor = openat(directory_, name, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC | O_NOFOLLOW, 0600);
        if (descriptor < 0) throw std::runtime_error("cannot create output file: " + std::string(std::strerror(errno)));
        files_.push_back(descriptor);
        return descriptor;
    }
    void write_all(int descriptor, const std::string &data) {
        std::size_t offset = 0;
        while (offset < data.size()) {
            const auto count = write(descriptor, data.data() + offset, data.size() - offset);
            if (count < 0 && errno == EINTR) continue;
            if (count <= 0) throw std::runtime_error("output write failed: " + std::string(std::strerror(errno)));
            offset += static_cast<std::size_t>(count);
        }
    }
    void sync(int descriptor) {
        if (fsync(descriptor) != 0) throw std::runtime_error("output sync failed: " + std::string(std::strerror(errno)));
    }
    void publish_manifest(const std::string &data) {
        const int descriptor = create("manifest.json.tmp");
        write_all(descriptor, data + "\n");
        sync(descriptor);
        if (linkat(directory_, "manifest.json.tmp", directory_, "manifest.json", 0) != 0)
            throw std::runtime_error("manifest publication failed");
        if (unlinkat(directory_, "manifest.json.tmp", 0) != 0 || fsync(directory_) != 0)
            throw std::runtime_error("manifest directory sync failed");
    }
private:
    int directory_ = -1;
    std::vector<int> files_;
};

volatile std::sig_atomic_t stop_signal = 0;
void stop_handler(int signal) { stop_signal = signal; }

Json event(const std::string &type, TimePoint time) {
    auto value = object();
    text(value, "type", type);
    timestamps(value, time);
    return value;
}

Json observation(const std::string &metric, const std::string &source, const std::string &scope,
                 const std::string &unit, TimePoint time, const std::string &error) {
    auto value = object();
    text(value, "metric", metric);
    text(value, "source", source);
    text(value, "scope", scope);
    text(value, "unit", unit);
    text(value, "kind", "raw_counter");
        text(value, "status", error.empty() ? "available" :
            (error == std::strerror(EACCES) || error == std::strerror(EPERM)) ? "permission_denied" : "read_error");
    if (!error.empty()) text(value, "error", error);
    timestamps(value, time);
    return value;
}

Json derived(const std::string &metric, const std::string &scope, const std::string &unit,
             TimePoint before, TimePoint after, std::uint64_t sample_index,
             const std::optional<double> &result) {
    auto value = object();
    text(value, "metric", metric);
    text(value, "scope", scope);
    text(value, "unit", unit);
    text(value, "status", result ? "available" : "invalid_delta");
    number(value, "start_monotonic_ns", before.monotonic_ns);
    number(value, "end_monotonic_ns", after.monotonic_ns);
    number(value, "before_sample_index", sample_index - 1);
    number(value, "after_sample_index", sample_index);
    text(value, "method", metric == "cpu.load" ? "proc_stat_busy_delta" : "rapl_energy_delta_per_second");
    if (result) real(value, "value", *result);
    return value;
}

void wait_until(std::uint64_t deadline) {
    timespec when{static_cast<time_t>(deadline / 1000000000ULL), static_cast<long>(deadline % 1000000000ULL)};
    while (!stop_signal) {
        const int result = clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &when, nullptr);
        if (result == 0) break;
        if (result != EINTR) throw std::runtime_error("clock_nanosleep failed");
    }
}

}

int probe() {
    auto output = object();
    auto cpu = read_cpu("/");
    std::string error;
    const auto domains = discover_rapl("/", error);
    std::uint64_t rapl_errors = 0;
    for (const auto &domain : domains) {
        const auto sample = read_rapl(domain);
        if (!sample.error.empty() || !sample.range_error.empty()) ++rapl_errors;
    }
    text(output, "cpu_status", cpu.error.empty() ? "available" : "read_error");
    number(output, "cpu_count", cpu.cpus.size());
    text(output, "rapl_status", !error.empty() ? "read_error" : rapl_errors ? "partial" : "available");
    number(output, "rapl_domains", domains.size());
    number(output, "rapl_domain_errors", rapl_errors);
    text(output, "msr_read_status", access("/dev/cpu/0/msr", R_OK) == 0 ? "available" : "unavailable");
    text(output, "pcm_status", "not_probed");
    text(output, "pcm_reason", "PMU programming is not performed by this probe");
    std::cout << encode(output.get()) << '\n';
    return 0;
}

int clock_snapshot() {
    auto output = object();
    timestamps(output, now());
    std::cout << encode(output.get()) << '\n';
    return std::cout ? 0 : 1;
}

int record(const std::string &config_path, const std::string &output_path,
           const std::filesystem::path &source_root, std::unique_ptr<PcmBackend> pcm_backend) {
    const auto config = load_config(config_path);
    RunFiles files(output_path);
    const int measurements = files.create("measurements.jsonl");
    const int events = files.create("events.jsonl");
    const int summary = files.create("summary.json");
    const unsigned schema_version = config.pcm_enabled ? 2 : 1;
    files.write_all(summary, "{\"schema_version\":" + std::to_string(schema_version) + ",\"derived\":[");
    bool first_derived = true;
    auto emit_event = [&](Json value) { files.write_all(events, encode(value.get()) + "\n"); };
    auto emit_observation = [&](Json value) { files.write_all(measurements, encode(value.get()) + "\n"); };
    auto emit_derived = [&](Json value) {
        files.write_all(summary, std::string(first_derived ? "" : ",") + encode(value.get()));
        first_derived = false;
    };
    struct sigaction action{};
    action.sa_handler = stop_handler;
    sigemptyset(&action.sa_mask);
    if (sigaction(SIGINT, &action, nullptr) || sigaction(SIGTERM, &action, nullptr))
        throw std::runtime_error("cannot install signal handlers");
    stop_signal = 0;
    PcmStatus pcm_status{"not_collected", ""};
    bool pcm_failed = false;
    if (config.pcm_enabled) {
        if (!pcm_backend) pcm_backend = make_pcm_backend();
        try {
            pcm_status = pcm_backend->start();
        } catch (const std::exception &error) {
            pcm_status = {"unavailable", error.what()};
        }
        pcm_failed = pcm_status.status != "available";
        if (pcm_failed) pcm_backend->stop();
    }
    const auto started = now();
    emit_event(event("observation_start", started));
    if (pcm_failed) {
        auto failure = observation("pcm.core", "intel_pcm_perf", "system", "count", now(), pcm_status.error);
        text(failure, "status", pcm_status.status);
        emit_observation(std::move(failure));
    }
    std::string discovery_error;
    const auto domains = discover_rapl(source_root, discovery_error);
    bool cpu_failed = false, rapl_failed = !discovery_error.empty();
    if (!discovery_error.empty()) emit_observation(observation("rapl.energy", "linux_powercap", "system", "uJ", now(), discovery_error));
    CpuSample previous_cpu{};
    std::map<std::string, RaplSample> previous_rapl;
    std::map<int, std::pair<PcmReading, std::uint64_t>> previous_pcm;
    bool have_cpu = false;
    const auto interval = config.interval_ms * 1000000ULL;
    const auto end = started.monotonic_ns + config.duration_ms * 1000000ULL;
    std::uint64_t next = started.monotonic_ns;
    std::uint64_t sample_index = 0;
    while (!stop_signal) {
        const auto cpu = read_cpu(source_root);
        if (!cpu.error.empty()) {
            cpu_failed = true;
            emit_observation(observation("cpu.stat", "proc_stat", "system", "USER_HZ", cpu.time, cpu.error));
            have_cpu = false;
        } else {
            for (const auto &[id, counters] : cpu.cpus) {
                const auto scope = "cpu:" + std::to_string(id);
                auto raw = observation("cpu.stat", "proc_stat", scope, "USER_HZ", cpu.time, "");
                number(raw, "sample_index", sample_index);
                static const char *names[] = {"user", "nice", "system", "idle", "iowait", "irq", "softirq", "steal"};
                for (std::size_t index = 0; index < counters.size(); ++index) number(raw, names[index], counters[index]);
                emit_observation(std::move(raw));
                const auto found = previous_cpu.cpus.find(id);
                if (have_cpu && found != previous_cpu.cpus.end())
                    emit_derived(derived("cpu.load", scope, "percent", previous_cpu.time, cpu.time, sample_index,
                                         cpu_load(found->second, counters)));
            }
            previous_cpu = cpu;
            have_cpu = true;
        }
        for (const auto &domain : domains) {
            const auto sample = read_rapl(domain);
            const auto scope = domain.id;
            auto raw = observation("rapl.energy", "linux_powercap", scope, "uJ", sample.time, sample.error);
            text(raw, "domain_name", domain.name);
            text(raw, "package", domain.package);
            number(raw, "sample_index", sample_index);
            if (sample.error.empty()) {
                number(raw, "value", sample.energy);
                if (sample.range_error.empty()) number(raw, "max_energy_range_uj", sample.range);
                else text(raw, "range_error", sample.range_error);
            }
            emit_observation(std::move(raw));
            if (!sample.error.empty() || !sample.range_error.empty()) {
                rapl_failed = true;
                previous_rapl.erase(scope);
                continue;
            }
            const auto found = previous_rapl.find(scope);
            if (found != previous_rapl.end()) {
                const auto &before = found->second;
                const double seconds = sample.time.monotonic_ns > before.time.monotonic_ns
                    ? static_cast<double>(sample.time.monotonic_ns - before.time.monotonic_ns) / 1e9 : 0;
                auto watts = before.range == sample.range
                    ? rapl_watts(before.energy, sample.energy, sample.range, seconds, config.max_power)
                    : std::nullopt;
                auto result = derived("rapl.power", scope, "W", before.time, sample.time, sample_index, watts);
                if (!watts && config.max_power == 0) text(result, "status", "bound_not_provided");
                emit_derived(std::move(result));
            }
            previous_rapl.insert_or_assign(scope, sample);
        }
        if (config.pcm_enabled && !pcm_failed) {
            std::vector<PcmReading> readings;
            try {
                readings = pcm_backend->sample();
            } catch (const std::exception &error) {
                pcm_failed = true;
                pcm_status = {"read_error", error.what()};
                auto failure = observation("pcm.core", "intel_pcm_perf", "system", "count", now(), pcm_status.error);
                emit_observation(std::move(failure));
            }
            if (readings.empty() && !pcm_failed) {
                pcm_failed = true;
                pcm_status = {"read_error", "PCM returned no CPU readings"};
                auto failure = observation("pcm.core", "intel_pcm_perf", "system", "count", now(), pcm_status.error);
                emit_observation(std::move(failure));
            }
            for (const auto &reading : readings) {
                const auto scope = "cpu:" + std::to_string(reading.cpu);
                if (reading.status.status != "available") {
                    pcm_failed = true;
                    pcm_status = reading.status;
                    auto failure = observation("pcm.core", "intel_pcm_perf", scope, "count", reading.end, reading.status.error);
                    text(failure, "status", reading.status.status);
                    emit_observation(std::move(failure));
                    previous_pcm.erase(reading.cpu);
                    continue;
                }
                for (const auto &metric : {std::pair<const char *, std::uint64_t>{"pcm.instructions", reading.instructions},
                                           {"pcm.cycles", reading.cycles}}) {
                    auto raw = observation(metric.first, "intel_pcm_perf", scope, "count", reading.end, "");
                    number(raw, "sample_index", sample_index);
                    number(raw, "read_start_monotonic_ns", reading.start.monotonic_ns);
                    number(raw, "value", metric.second);
                    number(raw, "time_enabled_ns", reading.enabled_ns);
                    number(raw, "time_running_ns", reading.running_ns);
                    text(raw, "source_version", pcm_backend->version());
                    emit_observation(std::move(raw));
                }
                const auto found = previous_pcm.find(reading.cpu);
                if (found != previous_pcm.end()) {
                    const auto &before = found->second.first;
                    const bool ordered = reading.end.monotonic_ns > before.end.monotonic_ns &&
                        reading.instructions >= before.instructions && reading.cycles >= before.cycles &&
                        reading.enabled_ns >= before.enabled_ns && reading.running_ns >= before.running_ns;
                    const auto enabled = ordered ? reading.enabled_ns - before.enabled_ns : 0;
                    const auto running = ordered ? reading.running_ns - before.running_ns : 0;
                    const std::string state = !ordered || running > enabled ? "invalid_delta" :
                                              running == 0 ? "not_running" :
                                              running < enabled ? "multiplexed" : "available";
                    for (const auto &metric : {std::pair<const char *, std::uint64_t>{"pcm.instructions.delta", reading.instructions - (ordered ? before.instructions : reading.instructions)},
                                               {"pcm.cycles.delta", reading.cycles - (ordered ? before.cycles : reading.cycles)}}) {
                        auto value = object();
                        text(value, "metric", metric.first);
                        text(value, "scope", scope);
                        text(value, "unit", "count");
                        text(value, "status", state);
                        text(value, "method", "pcm_perf_counter_delta_unscaled");
                        number(value, "start_monotonic_ns", before.end.monotonic_ns);
                        number(value, "end_monotonic_ns", reading.end.monotonic_ns);
                        number(value, "before_sample_index", found->second.second);
                        number(value, "after_sample_index", sample_index);
                        number(value, "time_enabled_delta_ns", enabled);
                        number(value, "time_running_delta_ns", running);
                        if (state == "available") number(value, "value", metric.second);
                        emit_derived(std::move(value));
                    }
                }
                previous_pcm.insert_or_assign(reading.cpu, std::make_pair(reading, sample_index));
            }
            if (pcm_failed) pcm_backend->stop();
        }
        if (sample_index == 0) emit_event(event("baseline_attempted", now()));
        ++sample_index;
        next += interval;
        if (next > end) break;
        const auto current = now();
        if (current.monotonic_ns > next + interval) {
            auto missed = event("sampling_delayed", current);
            number(missed, "scheduled_monotonic_ns", next);
            emit_event(std::move(missed));
            next = current.monotonic_ns + interval;
            if (next > end) break;
        }
        wait_until(next);
    }
    if (pcm_backend) pcm_backend->stop();
    const auto finished = now();
    if (sample_index < 2 && !stop_signal) emit_event(event("insufficient_samples", finished));
    emit_event(event(stop_signal ? "interrupted" : "observation_end", finished));
    files.write_all(summary, "]}\n");
    files.sync(measurements);
    files.sync(events);
    files.sync(summary);
    const bool required_failed = sample_index < 2 || (cpu_failed && config.cpu_required) || (rapl_failed && config.rapl_required) || (pcm_failed && config.pcm_required);
    const std::string status = stop_signal ? "interrupted" : required_failed ? "failed" :
                               (cpu_failed || rapl_failed || pcm_failed) ? "partial" : "complete";
    auto manifest = object();
    number(manifest, "schema_version", schema_version);
    text(manifest, "analyzer_version", ANALYZER_VERSION);
    text(manifest, "run_id", config.run_id);
    text(manifest, "scenario", config.scenario);
    text(manifest, "status", status);
    text(manifest, "pcm_status", pcm_status.status);
    if (config.pcm_enabled) {
        text(manifest, "pcm_version", pcm_backend->version());
        flag(manifest, "pcm_error", pcm_failed);
        if (!pcm_status.error.empty()) text(manifest, "pcm_error_detail", pcm_status.error);
    }
    text(manifest, "source_root", source_root.string());
    const long user_hz = sysconf(_SC_CLK_TCK);
    if (user_hz > 0) number(manifest, "user_hz", static_cast<std::uint64_t>(user_hz));
    else text(manifest, "user_hz_status", "unavailable");
    text(manifest, "metadata_provenance", "operator_supplied_unverified");
    text(manifest, "effective_policy_status", "not_collected");
    number(manifest, "start_monotonic_ns", started.monotonic_ns);
    number(manifest, "start_realtime_ns", started.realtime_ns);
    number(manifest, "end_monotonic_ns", finished.monotonic_ns);
    number(manifest, "end_realtime_ns", finished.realtime_ns);
    number(manifest, "sample_count", sample_index);
    rusage usage{};
    if (getrusage(RUSAGE_SELF, &usage) == 0) {
        number(manifest, "recorder_user_usec", static_cast<std::uint64_t>(usage.ru_utime.tv_sec) * 1000000ULL + usage.ru_utime.tv_usec);
        number(manifest, "recorder_system_usec", static_cast<std::uint64_t>(usage.ru_stime.tv_sec) * 1000000ULL + usage.ru_stime.tv_usec);
        number(manifest, "recorder_max_rss_kib", static_cast<std::uint64_t>(usage.ru_maxrss));
    } else {
        text(manifest, "recorder_resource_usage_status", "unavailable");
    }
    flag(manifest, "cpu_error", cpu_failed);
    flag(manifest, "rapl_error", rapl_failed);
    field(manifest, "config", config.json.get());
    utsname info{};
    if (uname(&info) == 0) {
        text(manifest, "kernel_release", info.release);
        text(manifest, "architecture", info.machine);
    }
    std::ifstream cpuinfo(source_root / "proc/cpuinfo");
    std::string line;
    while (std::getline(cpuinfo, line)) {
        const auto separator = line.find(':');
        if (separator == std::string::npos) continue;
        const auto key = line.substr(0, separator);
        auto value = line.substr(separator + 1);
        const auto first = value.find_first_not_of(" \t");
        if (first == std::string::npos) continue;
        value.erase(0, first);
        if (key.find("model name") == 0) {
            text(manifest, "cpu_model_proc_cpuinfo", value);
            break;
        }
    }
    files.publish_manifest(encode(manifest.get()));
    std::cout << output_path << " " << status << '\n';
    return stop_signal ? 128 + stop_signal : status == "complete" ? 0 : status == "partial" ? 2 : 1;
}

}