#include "batch/batch_record.h"

#include "cli/resource_record.h"
#include "collectors/linux.h"
#include "collectors/resource_pcm.h"
#include "resource/resource_types.h"

#include <algorithm>
#include <cerrno>
#include <chrono>
#include <cmath>
#include <csignal>
#include <cstdlib>
#include <cstring>
#include <fcntl.h>
#include <filesystem>
#include <fstream>
#include <grp.h>
#include <iomanip>
#include <iostream>
#include <map>
#include <pwd.h>
#include <sstream>
#include <stdexcept>
#include <string>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <thread>
#include <unistd.h>
#include <vector>

namespace analyzer {
namespace {

volatile sig_atomic_t interrupted = 0;

void interrupt_handler(int) {
    interrupted = 1;
}

std::string json_escape(const std::string &value) {
    std::ostringstream out;
    for (unsigned char ch : value) {
        switch (ch) {
        case '"': out << "\\\""; break;
        case '\\': out << "\\\\"; break;
        case '\n': out << "\\n"; break;
        case '\r': out << "\\r"; break;
        case '\t': out << "\\t"; break;
        default:
            if (ch < 0x20) out << "\\u" << std::hex << std::setw(4) << std::setfill('0') << int(ch) << std::dec;
            else out << ch;
        }
    }
    return out.str();
}

std::string join_argv(const std::vector<std::string> &args) {
    std::ostringstream out;
    for (size_t index = 0; index < args.size(); ++index) {
        if (index) out << ' ';
        if (args[index].find_first_of(" \t\n\"") == std::string::npos) out << args[index];
        else out << '"' << json_escape(args[index]) << '"';
    }
    return out.str();
}

std::string json_args(const std::vector<std::string> &args) {
    std::ostringstream out;
    out << '[';
    for (size_t index = 0; index < args.size(); ++index) {
        if (index) out << ',';
        out << '"' << json_escape(args[index]) << '"';
    }
    out << ']';
    return out.str();
}

bool numeric_environment(const char *name, unsigned long &value) {
    const char *text = std::getenv(name);
    if (!text || !*text) return false;
    char *end = nullptr;
    errno = 0;
    const unsigned long parsed = std::strtoul(text, &end, 10);
    if (errno || !end || *end) return false;
    value = parsed;
    return true;
}

bool caller_identity(uid_t &uid, gid_t &gid) {
    unsigned long numeric_uid = 0, numeric_gid = 0;
    if (!numeric_environment("SUDO_UID", numeric_uid) || !numeric_environment("SUDO_GID", numeric_gid))
        return false;
    uid = static_cast<uid_t>(numeric_uid);
    gid = static_cast<gid_t>(numeric_gid);
    return true;
}

bool drop_to_caller_identity() {
    if (geteuid() != 0) return true;
    uid_t uid = 0;
    gid_t gid = 0;
    if (!caller_identity(uid, gid)) {
        std::cerr << "analyzer batch workload must not run as root without SUDO_UID/SUDO_GID\n";
        return false;
    }
    passwd *pw = getpwuid(uid);
    if (pw) {
        if (initgroups(pw->pw_name, gid) != 0) return false;
        setenv("HOME", pw->pw_dir, 1);
        setenv("USER", pw->pw_name, 1);
        setenv("LOGNAME", pw->pw_name, 1);
    } else if (setgroups(0, nullptr) != 0) {
        return false;
    }
    if (setgid(gid) != 0) return false;
    if (setuid(uid) != 0) return false;
    return true;
}

bool adopt_path(const std::filesystem::path &path) {
    if (geteuid() != 0) return true;
    uid_t uid = 0;
    gid_t gid = 0;
    if (!caller_identity(uid, gid)) return true;
    return lchown(path.c_str(), uid, gid) == 0;
}

bool adopt_tree(const std::filesystem::path &path) {
    if (geteuid() != 0) return true;
    std::error_code ec;
    for (std::filesystem::recursive_directory_iterator iterator(path, ec), end;
         iterator != end; iterator.increment(ec)) {
        if (ec || !adopt_path(iterator->path())) return false;
    }
    return !ec && adopt_path(path);
}

struct ChildProcess {
    std::string workload;
    std::string role;
    uint32_t attempt = 1;
    std::vector<std::string> argv;
    std::filesystem::path stdout_path;
    std::filesystem::path stderr_path;
    pid_t pid = -1;
    int exit_code = -1;
    bool exited = false;
    bool terminated_by_orchestrator = false;
    std::string termination_reason;
    uint64_t start_monotonic_ns = 0;
    uint64_t start_realtime_ns = 0;
    uint64_t end_monotonic_ns = 0;
    uint64_t end_realtime_ns = 0;
};

bool create_regular_output(const std::filesystem::path &path, int &descriptor) {
    descriptor = open(path.c_str(), O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC | O_NOFOLLOW, 0600);
    return descriptor >= 0;
}

bool spawn_workload(ChildProcess &process, const std::filesystem::path &working_dir) {
    int stdout_fd = -1, stderr_fd = -1;
    if (!create_regular_output(process.stdout_path, stdout_fd) ||
        !create_regular_output(process.stderr_path, stderr_fd)) {
        if (stdout_fd >= 0) close(stdout_fd);
        if (stderr_fd >= 0) close(stderr_fd);
        return false;
    }

    const TimePoint start = now();
    process.start_monotonic_ns = start.monotonic_ns;
    process.start_realtime_ns = start.realtime_ns;
    const pid_t child = fork();
    if (child < 0) {
        close(stdout_fd); close(stderr_fd);
        return false;
    }
    if (child == 0) {
        if (dup2(stdout_fd, STDOUT_FILENO) < 0 || dup2(stderr_fd, STDERR_FILENO) < 0 ||
            chdir(working_dir.c_str()) != 0 || !drop_to_caller_identity())
            _exit(126);
        close(stdout_fd); close(stderr_fd);
        std::vector<char *> exec_args;
        exec_args.reserve(process.argv.size() + 1);
        for (const auto &argument : process.argv) exec_args.push_back(const_cast<char *>(argument.c_str()));
        exec_args.push_back(nullptr);
        execv(exec_args[0], exec_args.data());
        _exit(127);
    }
    close(stdout_fd); close(stderr_fd);
    process.pid = child;
    return true;
}

void poll_processes(std::vector<ChildProcess> &processes) {
    for (auto &process : processes) {
        if (process.exited) continue;
        int status = 0;
        const pid_t result = waitpid(process.pid, &status, WNOHANG);
        if (result == process.pid) {
            const TimePoint end = now();
            process.end_monotonic_ns = end.monotonic_ns;
            process.end_realtime_ns = end.realtime_ns;
            process.exited = true;
            if (WIFEXITED(status)) process.exit_code = WEXITSTATUS(status);
            else if (WIFSIGNALED(status)) process.exit_code = 128 + WTERMSIG(status);
            else process.exit_code = 1;
        }
    }
}

bool any_process_running(const std::vector<ChildProcess> &processes) {
    for (const auto &process : processes) if (!process.exited) return true;
    return false;
}

bool process_failed(const ChildProcess &process) {
    return process.exited && process.exit_code != 0 &&
           process.termination_reason != "cpu_completed";
}

bool any_process_failed(const std::vector<ChildProcess> &processes) {
    for (const auto &process : processes) if (process_failed(process)) return true;
    return false;
}

void terminate_remaining(std::vector<ChildProcess> &processes,
                         int signal = SIGINT,
                         const std::string &reason = "scenario_failed") {
    for (auto &process : processes) {
        if (!process.exited && process.pid > 0) {
            if (process.termination_reason.empty()) process.termination_reason = reason;
            if (kill(process.pid, signal) == 0) process.terminated_by_orchestrator = true;
        }
    }
}

std::filesystem::path pass_log_path(const std::filesystem::path &directory,
                                    const std::string &role,
                                    uint32_t attempt,
                                    const std::string &stream,
                                    bool combined) {
    if (!combined) return directory / (role + "." + stream);
    std::ostringstream name;
    name << role << '.' << std::setw(3) << std::setfill('0') << attempt << '.' << stream;
    return directory / name.str();
}

struct StageOneSummary {
    uint64_t samples = 0;
    std::map<int, std::pair<CpuCounters, CpuCounters>> cpu_bounds;
    std::map<std::string, std::pair<std::uint64_t, std::uint64_t>> rapl_bounds;
};

class StageOneRecorder {
public:
    explicit StageOneRecorder(const std::filesystem::path &directory) :
        measurements_(directory / "measurements.jsonl"),
        events_(directory / "events.jsonl") {}

    bool valid() const { return measurements_.good() && events_.good(); }

    void event(const std::string &name, TimePoint time, const std::string &detail = {}) {
        events_ << "{\"type\":\"" << json_escape(name) << "\",\"monotonic_ns\":" << time.monotonic_ns
                << ",\"realtime_ns\":" << time.realtime_ns;
        if (!detail.empty()) events_ << ",\"detail\":\"" << json_escape(detail) << '"';
        events_ << "}\n";
        events_.flush();
    }

    void sample() {
        CpuSample cpu = read_cpu("/");
        if (!cpu.error.empty()) {
            append_error("proc_stat", "system", cpu.error);
            cpu_error_ = true;
        } else {
            for (const auto &[id, counters] : cpu.cpus) {
                measurements_ << "{\"source\":\"proc_stat\",\"metric\":\"cpu.stat\",\"scope\":\"cpu:"
                              << id << "\",\"sample_index\":" << summary_.samples
                              << ",\"monotonic_ns\":" << cpu.time.monotonic_ns
                              << ",\"realtime_ns\":" << cpu.time.realtime_ns
                              << ",\"status\":\"available\",\"counters\":[";
                for (size_t index = 0; index < counters.size(); ++index) {
                    if (index) measurements_ << ',';
                    measurements_ << counters[index];
                }
                measurements_ << "]}\n";
                auto found = summary_.cpu_bounds.find(id);
                if (found == summary_.cpu_bounds.end())
                    summary_.cpu_bounds[id] = {counters, counters};
                else
                    found->second.second = counters;
            }
        }

        std::string discovery_error;
        if (rapl_domains_.empty() && !rapl_discovered_) {
            rapl_domains_ = discover_rapl("/", discovery_error);
            rapl_discovered_ = true;
        }
        if (!discovery_error.empty()) {
            append_error("linux_powercap", "system", discovery_error);
            rapl_error_ = true;
        }
        for (const auto &domain : rapl_domains_) {
            RaplSample sample = read_rapl(domain);
            measurements_ << "{\"source\":\"linux_powercap\",\"metric\":\"rapl.energy\",\"scope\":\""
                          << json_escape(domain.id) << "\",\"domain_name\":\"" << json_escape(domain.name)
                          << "\",\"package\":\"" << json_escape(domain.package)
                          << "\",\"sample_index\":" << summary_.samples
                          << ",\"monotonic_ns\":" << sample.time.monotonic_ns
                          << ",\"realtime_ns\":" << sample.time.realtime_ns
                          << ",\"status\":\"" << (sample.error.empty() ? "available" : "read_error") << "\"";
            if (sample.error.empty()) {
                measurements_ << ",\"value_uj\":" << sample.energy << ",\"max_energy_range_uj\":" << sample.range;
                auto found = summary_.rapl_bounds.find(domain.id);
                if (found == summary_.rapl_bounds.end())
                    summary_.rapl_bounds[domain.id] = {sample.energy, sample.energy};
                else
                    found->second.second = sample.energy;
            } else {
                measurements_ << ",\"error\":\"" << json_escape(sample.error) << "\"";
                rapl_error_ = true;
            }
            if (!sample.range_error.empty())
                measurements_ << ",\"range_error\":\"" << json_escape(sample.range_error) << "\"";
            measurements_ << "}\n";
        }
        measurements_.flush();
        ++summary_.samples;
    }

    bool cpu_error() const { return cpu_error_; }
    bool rapl_error() const { return rapl_error_; }
    const StageOneSummary &summary() const { return summary_; }

private:
    void append_error(const std::string &source, const std::string &scope, const std::string &error) {
        measurements_ << "{\"source\":\"" << source << "\",\"metric\":\"availability\",\"scope\":\""
                      << scope << "\",\"status\":\"read_error\",\"error\":\"" << json_escape(error) << "\"}\n";
    }

    std::ofstream measurements_;
    std::ofstream events_;
    std::vector<RaplDomain> rapl_domains_;
    bool rapl_discovered_ = false;
    bool cpu_error_ = false;
    bool rapl_error_ = false;
    StageOneSummary summary_;
};

void write_json_summary(const std::filesystem::path &path,
                        const StageOneSummary &stage_one,
                        const ResourceRecord &resource) {
    std::ofstream output(path);
    output << "{\"schema_version\":\"4\",\"stage_one_samples\":" << stage_one.samples << ",\"cpu\":[";
    size_t index = 0;
    for (const auto &[cpu, bounds] : stage_one.cpu_bounds) {
        if (index++) output << ',';
        output << "{\"cpu\":" << cpu << ",\"first_total\":";
        uint64_t first_total = 0, first_idle = 0, last_total = 0, last_idle = 0;
        for (uint64_t value : bounds.first) first_total += value;
        first_idle = bounds.first[3] + bounds.first[4];
        for (uint64_t value : bounds.second) last_total += value;
        last_idle = bounds.second[3] + bounds.second[4];
        const double usage = last_total > first_total
            ? 100.0 * static_cast<double>((last_total - last_idle) - (first_total - first_idle)) /
              static_cast<double>(last_total - first_total) : -1.0;
        output << first_total << ",\"last_total\":" << last_total
               << ",\"mean_window_busy_percent\":" << usage << '}';
    }
    output << "],\"rapl\":[";
    index = 0;
    for (const auto &[domain, bounds] : stage_one.rapl_bounds) {
        if (index++) output << ',';
        output << "{\"domain\":\"" << json_escape(domain) << "\",\"energy_start_uj\":" << bounds.first
               << ",\"energy_end_uj\":" << bounds.second << '}';
    }
    output << "],\"resource\":\"resource.json\",\"core_pcm_count\":" << resource.core_pcm.size() << "}\n";
}

void write_processes(const std::filesystem::path &path, const std::vector<ChildProcess> &processes) {
    std::ofstream output(path);
    output << "[";
    for (size_t index = 0; index < processes.size(); ++index) {
        if (index) output << ',';
        const auto &process = processes[index];
        output << "{\"workload\":\"" << json_escape(process.workload)
               << "\",\"role\":\"" << json_escape(process.role)
               << "\",\"attempt\":" << process.attempt
               << ",\"argv\":" << json_args(process.argv)
               << ",\"command\":\"" << json_escape(join_argv(process.argv))
               << "\",\"pid\":" << process.pid
               << ",\"exit_code\":" << process.exit_code
               << ",\"terminated_by_orchestrator\":" << (process.terminated_by_orchestrator ? "true" : "false")
               << ",\"termination_reason\":\"" << json_escape(process.termination_reason)
               << "\",\"start_monotonic_ns\":" << process.start_monotonic_ns
               << ",\"start_realtime_ns\":" << process.start_realtime_ns
               << ",\"end_monotonic_ns\":" << process.end_monotonic_ns
               << ",\"end_realtime_ns\":" << process.end_realtime_ns << '}';
    }
    output << "]\n";
}

void write_batch_manifest(const BatchRecordOptions &options,
                          const std::vector<std::string> &scenarios,
                          const std::vector<std::pair<std::string, int>> &results,
                          const std::string &status) {
    std::ofstream output(std::filesystem::path(options.output) / "batch-manifest.json");
    output << "{\"schema_version\":\"4\",\"scenario_selection\":\"" << json_escape(options.scenario)
           << "\",\"status\":\"" << status << "\",\"model\":\"" << json_escape(options.model)
           << "\",\"prompt\":\"" << json_escape(options.prompt)
           << "\",\"idle_duration_seconds\":" << options.idle_duration_seconds
           << ",\"scenarios\":[";
    for (size_t index = 0; index < scenarios.size(); ++index) {
        if (index) output << ',';
        output << '"' << scenarios[index] << '"';
    }
    output << "],\"results\":[";
    for (size_t index = 0; index < results.size(); ++index) {
        if (index) output << ',';
        output << "{\"scenario\":\"" << results[index].first << "\",\"exit_code\":" << results[index].second << '}';
    }
    output << "]}\n";
}

bool is_numactl_scenario(const std::string &scenario) {
    return scenario == "cpu-numactl" || scenario == "gpu-numactl" || scenario == "cpu-gpu-numactl";
}

bool uses_cpu(const std::string &scenario) {
    return scenario == "cpu" || scenario == "cpu-numactl" || scenario == "cpu-gpu" || scenario == "cpu-gpu-numactl";
}

bool uses_gpu(const std::string &scenario) {
    return scenario == "gpu" || scenario == "gpu-numactl" || scenario == "cpu-gpu" || scenario == "cpu-gpu-numactl";
}

std::string scenario_status(const std::vector<ChildProcess> &processes,
                            const ResourcePcmStatus &status,
                            bool workload_launch_error,
                            bool stage_one_error,
                            bool interrupted_now) {
    if (interrupted_now) return "interrupted";
    if (status.status != "available" || workload_launch_error || any_process_failed(processes)) return "failed";
    return stage_one_error ? "partial" : "complete";
}

int run_one_scenario(const BatchRecordOptions &options, const std::string &scenario,
                     const std::filesystem::path &scenario_dir) {
    std::error_code ec;
    std::filesystem::create_directories(scenario_dir, ec);
    if (ec) throw std::runtime_error("cannot create scenario directory: " + ec.message());
    if (!adopt_path(scenario_dir))
        throw std::runtime_error("cannot assign scenario directory to the invoking user");
    std::vector<ChildProcess> processes;
    StageOneRecorder stage_one(scenario_dir);
    if (!stage_one.valid()) throw std::runtime_error("cannot create stage-one files");

    ResourcePcmCollector collector;
    ResourcePcmStatus pcm_status = collector.start();
    WorkloadMetadata metadata;
    metadata.operator_note = "batch scenario=" + scenario;
    stage_one.event("measurement_initialized", now());
    stage_one.sample();

    if (pcm_status.status != "available") {
        ResourceRecord resource;
        resource.schema_version = "3";
        resource.scenario = scenario;
        resource.workload_metadata = metadata;
        resource.limitations.push_back(pcm_status.error.empty() ? pcm_status.status : pcm_status.error);
        write_resource_artifact((scenario_dir / "resource.json").string(), resource);
        collector.stop();
        write_json_summary(scenario_dir / "summary.json", stage_one.summary(), resource);
        std::ofstream manifest(scenario_dir / "manifest.json");
        manifest << "{\"schema_version\":\"4\",\"scenario\":\"" << scenario
                 << "\",\"status\":\"failed\",\"pcm_status\":\"" << json_escape(pcm_status.status)
                 << "\",\"pcm_error\":\"" << json_escape(pcm_status.error) << "\"}\n";
        manifest.close();
        if (!adopt_tree(scenario_dir)) std::cerr << "cannot assign scenario artifacts to the invoking user\n";
        return 1;
    }

    bool workload_launch_error = false;
    auto idle_deadline = std::chrono::steady_clock::now();
    const bool combined = scenario == "cpu-gpu" || scenario == "cpu-gpu-numactl";
    const bool with_numactl = is_numactl_scenario(scenario);
    size_t cpu_process_index = 0;
    size_t gpu_process_index = 0;
    uint32_t gpu_attempt = 0;

    const auto start_cpu = [&]() {
        ChildProcess process;
        process.workload = with_numactl ? "cpu-numactl" : "cpu";
        process.role = "cpu";
        process.argv = llama_process_args(options.cpu_cli, options, with_numactl);
        process.stdout_path = scenario_dir / "cpu.stdout";
        process.stderr_path = scenario_dir / "cpu.stderr";
        if (!spawn_workload(process, scenario_dir)) return false;
        cpu_process_index = processes.size();
        processes.push_back(std::move(process));
        stage_one.event("workload_started", now(), "cpu");
        return true;
    };

    const auto start_gpu = [&]() {
        ChildProcess process;
        process.workload = with_numactl ? "gpu-numactl" : "gpu";
        process.role = "gpu";
        process.attempt = ++gpu_attempt;
        process.argv = llama_process_args(options.gpu_cli, options, with_numactl);
        process.stdout_path = pass_log_path(scenario_dir, "gpu", gpu_attempt, "stdout", combined);
        process.stderr_path = pass_log_path(scenario_dir, "gpu", gpu_attempt, "stderr", combined);
        if (!spawn_workload(process, scenario_dir)) return false;
        gpu_process_index = processes.size();
        processes.push_back(std::move(process));
        stage_one.event("workload_started", now(),
                        "gpu attempt " + std::to_string(gpu_attempt));
        return true;
    };

    ResourceRecord resource = collector.measure_until(
        scenario,
        1.0,
        metadata,
        [&]() {
            if (interrupted != 0 || workload_launch_error) return false;
            if (scenario == "idle") return std::chrono::steady_clock::now() < idle_deadline;
            poll_processes(processes);
            if (combined) {
                const ChildProcess &cpu_process = processes[cpu_process_index];
                const ChildProcess &gpu_process = processes[gpu_process_index];
                switch (combined_loop_action(cpu_process.exited, cpu_process.exit_code,
                                             gpu_process.exited, gpu_process.exit_code)) {
                case CombinedLoopAction::continue_running:
                    return true;
                case CombinedLoopAction::restart_gpu:
                    stage_one.event("gpu_pass_completed", now(),
                                    "attempt " + std::to_string(gpu_process.attempt));
                    if (!start_gpu()) {
                        workload_launch_error = true;
                        terminate_remaining(processes, SIGINT, "gpu_restart_failed");
                        return false;
                    }
                    return true;
                case CombinedLoopAction::stop_cpu_completed: {
                    stage_one.event("cpu_anchor_completed", now());
                    ChildProcess &active_gpu = processes[gpu_process_index];
                    if (!active_gpu.exited) {
                        active_gpu.termination_reason = "cpu_completed";
                        active_gpu.terminated_by_orchestrator =
                            kill(active_gpu.pid, SIGINT) == 0;
                    }
                    return false;
                }
                case CombinedLoopAction::stop_failed:
                    terminate_remaining(processes, SIGINT, "combined_workload_failed");
                    return false;
                }
            }
            if (any_process_failed(processes)) {
                terminate_remaining(processes, SIGINT, "workload_failed");
                return false;
            }
            return any_process_running(processes);
        },
        [&]() {
            stage_one.sample();
            poll_processes(processes);
        },
        [&]() {
            if (scenario == "idle") {
                idle_deadline = std::chrono::steady_clock::now() +
                    std::chrono::duration_cast<std::chrono::steady_clock::duration>(
                        std::chrono::duration<double>(options.idle_duration_seconds));
                return;
            }
            if (uses_cpu(scenario) && !start_cpu()) {
                workload_launch_error = true;
                return;
            }
            if (uses_gpu(scenario) && !start_gpu()) {
                workload_launch_error = true;
                terminate_remaining(processes, SIGINT, "gpu_start_failed");
            }
        });
    collector.stop();
    poll_processes(processes);
    if (interrupted != 0)
        terminate_remaining(processes, SIGINT, "interrupted");
    else if (any_process_failed(processes) || workload_launch_error)
        terminate_remaining(processes, SIGINT, "scenario_failed");
    const auto reap_deadline = std::chrono::steady_clock::now() + std::chrono::seconds(5);
    while (any_process_running(processes)) {
        poll_processes(processes);
        if (!any_process_running(processes)) break;
        if (std::chrono::steady_clock::now() >= reap_deadline) terminate_remaining(processes, SIGKILL);
        std::this_thread::sleep_for(std::chrono::milliseconds(20));
    }
    stage_one.sample();

    write_resource_artifact((scenario_dir / "resource.json").string(), resource);
    write_json_summary(scenario_dir / "summary.json", stage_one.summary(), resource);
    write_processes(scenario_dir / "workloads.json", processes);
    stage_one.event("measurement_finished", now());

    const std::string status = scenario_status(processes, pcm_status, workload_launch_error,
        stage_one.cpu_error() || stage_one.rapl_error(), interrupted != 0);
    const size_t gpu_passes = static_cast<size_t>(std::count_if(
        processes.begin(), processes.end(),
        [](const ChildProcess &process) { return process.role == "gpu"; }));
    std::ofstream manifest(scenario_dir / "manifest.json");
    manifest << "{\"schema_version\":\"4\",\"scenario\":\"" << scenario
             << "\",\"status\":\"" << status << "\",\"pcm_status\":\"" << json_escape(pcm_status.status)
             << "\",\"cpu_error\":" << (stage_one.cpu_error() ? "true" : "false")
             << ",\"rapl_error\":" << (stage_one.rapl_error() ? "true" : "false")
             << ",\"stage_one_samples\":" << stage_one.summary().samples
             << ",\"resource_samples\":" << resource.memory.size()
             << ",\"workload_processes\":" << processes.size()
             << ",\"gpu_passes\":" << gpu_passes << "}\n";
    manifest.close();
    if (!adopt_tree(scenario_dir)) std::cerr << "cannot assign scenario artifacts to the invoking user\n";
    std::cout << scenario << ' ' << status << ' ' << scenario_dir.string() << '\n';
    return status == "complete" || status == "partial" ? 0 : 1;
}

}

std::vector<std::string> expand_batch_scenarios(const std::string &scenario) {
    if (scenario == "all")
        return {"idle", "cpu", "cpu-numactl", "gpu", "gpu-numactl", "cpu-gpu", "cpu-gpu-numactl"};
    if (valid_resource_scenario(scenario)) return {scenario};
    return {};
}

std::vector<std::string> llama_process_args(const std::string &cli,
                                            const BatchRecordOptions &options,
                                            bool numactl) {
    std::vector<std::string> args{
        cli, "-m", options.model, "-p", options.prompt, "-st"};
    if (numactl) {
        args.push_back("--numa");
        args.push_back("numactl");
    }
    return args;
}

CombinedLoopAction combined_loop_action(bool cpu_exited, int cpu_exit_code,
                                        bool gpu_exited, int gpu_exit_code) {
    if (cpu_exited) {
        if (cpu_exit_code != 0) return CombinedLoopAction::stop_failed;
        if (gpu_exited && gpu_exit_code != 0) return CombinedLoopAction::stop_failed;
        return CombinedLoopAction::stop_cpu_completed;
    }
    if (!gpu_exited) return CombinedLoopAction::continue_running;
    return gpu_exit_code == 0
        ? CombinedLoopAction::restart_gpu
        : CombinedLoopAction::stop_failed;
}

int batch_record(const BatchRecordOptions &options) {
    ::umask(0077);
    const auto scenarios = expand_batch_scenarios(options.scenario);
    const bool includes_idle = std::find(scenarios.begin(), scenarios.end(), "idle") != scenarios.end();
    if (includes_idle && (!std::isfinite(options.idle_duration_seconds) ||
        options.idle_duration_seconds < 1.0 || options.idle_duration_seconds > 3600.0)) {
        std::cerr << "idle duration must be between 1 and 3600 seconds\n";
        return 1;
    }
    if (scenarios.empty()) {
        std::cerr << "scenario must be all, idle, cpu, cpu-numactl, gpu, gpu-numactl, cpu-gpu or cpu-gpu-numactl\n";
        return 1;
    }
    if (scenarios.size() > 1 && options.model.empty()) {
        std::cerr << "model is required when recording all scenarios\n";
        return 1;
    }
    if (options.scenario != "idle" && options.scenario != "all" && options.model.empty()) {
        std::cerr << "model is required for workload scenarios\n";
        return 1;
    }
    if (!options.model.empty() && !std::filesystem::is_regular_file(options.model)) {
        std::cerr << "model file does not exist\n";
        return 1;
    }
    const bool needs_cpu = std::any_of(scenarios.begin(), scenarios.end(), uses_cpu);
    const bool needs_gpu = std::any_of(scenarios.begin(), scenarios.end(), uses_gpu);
    if ((needs_cpu && (access(options.cpu_cli.c_str(), X_OK) != 0 ||
                       !std::filesystem::is_regular_file(options.cpu_cli))) ||
        (needs_gpu && (access(options.gpu_cli.c_str(), X_OK) != 0 ||
                       !std::filesystem::is_regular_file(options.gpu_cli)))) {
        std::cerr << "required llama.cpp CLI is unavailable\n";
        return 1;
    }

    std::error_code ec;
    const auto initial_output_status = std::filesystem::symlink_status(options.output, ec);
    if (std::filesystem::is_symlink(initial_output_status)) {
        std::cerr << "output directory must not be a symbolic link\n";
        return 1;
    }
    const bool output_existed = std::filesystem::exists(initial_output_status);
    if (output_existed && !std::filesystem::is_directory(initial_output_status)) {
        std::cerr << "output path is not a directory\n";
        return 1;
    }
    ec.clear();
    std::filesystem::create_directories(options.output, ec);
    if (ec) { std::cerr << "cannot create output: " << ec.message() << '\n'; return 1; }
    for (const auto &scenario : scenarios) {
        const std::filesystem::path scenario_path = std::filesystem::path(options.output) / scenario;
        if (std::filesystem::exists(scenario_path, ec)) {
            std::cerr << "scenario output already exists: " << scenario_path << '\n';
            return 1;
        }
    }
    if (options.scenario == "all" &&
        std::filesystem::exists(std::filesystem::path(options.output) / "batch-manifest.json", ec)) {
        std::cerr << "batch manifest already exists\n";
        return 1;
    }
    if (!output_existed) {
        if (chmod(options.output.c_str(), 0700) != 0) {
            std::cerr << "cannot secure output directory: " << std::strerror(errno) << '\n';
            return 1;
        }
        if (!adopt_path(options.output)) {
            std::cerr << "cannot assign output directory to the invoking user\n";
            return 1;
        }
    }

    std::signal(SIGINT, interrupt_handler);
    std::signal(SIGTERM, interrupt_handler);
    interrupted = 0;

    std::vector<std::pair<std::string, int>> results;
    const bool batch_manifest = options.scenario == "all";
    if (batch_manifest) write_batch_manifest(options, scenarios, results, "running");
    for (const auto &scenario : scenarios) {
        const int result = run_one_scenario(options, scenario, std::filesystem::path(options.output) / scenario);
        results.emplace_back(scenario, result);
        if (result != 0) {
            if (batch_manifest) {
                write_batch_manifest(options, scenarios, results, interrupted != 0 ? "interrupted" : "failed");
                if (!adopt_path(std::filesystem::path(options.output) / "batch-manifest.json"))
                    std::cerr << "cannot assign batch manifest to the invoking user\n";
            }
            return result;
        }
    }
    if (batch_manifest) {
        write_batch_manifest(options, scenarios, results, "complete");
        if (!adopt_path(std::filesystem::path(options.output) / "batch-manifest.json"))
            std::cerr << "cannot assign batch manifest to the invoking user\n";
    }
    return 0;
}

}
