# Platform Compiler Preparation Protocol v1

## 1. Purpose

This document defines the preparation protocol used to turn a real physical platform, two user-authored inputs, machine evidence, and external technical sources into a structured specification suitable for later deterministic materialization of a platform-specific Linux environment.

The protocol is intentionally staged. It separates:

1. **What the platform is.**
2. **How the current software stack controls it.**
3. **What is wrong, why it is wrong, and which causes are supported by evidence.**
4. **What target state must be materialized to correct the supported problems while satisfying the user's goals.**
5. **Verification after materialization**, as a later execution stage using the same evidence discipline.

The preparation protocol does not assume that a standards-compliant system is an optimal system. A platform may be structurally valid, specification-compliant, boot successfully, and still exhibit poor or internally inconsistent runtime behavior for a particular hardware/software combination.

The protocol therefore distinguishes:

- structural validity;
- specification/contract validity;
- observed runtime behavior;
- behavioral fitness for the actual platform and workload;
- supported causal explanations;
- desired target behavior;
- implementation/materialization mechanisms.

The final goal is not report generation. Reports are intermediate contracts. The eventual goal is to produce a machine-readable materialization specification from which deterministic platform artifacts can be generated, validated, deployed, and measured.

---

## 2. Core Principles

### 2.1 Evidence before assumption

Observed, repeatable behavior is evidence even when it conflicts with expectations, documentation, conventional tuning practice, or assumptions about how the platform should behave.

### 2.2 Specification compliance is not the optimization objective

Specifications define interfaces, contracts, valid structures, and permitted behavior. They do not necessarily define the unique optimum policy for a particular hardware, operating-system, workload, thermal, locality, or latency objective.

### 2.3 Deterministic code establishes state

When a fact can be calculated, parsed, verified, measured, resolved, compiled, or compared deterministically, it should be handled by deterministic code rather than inferred by an LLM.

Examples include:

- topology;
- identifiers;
- hashes;
- ACPI table inventory;
- PCI paths;
- units and unit conversion;
- frequency distributions;
- performance deltas;
- NUMA distances;
- configuration values;
- compilation results;
- validation results.

### 2.4 LLMs provide heuristic analysis

LLMs are used where encoding all possible expert relationships as rules would produce a large, brittle expert system.

Appropriate LLM tasks include:

- recognizing meaningful relationships among observations;
- identifying candidate control domains;
- proposing causal mechanisms;
- forming competing hypotheses;
- identifying discriminating evidence;
- interpreting unusual but formally valid platform behavior;
- proposing candidate target states and solution approaches.

LLM output is inference, not evidence.

### 2.5 Model reasons; harness acts

The model does not own:

- the filesystem;
- shell execution;
- machine state;
- workflow state;
- durable memory;
- deployment;
- verification;
- model/server lifecycle.

The harness collects and validates evidence, decides which stage is being executed, materializes model context, validates model output, and persists results.

### 2.6 Reports replace conversation memory

No stage depends on a long-running chat history or model-owned TODO list.

Every stage produces a versioned durable artifact. The following stage consumes the approved artifact rather than hidden conversation state or a lossy context summary.

### 2.7 No premature diagnosis

Stages 1 and 2 must not receive the user's problem description or goals. This prevents the platform inventory and current-control description from being biased toward a suspected root cause.

### 2.8 Diagnosis is separated from desired solution

Stage 3 receives the user's problem description but not the user's desired target-state document.

This prevents diagnosis from being reverse-engineered to justify a preferred solution.

### 2.9 Materialization is separated from diagnosis

Stage 4 converts supported diagnosis and user goals into a target-state/materialization specification.

It must distinguish:

- required behavior;
- candidate mechanism;
- final materialization artifact.

### 2.10 Measurements decide

A correction is not verified because an LLM considers it correct or because an artifact compiles.

The future verification stage must compare post-change behavior with the pre-change evidence and the declared target state.

---

## 3. Human Inputs

The preparation process has exactly two user-authored semantic inputs:

```text
problems.md
goals.md
```

Everything else must be:

- directly observed;
- deterministically derived;
- retrieved from a cited technical source;
- or explicitly labeled as model inference.

The user is **not** required to:

- identify the responsible subsystem;
- formalize symptoms into technical categories;
- name a root cause;
- translate observations into ACPI/kernel terminology;
- choose an implementation mechanism;
- provide a proposed patch.

### 3.1 `problems.md`

`problems.md` is deliberately free-form.

It describes what the user observes and considers suspicious, incorrect, inefficient, unstable, slow, hot, noisy, latent, or otherwise undesirable.

Example:

```markdown
# Observed problems

Under ProRes I commonly observe approximately:

- package power: 150 W
- domain frequency: 3200 MHz
- core frequencies: around 3200 MHz
- temperature: 56–58 C

Under x265 / SVT-HEVC I observe approximately:

- package power: 150 W
- domain frequency: 2200–2400 MHz
- core frequencies: 1700–3200 MHz
- temperature: around 65 C

I consider the difference suspicious but I am intentionally not assigning a
technical cause to it.
```

The preparation system is responsible for turning this into reproducible measurements and formalized behavioral differences.

### 3.2 `goals.md`

`goals.md` is also free-form.

It describes what the user actually wants from the platform, even when the objective differs from conventional defaults or common deployment practice.

Example:

```markdown
# Platform goals

I want:

- maximum useful CPU throughput without unnecessary thermal load;
- stable workload locality;
- no unnecessary activation of remote CPU/socket domains;
- correct memory locality for performance-sensitive jobs;
- elimination of external-peripheral stalls;
- removal of workarounds when the correct platform state can be expressed
  directly;
- stability and reproducibility.
```

The goals document does not specify how those goals must be implemented.

---

## 4. Stage Isolation

The permitted information flow is:

```text
                     machine / ACPI / external sources
                                  |
                                  v
                 +----------------------------------+
                 | STEP 1: PLATFORM SPECIFICATION   |
                 | WHAT IS IT?                      |
                 +----------------+-----------------+
                                  |
                         Platform Specification
                                  |
                                  v
                 +----------------------------------+
                 | STEP 2: CONTROL ENVIRONMENT      |
                 | HOW IS IT CURRENTLY CONTROLLED?  |
                 +----------------+-----------------+
                                  |
                         Control Environment
                                  |
                problems.md ------+
                                  v
                 +----------------------------------+
                 | STEP 3: PLATFORM DIAGNOSIS       |
                 | WHAT IS WRONG AND WHY?           |
                 +----------------+-----------------+
                                  |
                           Diagnosis Report
                                  |
                   goals.md ------+
                                  v
                 +----------------------------------+
                 | STEP 4: MATERIALIZATION SPEC     |
                 | WHAT MUST CHANGE?                |
                 +----------------+-----------------+
                                  |
                        Materialization Spec
                                  |
                                  v
                         Platform Calculator
                                  |
                  ACPI / kernel / boot / runtime /
                     scheduler / device artifacts
                                  |
                                  v
                          future verification
```

### Stage input rules

#### Step 1 may receive

- host read-only hardware evidence;
- captured ACPI tables;
- existing platform snapshots;
- authoritative external technical sources.

#### Step 1 must not receive

- `problems.md`;
- `goals.md`;
- developer root-cause hypotheses;
- preferred fixes.

#### Step 2 may receive

- approved Step 1 output;
- live/read-only OS and runtime state;
- kernel configuration and documentation;
- authoritative external sources.

#### Step 2 must not receive

- `problems.md`;
- `goals.md`;
- preferred fixes.

#### Step 3 may receive

- approved Step 1 output;
- approved Step 2 output;
- `problems.md`;
- relevant platform evidence;
- controlled runtime measurements;
- authoritative external sources.

#### Step 3 must not receive

- `goals.md`;
- hidden developer hypotheses unless a later explicit hypothesis-challenge pass is requested;
- preferred materialization mechanisms.

#### Step 4 may receive

- approved Step 1 output;
- approved Step 2 output;
- approved Step 3 output;
- `goals.md`;
- relevant evidence and source references.

---

## 5. Common Output Contract

Every preparation stage produces a durable versioned result.

Conceptually:

```text
<workspace>/preparation/<case-id>/
    step-01-platform-specification/
        report.json
        report.md
        sources.json
        run.json

    step-02-control-environment/
        report.json
        report.md
        sources.json
        run.json

    step-03-diagnosis/
        report.json
        report.md
        sources.json
        run.json

    step-04-materialization-specification/
        report.json
        report.md
        sources.json
        run.json
```

Exact paths may later be integrated with the existing Platform Compiler workspace layout.

### `report.json`

Primary machine-readable stage result.

Requirements:

- versioned schema;
- stable field meanings;
- source/evidence references;
- explicit unknown/unavailable states;
- no fabricated values;
- no hidden chain-of-thought.

### `report.md`

Human-readable rendering of `report.json` plus explanations useful to an engineer.

It must not become an independent source of truth that contradicts the JSON representation.

### `sources.json`

Records external and local sources used to prepare the result.

Source classes should distinguish at least:

- observed target evidence;
- deterministic derived evidence;
- external specification/documentation;
- reference-platform material when explicitly allowed;
- model inference.

### `run.json`

Records execution provenance, including where applicable:

- stage version;
- prompt version/hash;
- input artifact hashes;
- model/provider identity;
- timestamps;
- validation result;
- output hashes;
- execution limitations.

No private chain-of-thought is stored.

---

# 6. Step 1: Platform Specification

## 6.1 Purpose

Answer:

> **What exactly is this physical platform, and what capabilities do its components expose?**

This stage is a technical platform passport.

It does not diagnose problems and does not describe current Linux policy except when required solely to discover hardware identity/capability.

## 6.2 Agent responsibilities

The agent may:

- inspect local read-only hardware information;
- inspect existing Platform Compiler snapshots;
- inspect captured ACPI tables;
- identify hardware from PCI/device identifiers;
- research authoritative public sources;
- consult Intel/component/vendor documentation;
- calculate normalized quantities deterministically;
- note discrepancies between sources without choosing a diagnosis.

The agent must prefer authoritative technical sources for component specifications.

When a value cannot be established reliably, record it as unknown rather than guessing.

## 6.3 Platform Specification Questionnaire

### Platform identity

- system architecture;
- motherboard/platform identity when available;
- board/chipset/platform generation;
- firmware/BIOS version;
- UEFI presence;
- relevant firmware identity;
- ACPI revision/inventory.

### CPU

- exact processor model;
- stepping/revision;
- microarchitecture;
- sockets;
- physical cores/socket;
- logical CPUs;
- SMT topology;
- NUMA relationship;
- base frequency;
- documented turbo capability;
- turbo/frequency envelope by active-core count when authoritatively available;
- documented all-core capability when available;
- instruction-set capabilities;
- AVX/AVX2/AVX-512 behavior relevant to frequency/power when documented;
- TDP and documented power envelope;
- thermal limits;
- HWP capability;
- CPPC capability;
- EIST/P-state capability;
- package/core/uncore/DRAM power-domain capabilities where available;
- cache hierarchy;
- socket interconnect/UPI topology.

### Memory

- total installed memory;
- memory per NUMA node;
- channels/controller topology;
- populated channels when knowable;
- DIMM information when safely/readably available;
- memory speed;
- theoretical/documented bandwidth information when reliably available.

### NUMA

- node count;
- CPU membership;
- memory membership;
- distance matrix;
- socket/node relationship.

### PCIe / I/O

- root complexes/root buses;
- relevant host bridges;
- PCIe hierarchy;
- major endpoints;
- GPUs;
- storage controllers/NVMe;
- network controllers;
- USB/Thunderbolt/external I/O where relevant;
- device NUMA locality;
- link capabilities;
- currently negotiated link width/speed when observable;
- IOMMU capability;
- relevant platform I/O architecture.

### Firmware interfaces

Inventory only:

- DSDT;
- SSDTs;
- OEM AML-bearing tables;
- SRAT;
- SLIT;
- DMAR;
- MCFG;
- APIC;
- HPET;
- other relevant data tables.

Do not diagnose them in Step 1.

## 6.4 Example Step 1 output fragment

```yaml
platform_specification:
  schema_version: 1

  cpu:
    model:
      value: "..."
      status: observed
      sources: ["..."]

    topology:
      sockets: 2
      physical_cores: 40
      logical_cpus: 80

    frequency_capability:
      base_mhz:
        value: null
        status: unknown
        reason: "No authoritative value established"

      turbo_by_active_core_count:
        status: unknown
        values: []

    performance_interfaces:
      hwp:
        status: supported
      cppc:
        status: ...
```

Step 1 output becomes a frozen input to all later stages.

---

# 7. Step 2: Control Environment

## 7.1 Purpose

Answer:

> **How does the currently installed software stack control and configure the hardware described by Step 1?**

Step 2 maps capability to current policy.

Conceptually:

```text
HARDWARE CAPABILITY
        <->
CURRENT SOFTWARE POLICY
```

## 7.2 CPU performance/power control

Collect and describe where relevant:

- scaling driver;
- scaling mode;
- governor;
- HWP state;
- EPP/preferences;
- minimum/maximum requested performance;
- cpufreq policies;
- turbo state;
- dynamic boost;
- current package power limits;
- thermal control state;
- idle driver;
- idle governor;
- available/used idle states;
- microcode;
- relevant kernel parameters;
- relevant userspace daemons/services.

## 7.3 Scheduler/execution policy

- kernel scheduler environment;
- topology domains visible to the scheduler;
- SMT policy;
- NUMA scheduling domains;
- automatic NUMA balancing;
- cpusets/cgroups;
- CPU affinity constraints;
- isolation/housekeeping configuration;
- sched_ext state if relevant;
- workload-specific placement mechanisms.

## 7.4 Memory policy

- NUMA policy;
- automatic NUMA balancing;
- THP;
- hugepages;
- reclaim/zone policy relevant to the platform;
- swap/swappiness;
- memory cgroups;
- workload allocation policy when observable.

## 7.5 Interrupt policy

- IRQ distribution;
- irqbalance;
- managed IRQs;
- affinity;
- device-to-IRQ-to-CPU/NUMA relationships;
- MSI/MSI-X state when relevant.

## 7.6 PCI/device policy

- bound drivers;
- runtime PM;
- ASPM;
- negotiated links;
- IOMMU state;
- important driver/module parameters;
- GPU-specific policy where relevant;
- storage/network device policy where relevant.

## 7.7 Kernel/boot environment

- kernel release/build;
- kernel `.config`;
- kernel command line;
- mitigations relevant to performance;
- loaded modules;
- relevant module parameters;
- sysctl state;
- system policies capable of changing hardware behavior.

## 7.8 ACPI usage by Linux

The goal is not just to list methods.

The report should distinguish where evidence permits:

- ACPI interface exists;
- Linux discovered it;
- Linux actively consumes it;
- another subsystem supersedes it;
- usage is unknown.

Do not infer usage solely from existence in AML.

## 7.9 Step 2 output

The output should permit later analysis such as:

```text
CPU capability:
    HWP supported

Current control:
    HWP enabled
    intel_pstate active
    EPP = ...

Firmware interfaces:
    ...
```

without re-querying basic system state.

---

# 8. Step 3: Platform Diagnosis

## 8.1 Purpose

Answer:

> **What is actually wrong, what is merely unusual, and which causal mechanisms are supported by evidence?**

This is the first stage allowed to read `problems.md`.

The stage must not read `goals.md`.

## 8.2 Normalize the user observations

The agent must not require the user to provide a technical diagnosis.

It should convert free-form observations into measurable claims.

Example user observation:

```text
Under ProRes:
    power ~150 W
    domain ~3200 MHz
    cores around 3200 MHz
    temperature 56–58 C

Under x265/SVT-HEVC:
    power ~150 W
    domain 2200–2400 MHz
    cores 1700–3200 MHz
    temperature ~65 C
```

The agent should first verify/reproduce these relationships where practical.

## 8.3 Workload profiles

For each relevant controlled workload/state, collect a bounded behavioral profile.

Possible fields include:

- throughput;
- package power;
- domain/uncore frequency;
- per-core/effective frequencies;
- core-frequency distribution;
- temperature;
- CPU utilization;
- idle residency;
- scheduler migrations;
- NUMA placement;
- remote memory indicators;
- memory bandwidth;
- stalls/performance counters where justified;
- IRQ activity;
- device activity.

The exact set should be selected based on the problem, not collected without bound.

## 8.4 Deterministic differential analysis

Before LLM interpretation, calculate useful relationships deterministically:

- means;
- medians;
- distributions;
- variance/dispersion;
- deltas;
- ratios;
- correlations where meaningful;
- normalized throughput;
- power/performance ratios;
- thermal deltas;
- locality/migration differences.

LLMs should interpret these values, not perform avoidable arithmetic.

## 8.5 Behavioral signatures

Example:

```yaml
behavioral_signature:
  baseline: prores
  affected: x265

  relationships:
    package_power:
      relation: approximately_equal

    realized_frequency:
      relation: materially_lower

    core_frequency_dispersion:
      relation: materially_higher

    temperature:
      relation: higher
```

This is the formal equivalent of the user's observation that the runtime behavior "does not make sense".

## 8.6 Causal analysis

Only after the behavioral signature exists should the analysis consider control domains such as:

- workload/instruction characteristics;
- scheduler policy;
- NUMA placement;
- memory behavior;
- HWP;
- intel_pstate/cpufreq;
- package power limits;
- thermal control;
- ACPI CPU policy;
- firmware policy;
- IRQ/device interaction;
- other evidence-supported mechanisms.

ACPI is not assumed to be the cause merely because ACPI tables are available.

## 8.7 Hypotheses

Every hypothesis should include:

- mechanism;
- which observed anomaly it explains;
- supporting evidence;
- contradicting evidence;
- missing/discriminating evidence;
- current status.

Preferred states:

```text
open
supported
rejected
insufficient_evidence
```

## 8.8 Controlled diagnostic experiments

Step 3 may propose and, where safely authorized, perform read-only or reversible diagnostic measurements designed to distinguish competing hypotheses.

It must record:

- question;
- method;
- changed variable, if any;
- measurements;
- result;
- affected hypotheses.

Do not silently convert diagnosis into permanent tuning.

## 8.9 Step 3 output

The diagnosis report should contain:

```yaml
problems:
behavioral_signatures:
anomalies:
control_domains_considered:
hypotheses:
supported_root_causes:
secondary_causes:
rejected_hypotheses:
unresolved_questions:
required_behavioral_properties:
evidence_inventory:
```

It must not contain a final materialization plan.

---

# 9. Step 4: Materialization Specification

## 9.1 Purpose

Answer:

> **Given the verified platform capabilities, current control environment, supported diagnosis, and user goals, what exact target state must Platform Calculator materialize?**

This is the first stage allowed to read `goals.md`.

## 9.2 Separate target behavior from implementation

Step 4 must distinguish:

### Required behavior

Example:

```text
Performance-sensitive encoding jobs remain within an appropriate execution
locality domain unless migration demonstrates a measurable benefit.
```

### Candidate mechanism

Example:

```text
scheduler policy
```

### Materialized artifact

Example:

```text
sched_ext configuration/policy artifact
```

These are not the same thing.

## 9.3 Native First

For each required state, evaluate the minimum sufficient intervention.

Candidate layers may include:

1. existing runtime facility;
2. existing kernel facility/configuration;
3. scheduler policy;
4. boot configuration;
5. ACPI correction;
6. kernel source change;
7. firmware-level change.

This hierarchy is provisional and should be refined from real preparation runs.

A lower-level intervention should not be chosen when a safer existing mechanism expresses the required state correctly.

Conversely, a workaround should not be preserved merely because it is conventional if the actual root cause belongs at another layer.

## 9.4 Materialization specification

The primary output is machine-readable and should be suitable as input to Platform Calculator.

Conceptually:

```yaml
materialization_specification:
  schema_version: 1

  target_platform_behavior:
    cpu:
      ...
    memory:
      ...
    irq:
      ...
    pci:
      ...

  acpi:
    semantic_requirements:
      ...

  kernel:
    configuration_requirements:
      required: []
      forbidden: []

  boot:
    parameters:
      ...

  runtime:
    sysctl:
      ...
    services:
      ...

  scheduler:
    requirements:
      ...

  device_policy:
    ...

  verification_contract:
    ...
```

## 9.5 Do not materialize prematurely

Step 4 produces the specification for materialization.

It does not need to generate all final artifacts itself.

Platform Calculator/materializers later produce artifacts such as:

- DSDT/SSDT;
- AML;
- kernel `.config`;
- kernel command-line fragments;
- sysctl configuration;
- runtime policy;
- sched_ext policy;
- device configuration.

---

# 10. Future Step 5: Verification

Step 5 is intentionally not fully specified in Preparation Protocol v1.

Its purpose will be:

> **Did the materialized platform actually achieve the required behavior without unacceptable regression?**

It will consume:

- pre-change Step 1–4 artifacts;
- materialized artifacts;
- deployment record;
- new runtime measurements.

It must compare behavior, not merely artifact contents.

Conceptually:

```text
PREPARE
  -> MATERIALIZE
  -> DEPLOY
  -> RE-MEASURE
  -> COMPARE
  -> ACCEPT / REJECT / ITERATE
```

---

# 11. Stage Prompt Contract

Every stage prompt must begin by referencing:

```text
docs/platform-preparation-protocol.md
```

and its own stage documents:

```text
README.md
OUTPUT-SCHEMA.md
```

The prompt should not duplicate the entire protocol.

Conceptually:

```text
Read and obey:

- docs/platform-preparation-protocol.md
- <stage>/README.md
- <stage>/OUTPUT-SCHEMA.md

Inputs for this run:
- ...

Write results only under:
- <workspace>/preparation/<case>/<stage>/
```

The agent must fail explicitly if required inputs are absent rather than silently inventing them.

---

# 12. Proposed Repository Artifact Layout

```text
docs/
  platform-preparation-protocol.md

  user-input/
    problems.example.md
    goals.example.md

prompts/
  platform-preparation/

    01-platform-specification/
      README.md
      PROMPT.md
      OUTPUT-SCHEMA.md

    02-control-environment/
      README.md
      PROMPT.md
      OUTPUT-SCHEMA.md

    03-diagnosis/
      README.md
      PROMPT.md
      OUTPUT-SCHEMA.md

    04-materialization-specification/
      README.md
      PROMPT.md
      OUTPUT-SCHEMA.md
```

Target-specific output remains outside the repository.

---

# 13. Preparation Workspace Layout

Conceptually:

```text
<workspace>/
  preparation/
    <case-id>/

      inputs/
        problems.md
        goals.md

      step-01-platform-specification/
        report.json
        report.md
        sources.json
        run.json

      step-02-control-environment/
        report.json
        report.md
        sources.json
        run.json

      step-03-diagnosis/
        report.json
        report.md
        sources.json
        run.json

      step-04-materialization-specification/
        report.json
        report.md
        sources.json
        run.json
```

Preparation artifacts are versioned and immutable after acceptance.

A corrected execution should create a superseding version/run rather than silently editing accepted historical results.

---

# 14. Trust Model

Information used by the preparation protocol must retain its class.

## Observed target evidence

Direct machine observation.

Examples:

- raw ACPI table;
- measured runtime telemetry;
- sysfs/proc/kernel observation;
- captured configuration.

## Deterministic derived evidence

Produced reproducibly from observed evidence.

Examples:

- contextual ACPI disassembly;
- normalized topology;
- calculated unit conversions;
- workload differential metrics.

## External authoritative information

Examples:

- CPU specification;
- ACPI specification;
- Linux kernel documentation;
- component datasheet.

This is authoritative about the documented interface/component, not necessarily about observed runtime behavior of the target machine.

## Reference-platform evidence

Describes another known implementation.

It must never become target evidence merely through similarity.

## Model inference

Includes:

- interpretation;
- hypothesis;
- causal proposal;
- proposed solution.

Inference remains inference until supported by evidence/verification.

---

# 15. Source Discipline

External technical claims should carry sources.

Where possible, prefer:

1. primary vendor/component documentation;
2. official specification;
3. kernel source/documentation for Linux behavior;
4. reliable secondary technical sources;
5. community knowledge only when clearly labeled as such.

A source describing intended behavior must not be used to erase contrary target observations.

---

# 16. Arithmetic and Normalization

Do not ask LLMs to calculate values that deterministic code can calculate safely.

Examples:

- KiB -> GiB;
- MHz distributions;
- mean/median;
- power delta;
- temperature delta;
- frequency spread;
- throughput percentage;
- NUMA distance comparisons.

Store raw measurement plus normalized deterministic representation when useful.

LLMs interpret relations; they do not serve as calculators when the operands are already available.

---

# 17. Handling Unknowns

Every schema must distinguish:

```text
known
unknown
unavailable
not_applicable
not_collected
conflicting_sources
```

Do not encode all of these as `null` without explanation.

An agent must not fill an unknown simply because a plausible value exists in its training data.

---

# 18. Handling Contradictions

Contradictions are first-class information.

Examples:

```text
vendor documentation says X
observed runtime shows Y
```

or:

```text
firmware exposes interface A
Linux uses mechanism B instead
```

Do not resolve contradictions merely by selecting the specification/source with higher authority.

Record the contradiction and investigate its significance at the appropriate stage.

---

# 19. Behavioral Analysis Principle

Do not search only for out-of-range values.

Many important platform problems manifest as unusual relationships between individually valid observables.

Examples include combinations of:

- power;
- realized frequency;
- requested performance;
- voltage;
- temperature;
- core-frequency dispersion;
- idle residency;
- scheduler migration;
- memory locality;
- throughput.

A value can be valid in isolation while the joint runtime behavior remains inefficient or inconsistent.

Step 3 therefore emphasizes cross-metric behavioral signatures and controlled comparisons.

---

# 20. ACPI Analysis Principle

Do not ask only:

> Is this DSDT compliant?

Distinguish:

1. structural validity;
2. ACPI contract/specification validity;
3. semantic fitness for this platform/OS/workload objective.

A valid ACPI mechanism may still participate in undesirable behavior through platform-specific policy.

ACPI should enter causal analysis when evidence indicates that firmware/OSPM policy lies on the causal path of the observed anomaly, not merely because ACPI source is available.

---

# 21. Separation of Responsibility

For any behavioral anomaly, diagnosis should consider which control layers can affect the measured property.

For CPU performance/power behavior, candidate responsibility layers may include, depending on evidence:

- workload/instruction mix;
- scheduler placement;
- NUMA placement;
- Linux CPUFreq/intel_pstate;
- HWP/hardware performance control;
- thermal control;
- package power limits;
- ACPI processor policy;
- firmware policy.

The aim is not to assume all are active. It is to identify and then discriminate among plausible causal owners.

---

# 22. Preparation Protocol Outputs as Future Platform IR Input

Preparation Protocol v1 intentionally precedes a finalized Platform IR design.

The four reports will provide empirical evidence for which concepts actually need to become durable compiler IR.

After real runs, evaluate:

- which Step 1 fields are repeatedly consumed by Step 2/3;
- which Step 2 policy/control concepts matter during diagnosis;
- which Step 3 causal entities recur;
- which Step 4 target-state fields are required by materializers.

Platform IR should be derived from repeated useful structures, not designed only from hypothetical future needs.

---

# 23. Initial Execution Strategy

The preparation protocol should first be exercised with a strong agent/harness capable of:

- local read-only machine inspection;
- reading existing ACPI captures;
- external technical research;
- multi-step evidence gathering;
- writing structured reports.

The same stage prompt may later be run through a local-model harness to determine which stages can be performed reliably with local inference.

This is model qualification for the specific preparation task, not a general benchmark.

Different stages may ultimately use different inference tiers.

---

# 24. Definition of Success for Preparation Protocol v1

The protocol is successful when:

1. the user only needs to author `problems.md` and `goals.md`;
2. Step 1 produces a trustworthy reusable platform specification;
3. Step 2 produces a trustworthy reusable map of current software control;
4. Step 3 converts informal user observations into reproducible behavioral diagnosis with evidence-backed causal conclusions or explicit unresolved questions;
5. Step 4 converts diagnosis plus goals into a machine-readable target-state/materialization specification;
6. no stage depends on hidden chat history;
7. every important claim retains provenance/trust class;
8. downstream materializers can eventually consume Step 4 without repeating the entire forensic investigation.

---

# 25. Current Scope Boundary

Preparation Protocol v1 defines the process and report contracts.

It does **not** yet define or implement:

- final Platform IR;
- autonomous observation execution policy;
- ACPI patch generation;
- kernel configuration materializer;
- scheduler materializer;
- deployment;
- automatic verification;
- remote-provider disclosure policy;
- long-running LLM conversation memory;
- generic agent workflow frameworks.

Those should be designed from evidence produced by real protocol runs.

---

# 27. Agent Python environment

## Agent Python Execution Environment

Platform Compiler provides a dedicated repository-local Python environment for the project and for engineering agents working with it.

The canonical location is:

```text
<repository-root>/.venv/
```

`.venv` is local runtime state and MUST NOT be committed to version control.

### Mandatory use

When an agent needs Python for project work, it MUST prefer the repository-local environment:

```text
.venv/bin/python
.venv/bin/python -m pip
```

instead of the system Python or system `pip`.

Before Python execution, the agent SHOULD determine the repository root and verify that `.venv/bin/python` exists.

If `.venv` does not exist, the agent MAY create it with:

```bash
python3 -m venv .venv
```

The environment MUST remain isolated from the system Python package environment.

### System Python must remain untouched

Agents MUST NOT install Platform Compiler dependencies globally or into the user's system Python environment.

Unless a separate explicit task requires otherwise, agents MUST NOT use:

```text
sudo pip install
sudo python -m pip
pip install --user
```

for project dependencies, analysis helpers, tests, or temporary engineering tools.

### Agent package installation is allowed

Agents MAY install additional Python packages into `.venv` when they are useful for the current engineering task, including:

- JSON, JSON Schema, YAML, XML, TOML, or CSV processing;
- structured diagnostic-report processing;
- platform and ACPI analysis helpers;
- statistical or measurement analysis;
- report generation;
- testing;
- temporary investigation scripts;
- deterministic transformation or validation of structured data.

Per-package approval is not required for installation inside `.venv`.

This permission does not extend to the system package manager, global Python installation, firmware, kernel, or other machine configuration.

### Installing a package does not declare a project dependency

A package installed into `.venv` for temporary agent work is not automatically a dependency of Platform Compiler.

The following distinction is normative:

```text
package installed into .venv
        !=
project dependency
```

If committed Platform Compiler source code begins to import or otherwise require a package, the dependency MUST be added to the project's versioned dependency metadata and covered by appropriate tests.

Temporary exploratory packages MAY remain untracked and MAY disappear when `.venv` is recreated.

### Agent scripts

Agents MAY create Python scripts for investigation and data processing.

Disposable investigation code SHOULD remain in an appropriate local workspace or temporary location rather than automatically becoming project source.

A script SHOULD become committed project code only when it implements a reusable Platform Compiler capability. In that case it MUST follow normal project requirements for source organization, dependencies, tests, and documentation.

### Structured-data processing

Python is the preferred general-purpose agent execution environment for deterministic processing of structured project data, including:

```text
JSON
JSON Schema
YAML
XML
TOML
CSV
diagnostic reports
CPM documents
measurement datasets
reference-platform metadata
```

When document structure is semantically relevant, agents SHOULD prefer proper parsing and validation over ad-hoc regular expressions or shell text processing.

The preferred transformation model is:

```text
parse
  -> validate
  -> normalize
  -> operate
  -> serialize
```

Reasoning models SHOULD use Python or another deterministic project tool for mechanical data processing when doing so is more reliable than reproducing the same transformation through language-model reasoning.

### Reproducibility

`.venv` is disposable local state, not a source of truth.

It MUST be possible to delete and recreate it without losing project source or authoritative project configuration.

All Python dependencies necessary for normal Platform Compiler operation MUST therefore be represented in versioned project dependency metadata.

Dependencies installed solely for temporary agent investigations do not need to become permanent project dependencies.

When an analysis result materially depends on a Python library, the relevant Python and package versions SHOULD be preserved in the result provenance when practical.

### Local-first and offline operation

The existence of `.venv` does not weaken the project's local-first requirement.

During development, an agent MAY use network package installation when explicitly permitted by the execution environment.

Production operation MUST NOT assume that package indexes or other network services are reachable. Required production dependencies MUST already be available locally before offline operation begins.

A future reproducible deployment mechanism MAY use a local wheelhouse or another offline package source. Such a mechanism is not required merely to satisfy this section.

### Environment integrity

Before significant diagnostic or transformation work, an agent SHOULD be able to identify at least:

```text
Python version
Platform Compiler Git revision
relevant installed package versions
```

when those versions can affect the result.

Agents MUST NOT treat the mutable contents of `.venv` as evidence about the target hardware platform.

### Agent instruction summary

Agents operating in this repository MUST follow this minimal execution rule:

```text
Use the repository-local `.venv` for Python execution.
Create it with `python3 -m venv .venv` if it is absent.
Use `.venv/bin/python` and `.venv/bin/python -m pip`.
Do not modify system Python for project work.
Additional analysis packages may be installed into `.venv`.
A temporary package becomes a project dependency only when committed project code depends on it.
Never commit `.venv`.
```


# 26. Summary

The preparation process is deliberately simple at the highest level:

```text
STEP 1
WHAT?
    Build a canonical specification of the physical platform.

STEP 2
HOW?
    Describe how the current software environment controls that platform.

STEP 3
WHAT IS WRONG?
    Reproduce the user's observations, formalize behavioral anomalies,
    establish supported causes, and separate them from speculation.

STEP 4
HOW MUST IT BE CORRECTED?
    Combine supported diagnosis with the user's goals and produce the
    machine-readable target state for Platform Calculator.

STEP 5 (future)
DID IT WORK?
    Materialize, deploy, measure, compare, and verify.
```

The two human-authored semantic inputs are:

```text
problems.md
goals.md
```

The model provides heuristic reasoning.
The harness owns evidence, workflow, durable state, validation and actions.
The eventual output is not a report but a materialized, verified platform-specific Linux environment.
