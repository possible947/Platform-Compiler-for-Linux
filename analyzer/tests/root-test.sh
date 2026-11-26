#!/usr/bin/env bash
set -u
umask 077

project_root=$(cd -- "$(dirname -- "$0")/../.." && pwd -P) || exit 1
analyzer="$project_root/analyzer/build/analyzer"
pcm_check="$project_root/analyzer/build/pcm-msr-check"
pmu_check="$project_root/analyzer/build/pmu-perf-check"
config="$project_root/analyzer/examples/root-test.json"
pcm_config="$project_root/analyzer/examples/pcm.json"

for executable in "$analyzer" "$pcm_check" "$pmu_check"; do
    if [[ ! -x "$executable" ]]; then
        printf 'Missing executable: %s\nBuild the PCM and analyzer first; see ROOT_TEST.md.\n' "$executable" >&2
        exit 1
    fi
done
if [[ ! -f "$config" || ! -f "$pcm_config" ]]; then
    printf 'Missing test configuration.\n' >&2
    exit 1
fi
for command in sudo jq awk cmp mktemp lscpu; do
    if ! command -v "$command" >/dev/null 2>&1; then
        printf 'Missing command: %s\n' "$command" >&2
        exit 1
    fi
done

run=$(mktemp -d "${TMPDIR:-/tmp}/platform-analyzer-root-test.XXXXXXXX") || exit 1
printf 'Evidence directory: %s\n' "$run"
printf 'Root authentication is needed for read-only MSR access and a bounded perf test.\n'
if ! sudo -v; then
    printf 'Root authentication failed. No hardware diagnostic was started.\n' >&2
    exit 1
fi

if ! uname -srmo > "$run/uname.txt" || ! lscpu > "$run/lscpu.txt" ||
    ! lscpu --parse=CPU,SOCKET --online > "$run/lscpu-cpu-socket.csv" ||
   ! cat /proc/sys/kernel/nmi_watchdog > "$run/nmi.before" ||
   ! cat /proc/sys/kernel/perf_event_paranoid > "$run/perf.before"; then
    printf 'Cannot capture initial system state; no hardware diagnostic was started.\n' >&2
    exit 1
fi
if ! sudo -n cat /sys/module/msr/parameters/allow_writes > "$run/msr-writes.before"; then
    printf 'Cannot read MSR driver policy; no hardware diagnostic was started.\n' >&2
    exit 1
fi

failures=0
if "$analyzer" record --config "$config" --output "$run/user-record" > "$run/user-record.txt" 2> "$run/user-record.err"; then
    printf 'Unprivileged CPU/RAPL recording: completed\n'
else
    printf 'Unprivileged CPU/RAPL recording: FAILED\n'
    failures=$((failures + 1))
fi

if sudo -n -- "$analyzer" record --config "$config" --output "$run/root-record" > "$run/root-record.txt" 2> "$run/root-record.err"; then
    printf 'Root CPU/RAPL recording: completed\n'
    if ! sudo -n cat "$run/root-record/manifest.json" > "$run/root-record-manifest.json"; then
        printf 'Cannot copy root manifest for inspection\n'
        failures=$((failures + 1))
    fi
else
    printf 'Root CPU/RAPL recording: FAILED\n'
    failures=$((failures + 1))
fi

if sudo -n -- "$analyzer" record --config "$pcm_config" --output "$run/pcm-record" > "$run/pcm-record.txt" 2> "$run/pcm-record.err"; then
    printf 'Root PCM recorder: completed\n'
else
    printf 'Root PCM recorder: FAILED\n'
    failures=$((failures + 1))
fi
for artifact in manifest.json measurements.jsonl summary.json; do
    if ! sudo -n cat "$run/pcm-record/$artifact" > "$run/pcm-record-$artifact"; then
        printf 'Cannot copy PCM recorder artifact: %s\n' "$artifact"
        failures=$((failures + 1))
    fi
done

if sudo -n -- "$pcm_check" > "$run/pcm-msr.tsv" 2> "$run/pcm-msr.err"; then
    printf 'PCM read-only MSR diagnostic: completed\n'
else
    printf 'PCM read-only MSR diagnostic: FAILED\n'
    failures=$((failures + 1))
fi

if sudo -n -- "$pmu_check" > "$run/pmu-perf.tsv" 2> "$run/pmu-perf.err"; then
    printf 'Kernel perf PMU diagnostic: completed\n'
else
    printf 'Kernel perf PMU diagnostic: FAILED\n'
    failures=$((failures + 1))
fi

if ! cat /proc/sys/kernel/nmi_watchdog > "$run/nmi.after" ||
   ! cat /proc/sys/kernel/perf_event_paranoid > "$run/perf.after"; then
    printf 'Cannot capture all system settings after test\n'
    failures=$((failures + 1))
fi
if ! sudo -n cat /sys/module/msr/parameters/allow_writes > "$run/msr-writes.after"; then
    printf 'Cannot capture MSR driver policy after test\n'
    failures=$((failures + 1))
fi
for setting in nmi perf msr-writes; do
    if cmp -s "$run/$setting.before" "$run/$setting.after"; then
        printf '%s setting: unchanged\n' "$setting"
    else
        printf '%s setting: CHANGED or unavailable; inspect before/after files\n' "$setting"
        failures=$((failures + 1))
    fi
done

for manifest in "$run/user-record/manifest.json" "$run/root-record-manifest.json"; do
    if ! jq -e '.status == "complete" and .sample_count >= 2 and .cpu_error == false and .rapl_error == false' "$manifest" >/dev/null 2>&1; then
        printf 'Recorder manifest validation: FAILED (%s)\n' "$manifest"
        failures=$((failures + 1))
    fi
done

if ! jq -e '.schema_version == 2 and .status == "complete" and .pcm_status == "available" and .pcm_error == false and .sample_count >= 2' "$run/pcm-record-manifest.json" >/dev/null 2>&1; then
    printf 'PCM recorder manifest: FAILED\n'
    failures=$((failures + 1))
else
    printf 'PCM recorder manifest: passed\n'
fi

cpu_count=0
while IFS= read -r cpu; do
    [[ -n "$cpu" ]] || continue
    cpu_count=$((cpu_count + 1))
    if ! jq -s -e --arg cpu "cpu:$cpu" '
        [ .[] | select(.source == "intel_pcm_perf" and .scope == $cpu and .status == "available") ] |
        any(.[]; .metric == "pcm.instructions" and .sample_index == 0) and
        any(.[]; .metric == "pcm.instructions" and .sample_index == 1) and
        any(.[]; .metric == "pcm.cycles" and .sample_index == 0) and
        any(.[]; .metric == "pcm.cycles" and .sample_index == 1)
    ' "$run/pcm-record-measurements.jsonl" >/dev/null 2>&1; then
        printf 'PCM recorder samples missing for representative CPU %s\n' "$cpu"
        failures=$((failures + 1))
    fi
done < <(awk -F, '!/^#/ && NF >= 2 && !seen[$2]++ {print $1}' "$run/lscpu-cpu-socket.csv")
if (( cpu_count != 2 )); then
    printf 'Expected two socket representatives, found %s\n' "$cpu_count"
    failures=$((failures + 1))
fi
if ! jq -e 'any(.derived[]; .metric == "pcm.instructions.delta" and .status == "available" and .value > 0) and any(.derived[]; .metric == "pcm.cycles.delta" and .status == "available" and .value > 0)' "$run/pcm-record-summary.json" >/dev/null 2>&1; then
    printf 'PCM recorder deltas: FAILED or multiplexed\n'
    failures=$((failures + 1))
else
    printf 'PCM recorder deltas: passed\n'
fi

if ! awk -F '\t' '
    $1 == "msr" { packages[$3] = 1; seen[$3, $2, $7]++; value[$3, $2, $7] = $8 }
    $1 == "powercap" { powercap[$3, $2]++ }
    END {
        count = 0
        for (package in packages) {
            count++
            for (sample = 0; sample < 2; sample++) {
                if (seen[package, sample, "0x606"] != 1 || seen[package, sample, "0x611"] != 1 || seen[package, sample, "0x619"] != 1) exit 1
                if (powercap[package, sample] < 2) exit 1
            }
            if (value[package, 0, "0x611"] == value[package, 1, "0x611"] || value[package, 0, "0x619"] == value[package, 1, "0x619"]) exit 1
        }
        if (count != 2) exit 1
    }
' "$run/pcm-msr.tsv"; then
    printf 'PCM sample structure/progress: FAILED (expected two sockets and package/DRAM powercap)\n'
    failures=$((failures + 1))
else
    printf 'PCM sample structure/progress: passed\n'
fi

if ! awk -F '\t' '
    $1 == "cycles" || $1 == "instructions" { seen[$1, $2]++; value[$1, $2] = $6; enabled[$1, $2] = $7; running[$1, $2] = $8 }
    END {
        split("cycles instructions", names, " ")
        for (item = 1; item <= 2; item++) {
            name = names[item]
            if (seen[name, 0] != 1 || seen[name, 1] != 1 || value[name, 1] <= value[name, 0] || enabled[name, 1] <= enabled[name, 0] || running[name, 1] <= running[name, 0]) exit 1
        }
    }
' "$run/pmu-perf.tsv"; then
    printf 'PMU sample structure and progress: FAILED\n'
    failures=$((failures + 1))
else
    printf 'PMU sample structure and progress: passed\n'
fi

printf 'Evidence directory: %s\n' "$run"
if (( failures )); then
    printf 'RESULT: FAILED (%s checks); see *.err and evidence files\n' "$failures"
    exit 1
fi
printf 'RESULT: PASS (scope and limitations are described in ROOT_TEST.md)\n'