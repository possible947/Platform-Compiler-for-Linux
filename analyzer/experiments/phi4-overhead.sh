#!/usr/bin/env bash
set -u
umask 077

project_root=$(cd -- "$(dirname -- "$0")/../.." && pwd -P) || exit 1
engine=/home/viktor/Applications/llama.cpp/cpu/bin/llama-cli
model=/home/viktor/LLM/models/lmstudio-community/phi-4-GGUF/phi-4-Q4_K_M.gguf
analyzer="$project_root/analyzer/build/analyzer"
output_base=/home/viktor/LLM/analyzer-experiments
pairs=5
threads=40
tokens=128
prompt='Explain how NUMA memory locality affects a CPU inference server.'

while (($#)); do
    case "$1" in
        --engine|--model|--analyzer|--output-base|--pairs)
            if (($# < 2)); then printf 'Missing argument for %s\n' "$1" >&2; exit 1; fi
            case "$1" in
                --engine) engine=$2 ;;
                --model) model=$2 ;;
                --analyzer) analyzer=$2 ;;
                --output-base) output_base=$2 ;;
                --pairs) pairs=$2 ;;
            esac
            shift 2 ;;
        --help)
            printf 'Usage: bash phi4-overhead.sh [--engine PATH] [--model PATH] [--analyzer PATH] [--output-base DIR] [--pairs N]\n'
            exit 0 ;;
        *) printf 'Unknown option: %s\n' "$1" >&2; exit 1 ;;
    esac
done

if [[ ! "$pairs" =~ ^[1-9][0-9]*$ ]] || (( pairs > 20 )); then
    printf 'Pairs must be an integer from 1 to 20.\n' >&2
    exit 1
fi
for path in "$engine" "$analyzer"; do
    if [[ "$path" != /* || ! -x "$path" ]]; then printf 'Not an absolute executable: %s\n' "$path" >&2; exit 1; fi
done
if [[ "$model" != /* || ! -f "$model" || ! -r "$model" ]]; then
    printf 'Model must be an absolute readable regular file: %s\n' "$model" >&2
    exit 1
fi
if [[ "$output_base" != /* ]]; then printf 'Output base must be an absolute path.\n' >&2; exit 1; fi
for command in sudo jq awk grep stat mktemp lscpu sha256sum readlink; do
    if ! command -v "$command" >/dev/null 2>&1; then printf 'Missing command: %s\n' "$command" >&2; exit 1; fi
done
if [[ ! -x /usr/bin/time ]]; then printf 'Missing /usr/bin/time\n' >&2; exit 1; fi
mkdir -p -- "$output_base" || exit 1
experiment=$(mktemp -d "$output_base/phi4-overhead.XXXXXXXX") || exit 1
printf 'Experiment directory: %s\n' "$experiment"

engine=$(readlink -f -- "$engine") || exit 1
model=$(readlink -f -- "$model") || exit 1
analyzer=$(readlink -f -- "$analyzer") || exit 1
model_identity=$(stat -Lc '%d:%i:%s:%Y:%y' -- "$model") || exit 1
printf '%s\n' "$model_identity" > "$experiment/model-stat.before"
sha256sum "$engine" "$analyzer" > "$experiment/executable-sha256.txt"
"$engine" --version > "$experiment/llama-version.txt" 2>&1 || exit 1
uname -srmo > "$experiment/uname.txt" || exit 1
lscpu > "$experiment/lscpu.txt" || exit 1
online_cpus=$(lscpu --parse=CPU --online | awk -F, '!/^#/ && $1 ~ /^[0-9]+$/ {count++} END {print count+0}') || exit 1
if (( online_cpus < 1 )); then printf 'Could not determine online CPUs.\n' >&2; exit 1; fi
if command -v tuned-adm >/dev/null 2>&1; then tuned-adm active > "$experiment/tuned-active.txt" 2>&1 || true; fi
jq -n --arg engine "$engine" --arg model "$model" --arg analyzer "$analyzer" \
    --arg prompt "$prompt" --argjson pairs "$pairs" --argjson threads "$threads" --argjson tokens "$tokens" \
    '{engine:$engine,model:$model,analyzer:$analyzer,prompt:$prompt,pairs:$pairs,threads:$threads,threads_batch:$threads,tokens_max:$tokens,context:2048,gpu_layers:0,seed:42,temperature:0,cache_policy:"one warmup; no cache clearing",order:"AB BA alternating; A=without analyzer, B=with analyzer",acceptance_threshold:null}' \
    > "$experiment/experiment.json" || exit 1

printf 'The experiment runs one warmup and %s pairs with up to 40 CPU threads.\n' "$pairs"
printf 'Root authentication is needed only for analyzer recordings.\n'
if ! sudo -v; then printf 'Root authentication failed; no workload was started.\n' >&2; exit 1; fi

monitor_pid=
sudo_pid=
monitor_pid_file=
cleanup_monitor() {
    local stopped=0
    if [[ -z "$monitor_pid" && -n "$monitor_pid_file" ]] && sudo -n test -f "$monitor_pid_file" 2>/dev/null; then
        monitor_pid=$(sudo -n cat "$monitor_pid_file" 2>/dev/null || true)
    fi
    if [[ "$monitor_pid" =~ ^[1-9][0-9]*$ ]] && sudo -n /usr/bin/kill -0 "$monitor_pid" 2>/dev/null; then
        if [[ "$(sudo -n readlink -f "/proc/$monitor_pid/exe" 2>/dev/null)" == "$analyzer" ]] && \
           sudo -n /usr/bin/kill -INT "$monitor_pid" 2>/dev/null; then
            stopped=1
        else
            printf 'Could not safely stop analyzer PID %s; inspect and stop it manually.\n' "$monitor_pid" >&2
        fi
    else
        stopped=1
    fi
    if [[ -n "$sudo_pid" && "$stopped" == 1 ]]; then wait "$sudo_pid" 2>/dev/null || true; fi
    monitor_pid=
    sudo_pid=
    monitor_pid_file=
}
trap cleanup_monitor EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

parse_timings() {
    awk '
    /eval time[[:space:]]*=/ && !/prompt eval time/ {
        count = $0; sub(/^.*\/[[:space:]]*/, "", count); sub(/[^0-9].*$/, "", count)
        rate = $0
        if (match(rate, /[0-9]+([.][0-9]+)?[[:space:]]+tokens per second/)) {
            rate = substr(rate, RSTART, RLENGTH); sub(/[[:space:]].*$/, "", rate)
            if (count ~ /^[0-9]+$/ && rate ~ /^[0-9]+([.][0-9]+)?$/ && rate+0 > 0) { final_count = count; final_rate = rate }
        }
    }
    END { if (final_count == "" || final_rate == "") exit 1; print final_count, final_rate }
    ' "$1" "$2"
}

run_workload() {
    local directory=$1 status parsed count rate
    mkdir -p -- "$directory/sandbox/cache" "$directory/sandbox/tmp" || return 1
    "$analyzer" clock > "$directory/workload-start.json" || return 1
    (
        cd -- "$directory/sandbox" || exit 1
        /usr/bin/time -p -o "$directory/workload-time.txt" \
            env -i HOME="$directory/sandbox" TMPDIR="$directory/sandbox/tmp" \
            XDG_CACHE_HOME="$directory/sandbox/cache" PATH=/usr/bin:/bin LANG=C \
            "$engine" -m "$model" -t "$threads" -tb "$threads" -n "$tokens" \
            -c 2048 -ngl 0 --temp 0 --seed 42 --ignore-eos --perf --show-timings --log-verbosity 3 --single-turn --simple-io \
            -p "$prompt" < /dev/null > "$directory/workload.stdout" 2> "$directory/workload.stderr"
    )
    status=$?
    "$analyzer" clock > "$directory/workload-end.json" || return 1
    if (( status != 0 )); then printf 'Workload exited %s: %s\n' "$status" "$directory" >&2; return 1; fi
    if ! parsed=$(parse_timings "$directory/workload.stdout" "$directory/workload.stderr"); then
        printf 'Generation timings not found: %s\n' "$directory" >&2
        return 1
    fi
    read -r count rate <<< "$parsed"
    if (( count < 120 || count > tokens )); then
        printf 'Unexpected generated-token count %s: %s\n' "$count" "$directory" >&2
        return 1
    fi
    if [[ -n "${warmup_tokens:-}" && "$count" != "$warmup_tokens" ]]; then
        printf 'Token count %s differs from warmup %s: %s\n' "$count" "$warmup_tokens" "$directory" >&2
        return 1
    fi
    [[ "$(stat -Lc '%d:%i:%s:%Y:%y' -- "$model")" == "$model_identity" ]] || {
        printf 'Model metadata changed during experiment.\n' >&2; return 1;
    }
    jq -n --argjson tokens "$count" --argjson tokens_per_second "$rate" \
        '{exit_status:0,generation_tokens:$tokens,generation_tokens_per_second:$tokens_per_second}' > "$directory/workload-result.json" || return 1
    printf '%s tokens, %s tokens/s\n' "$count" "$rate"
}

wait_for_baseline() {
    local directory=$1 attempts
    for ((attempts=0; attempts<300; attempts++)); do
        if ! kill -0 "$sudo_pid" 2>/dev/null; then printf 'Analyzer exited before baseline.\n' >&2; return 1; fi
        if sudo -n cat "$directory/analyzer/measurements.jsonl" 2>/dev/null | \
            jq -s -e 'any(.[]; .source == "intel_pcm_perf" and .status != "available")' >/dev/null 2>&1; then
            printf 'PCM source failed before workload; see analyzer artifacts.\n' >&2
            return 1
        fi
        if sudo -n cat "$directory/analyzer/measurements.jsonl" 2>/dev/null | \
            jq -s -e --argjson cpus "$online_cpus" '([.[] | select(.source == "intel_pcm_perf" and .metric == "pcm.instructions" and .sample_index == 1 and .status == "available")] | unique_by(.scope) | length) == $cpus and ([.[] | select(.source == "intel_pcm_perf" and .metric == "pcm.cycles" and .sample_index == 1 and .status == "available")] | unique_by(.scope) | length) == $cpus and all(.[]; if .source == "intel_pcm_perf" then .status == "available" else true end)' >/dev/null 2>&1; then
            return 0
        fi
        sleep 0.2
    done
    printf 'Analyzer did not provide a PCM baseline within 60 seconds.\n' >&2
    return 1
}

wait_for_post_sample() {
    local directory=$1 end_ns attempts
    end_ns=$(jq -er '.monotonic_ns' "$directory/workload-end.json") || return 1
    for ((attempts=0; attempts<100; attempts++)); do
        if ! kill -0 "$sudo_pid" 2>/dev/null; then printf 'Analyzer exited before post-workload sample.\n' >&2; return 1; fi
        if sudo -n cat "$directory/analyzer/measurements.jsonl" 2>/dev/null | \
            jq -s -e --argjson end "$end_ns" --argjson cpus "$online_cpus" '([.[] | select(.source == "intel_pcm_perf" and .metric == "pcm.instructions" and .status == "available" and .monotonic_ns >= $end)] | unique_by(.scope) | length) == $cpus and ([.[] | select(.source == "intel_pcm_perf" and .metric == "pcm.cycles" and .status == "available" and .monotonic_ns >= $end)] | unique_by(.scope) | length) == $cpus' >/dev/null 2>&1; then
            return 0
        fi
        sleep 0.2
    done
    printf 'No PCM sample after workload within 20 seconds.\n' >&2
    return 1
}

run_recorded() {
    local directory=$1 run_id=$2 recorder_exit start_ns end_ns
    mkdir -p -- "$directory" || return 1
    jq -n --arg run "$run_id" --arg model "$model" --arg engine "$engine" \
        '{run_id:$run,scenario:"CPU",interval_ms:1000,duration_ms:1800000,cpu_required:true,rapl_required:true,pcm_enabled:true,pcm_required:true,metadata:{workload:"llama-cli",model:$model,engine:$engine,placement:"not overridden"}}' > "$directory/analyzer-config.json" || return 1
    if ! sudo -v; then printf 'Root authentication failed before analyzer run.\n' >&2; return 1; fi
    monitor_pid_file="$directory/analyzer.pid"
    sudo -n -- /bin/sh -c 'set -C; printf "%s\n" "$$" > "$1" || exit 1; shift; exec "$@"' sh \
        "$monitor_pid_file" "$analyzer" record --config "$directory/analyzer-config.json" \
        --output "$directory/analyzer" > "$directory/analyzer.stdout" 2> "$directory/analyzer.stderr" &
    sudo_pid=$!
    if ! wait_for_baseline "$directory"; then
        if sudo -n test -f "$directory/analyzer.pid"; then monitor_pid=$(sudo -n cat "$directory/analyzer.pid"); fi
        cleanup_monitor
        return 1
    fi
    monitor_pid=$(sudo -n cat "$directory/analyzer.pid") || return 1
    if [[ ! "$monitor_pid" =~ ^[1-9][0-9]*$ ]] || \
       [[ "$(sudo -n readlink -f "/proc/$monitor_pid/exe")" != "$analyzer" ]]; then
        printf 'Could not verify analyzer process identity.\n' >&2
        monitor_pid=
        return 1
    fi
    if ! run_workload "$directory" || ! wait_for_post_sample "$directory"; then cleanup_monitor; return 1; fi
     if ! sudo -v || ! kill -0 "$sudo_pid" 2>/dev/null || \
         [[ "$(sudo -n readlink -f "/proc/$monitor_pid/exe")" != "$analyzer" ]] || \
         ! sudo -n /usr/bin/kill -INT "$monitor_pid"; then
        printf 'Could not request analyzer shutdown.\n' >&2
        cleanup_monitor
        return 1
    fi
    wait "$sudo_pid"
    recorder_exit=$?
    sudo_pid=
    monitor_pid=
    monitor_pid_file=
    if (( recorder_exit != 130 )); then printf 'Unexpected analyzer exit: %s\n' "$recorder_exit" >&2; return 1; fi
    for artifact in manifest.json summary.json; do
        sudo -n cat "$directory/analyzer/$artifact" > "$directory/analyzer-$artifact" || return 1
    done
    start_ns=$(jq -er '.monotonic_ns' "$directory/workload-start.json") || return 1
    end_ns=$(jq -er '.monotonic_ns' "$directory/workload-end.json") || return 1
    if ! jq -e --argjson start "$start_ns" --argjson end "$end_ns" \
        '.status == "interrupted" and .pcm_status == "available" and .pcm_error == false and .cpu_error == false and .rapl_error == false and .start_monotonic_ns <= $start and .end_monotonic_ns >= $end' \
        "$directory/analyzer-manifest.json" >/dev/null; then
        printf 'Analyzer manifest does not cover a successful workload: %s\n' "$directory" >&2; return 1
    fi
    if ! jq -e --argjson start "$start_ns" --argjson end "$end_ns" \
        '[.derived[] | select((.metric == "pcm.instructions.delta" or .metric == "pcm.cycles.delta") and .start_monotonic_ns < $end and .end_monotonic_ns > $start)] | length > 0 and all(.[]; .status == "available")' \
        "$directory/analyzer-summary.json" >/dev/null; then
        printf 'PCM deltas unavailable or multiplexed during workload: %s\n' "$directory" >&2; return 1
    fi
}

printf 'Warmup: '
if ! run_workload "$experiment/warmup"; then exit 1; fi
warmup_tokens=$(jq -er '.generation_tokens' "$experiment/warmup/workload-result.json") || exit 1
for ((pair=1; pair<=pairs; pair++)); do
    if (( pair % 2 )); then order=(without with); else order=(with without); fi
    for mode in "${order[@]}"; do
        directory=$(printf '%s/pair-%02d/%s' "$experiment" "$pair" "$mode")
        printf 'Pair %s, %s analyzer: ' "$pair" "$mode"
        if [[ "$mode" == with ]]; then
            if ! run_recorded "$directory" "phi4-pair-$pair-with"; then exit 1; fi
        else
            if ! run_workload "$directory"; then exit 1; fi
        fi
    done
done
printf '%s\n' "$(stat -Lc '%d:%i:%s:%Y:%y' -- "$model")" > "$experiment/model-stat.after"
for ((pair=1; pair<=pairs; pair++)); do
    directory=$(printf '%s/pair-%02d' "$experiment" "$pair")
    jq -n --argjson pair "$pair" \
        --slurpfile without "$directory/without/workload-result.json" \
        --slurpfile with "$directory/with/workload-result.json" \
        '{pair:$pair,without_tokens_per_second:$without[0].generation_tokens_per_second,with_tokens_per_second:$with[0].generation_tokens_per_second,change_percent:(100 * ($with[0].generation_tokens_per_second - $without[0].generation_tokens_per_second) / $without[0].generation_tokens_per_second)}' \
        >> "$experiment/pairs.jsonl" || exit 1
done
jq -s 'def mean: add / length; def median: sort | if length % 2 == 1 then .[length / 2 | floor] else (.[length / 2 - 1] + .[length / 2]) / 2 end; def sample_stddev: if length > 1 then (mean) as $avg | (map((. - $avg) * (. - $avg)) | add / (length - 1) | sqrt) else null end; {pairs:., without_mean_tokens_per_second:(map(.without_tokens_per_second) | mean), with_mean_tokens_per_second:(map(.with_tokens_per_second) | mean), mean_change_percent:(map(.change_percent) | mean), median_change_percent:(map(.change_percent) | median), sample_stddev_change_percent:(map(.change_percent) | sample_stddev), min_change_percent:(map(.change_percent) | min), max_change_percent:(map(.change_percent) | max), acceptance_threshold:null}' \
    "$experiment/pairs.jsonl" > "$experiment/comparison.json" || exit 1
printf 'All runs completed. Results: %s\n' "$experiment"
printf 'Paired throughput comparison: %s/comparison.json; no acceptance threshold has been set.\n' "$experiment"