# Historical developer guide: superseded architecture

> **Status:** Historical. This guide contains superseded production LLM,
> scheduler, and ACPI-centered plans. It is not normative; see the current
> repository README and `docs/ARCHITECTURE.md`.

# Platform Compiler for Linux: Developer Guide, Project Philosophy, and First-Platform Objectives

> **Document status:** Initial developer baseline
> **Intended audience:** contributors, reviewers, platform engineers, and LLM agents working on the repository
> **Related architecture records:** ADR-001 (LLM Inference and Runtime Investigation), ADR-002 (Canonical ACPI and Reference Platform Policy)

## 1. Purpose of This Document

This document explains **why Platform Compiler exists**, what problems it is intended to solve, and which engineering principles must survive implementation changes.

It is deliberately different from a user README and from an ADR:

- the project README describes what the system is;
- ADRs freeze individual architectural decisions;
- this document explains the engineering philosophy that connects those decisions.

The project is based on repeated user observations from real workstation and server-class x86 systems. Those observations include large differences in performance, latency, power behavior, device behavior, and operating-system stability between machines built from nominally similar hardware; large differences between operating systems on the same hardware; and repeatable improvements after platform-specific ACPI normalization, scheduling changes, NUMA placement changes, and firmware-presentation changes.

These observations are treated as **project evidence**, not as universal claims about every motherboard or distribution.

The guiding assumption is simple:

> **A universal operating-system environment is designed to boot and work across a huge range of hardware. Platform Compiler is allowed to solve a narrower problem: make one known physical machine work as well as the installed hardware permits.**

---

## 2. The Problem the Project Is Solving

A generic Linux distribution kernel must support a broad hardware population. It cannot assume one CPU generation, one socket topology, one fixed PCIe layout, one workload, or one firmware implementation.

That requirement is correct for a distribution. It is not automatically optimal for a fixed high-end workstation.

At the same time, PC firmware cannot be assumed to provide a perfect operating-system-neutral description. Linux kernel documentation explicitly notes that many systems are tested primarily against Windows, sometimes against one particular Windows version, and that alternate ACPI execution paths can expose firmware bugs. citeturn33search54turn33search57

Linux therefore carries compatibility behavior appropriate to a universal kernel. The kernel also officially supports replacing buggy ACPI tables through its ACPI table-upgrade mechanism rather than requiring permanent firmware modification. citeturn33search60turn33search62

Platform Compiler starts from those two realities:

```text
A universal kernel must generalize.
A firmware implementation may contain platform-specific compromises.
A fixed machine does not need either compromise to remain universal.
```

The project therefore attempts to move machine-specific knowledge **out of runtime guesswork and into a verified build process**.

---

## 3. Project Thesis

Platform Compiler treats the production Linux environment as a compiled artifact of:

```text
Physical Machine
      +
Observed Runtime Behavior
      +
Canonical ACPI
      +
Workload Intent
      +
Verified Platform Policy
      |
      v
Machine-Specific Linux Environment
```

The production kernel is not the starting point.

The production kernel, ACPI tables, scheduler behavior, NUMA policy, memory policy, IRQ policy, I/O policy, and boot artifacts are outputs.

The project is intentionally willing to sacrifice portability in exchange for a more precise contract with one machine.

---

## 4. Non-Portability Is a Feature

The production environment is not expected to boot correctly on unrelated hardware.

A material hardware or firmware change may require regeneration.

The production build may depend on:

- CPU generation and feature set;
- socket and SMT topology;
- NUMA topology;
- installed memory topology;
- firmware revision and ACPI table identity;
- PCIe topology relevant to the workload;
- specific GPU/storage/network placement;
- measured platform asymmetries;
- intended workload behavior.

Portability remains the responsibility of the ordinary distribution recovery environment.

This permits the production build to ask a different question from a distribution:

> **What does this machine require?**

instead of:

> **What might some future machine require?**

---

## 5. Evidence Before Assumption

Platform Compiler distinguishes three kinds of truth:

```text
Documented behavior
Implemented behavior
Observed behavior
```

They often agree. When they do not, the difference is an investigation target.

A repeatable observation is not rejected merely because the documented architecture predicts that it should not matter.

This is central to the project because its motivating cases were found experimentally. The correct response to an unexpected but reproducible result is:

```text
UNEXPLAINED OBSERVED EFFECT
```

not:

```text
IMPOSSIBLE OBSERVATION
```

The system should collect enough evidence to explain or bound the effect before generating a correction.

---

## 6. Integral Platform Efficiency

The project uses the informal concept of **integral platform efficiency** as a guiding metric.

Conceptually:

```text
integral efficiency = observed useful result / expected attainable result
```

This is not initially defined as one universal mathematical score. The useful representation is multidimensional:

```yaml
integral_efficiency:
  compute: ...
  memory_locality: ...
  scheduler_locality: ...
  io: ...
  device_latency: ...
  power_behavior: ...
  stability: ...
```

The denominator is not marketing peak performance. It should represent an **attainable envelope for the installed hardware**, established through isolated measurements, topology-aware testing, reference behavior, and validated workloads.

Optimization exists only when the defined useful result improves.

A technically elegant change that does not improve the defined workload or a required system property is not automatically an optimization.

---

## 7. macOS and Hackintosh as Engineering References

macOS and Hackintosh are used as **experimental references**, not as the target operating system.

The project owner has repeatedly used macOS/Hackintosh on the same physical hardware as an A/B comparison environment. In that project context, changes in ACPI presentation and platform behavior have been used to verify that observed limitations are not necessarily intrinsic to the installed silicon.

This evidence motivates the project but does not turn macOS conventions into axioms.

The engineering rule is:

```text
Reference platform shows a possible solution.
Target hardware establishes physical truth.
Runtime evidence establishes actual behavior.
Verification decides whether the solution belongs in production.
```

For the first target platform, the complete MacPro7,1 dump is the primary ACPI semantic reference because it is the closest available project reference and has already been used successfully by the project owner for DSDT adaptation.

For later platforms, another reference may be selected from the available dump library.

---

## 8. The First Target Platform

The first target is a high-end dual-socket Cascade Lake workstation with:

- two server-class Intel processors;
- SMT;
- NUMA memory topology;
- extensive PCIe connectivity;
- multiple high-performance GPUs, including devices local to the second socket;
- large streaming video workloads;
- liquid cooling of major components;
- workloads where CPU, memory, PCIe, GPU, storage, and IRQ locality materially interact.

The exact machine inventory belongs in platform data, not in this philosophy document.

The important fact is that the machine is **not treated as a symmetric bag of interchangeable logical CPUs**.

Its sockets, memory nodes, PCIe paths, GPU placement, and measured behavior form execution domains.

---

## 9. First-Platform Success Criteria

The first implementation exists to address three user-observed problem classes.

### 9.1 Recover lost CPU performance

The project owner has measured approximately **10-25% recoverable CPU performance** on the first platform by comparing operating-system/platform behavior on the same machine.

This range is a project-specific empirical target, not a general claim about Linux or macOS.

The primary CPU objective is therefore:

> **Recover the measured 10-25% loss where it is caused by avoidable scheduling, topology, migration, NUMA, firmware-description, or platform-policy behavior.**

### 9.2 Reduce avoidable CPU and platform heating

The machine uses liquid cooling, but cooling capacity does not make unnecessary activity acceptable.

The desired behavior is to avoid heating hardware merely because the operating system continuously spreads or migrates work across resources that do not need to be active.

The intended CPU policy is compact and stable:

```text
use the minimum necessary execution topology
prefer physical cores before SMT siblings
keep unused domains idle when possible
avoid unnecessary migrations
preserve locality once a good placement is established
```

Lower unnecessary activity should reduce avoidable thermal load while maintaining or increasing useful throughput.

### 9.3 Remove external-peripheral latency and stalls

The project owner observes irritating stalls/lag affecting external peripherals under Linux configurations that do not reproduce under the reference macOS/Hackintosh environment on the same physical hardware.

The objective is not to hide those stalls with larger buffers. It is to identify whether they correlate with:

- IRQ placement;
- PCIe path behavior;
- runtime power management;
- bus/link power policy;
- scheduler migration;
- memory-controller pressure;
- file-cache/writeback pressure;
- firmware-described resources;
- interactions among these layers.

The first-platform target is a system that remains responsive while sustaining the intended high-throughput workload.

---

## 10. Why the Project Considers These Goals Feasible

For the first platform, the project owner reports that the same physical hardware behaves substantially better when operated through a successful Hackintosh/macOS platform configuration.

This is treated as project-specific evidence that the observed Linux behavior is not purely an unavoidable hardware ceiling.

The project does not infer that every macOS mechanism is superior or that every improvement comes from one subsystem. It uses the A/B result to justify investigation.

The practical thesis is:

> **If the same silicon can exhibit better throughput, lower unnecessary activity, and better peripheral behavior under a different platform description and resource-management policy, reproducing those useful properties on Linux is an engineering problem worth attempting.**

---

## 11. Compact Stable Execution

The first major runtime policy is **Compact Stable Execution**.

Its goal is to minimize the active hardware footprint required for a workload while preserving locality.

The policy should prefer an ordered topology such as:

```text
preferred physical cores, if the platform provides them
        |
remaining physical cores in the preferred execution domain
        |
additional physical cores/domains according to measured cost
        |
SMT siblings according to measured platform policy
```

The precise order between using SMT on one socket and activating physical cores on another socket is an empirical platform decision, not a hard-coded universal rule.

### 11.1 Physical cores before logical siblings

The project explicitly wants sequential physical-core filling before SMT siblings where the measured platform policy confirms that choice.

### 11.2 Sticky placement

Migration changes from a default permission into an exception.

Conceptually:

```text
place a thread/process correctly
        |
        v
keep it there
        |
        v
migrate only for an explicit, justified reason
```

The desired behavior is not to remove the Linux migration machinery from existence. It is to stop using migration as routine background optimization for workloads whose topology is already known.

### 11.3 Keep unnecessary sockets idle

A second socket should not receive work merely to make utilization visually balanced.

If the preferred socket has sufficient resources for a CPU-only workload, the other socket may remain largely idle.

When a workload is GPU-local to the second socket, the execution domain may deliberately move there instead.

### 11.4 Implementation direction

Linux `sched_ext` exposes an extensible scheduling class whose behavior is provided by BPF programs and allows schedulers to group CPUs according to their own algorithm. The documented design also restores the standard scheduler when the BPF scheduler fails or stalls. citeturn33search66turn33search68

This makes `sched_ext` a strong initial implementation path for the project's topology-aware scheduler without requiring the first prototype to permanently fork the core scheduler.

---

## 12. NUMA Policy: Place Correctly, Then Stop Moving

The project does not reject NUMA awareness. It rejects unnecessary *continuous correction* after explicit correct placement has already been established.

Automatic NUMA balancing migrates memory toward the CPUs accessing it. SUSE documentation also notes that NUMA balancing incurs overhead through scanning and page faults, and recommends disabling automatic NUMA balancing when static policies have already been created because the data should already be local. citeturn33search72turn33search74

This aligns closely with the Platform Compiler philosophy:

```text
classify workload
        |
choose execution domain
        |
bind CPU placement
        |
bind memory placement
        |
validate locality
        |
avoid automatic migration unless the policy explicitly changes
```

For managed workloads, task and memory migrations should approach zero after initial placement unless an exceptional condition occurs.

---

## 13. Workload Model: Real Streaming Video, Not Synthetic CPU Load

The first real workload includes multiple parallel processes and large video I/O.

Project observations include:

- four parallel processes;
- approximately 16 GiB of active memory per process;
- input ProRes segments totaling more than 200 GiB;
- GOP-sized output units committed approximately once per minute;
- final outputs approximately 20-30 GiB;
- significant CPU work plus large sequential input and output traffic.

These values are workload-specific project facts and must not become generic defaults for other systems.

The important architectural consequence is that the memory problem is not simply "use less cache."

The system contains at least three functionally different memory classes:

```text
Protected/important process working set
Transient clean streaming input cache
Bounded dirty streaming output cache
```

The policy should protect useful working memory from one-pass streaming data that has already served its purpose.

---

## 14. Streaming I/O Philosophy

Large sequential media should not automatically receive the same retention value as actively reused working memory.

The intended policy is:

```text
Input stream
    sequential
    low/no reuse
    transient page-cache value
    discard consumed ranges when safe

Output stream
    bounded dirty window
    early enough background writeback
    no need to retain completed output indefinitely in RAM
```

The implementation may use application hints, wrappers, runtime policy, cgroup mechanisms, or kernel changes as required. The architecture does not pre-commit to one mechanism.

The invariant is that the kernel should not create avoidable memory-controller traffic or reclaim pressure by repeatedly treating one-pass file data as equally valuable to the active process working set.

---

## 15. Device Locality Is Part of Scheduling

A modern multi-socket workstation cannot optimize CPU placement independently of PCIe topology.

The first platform includes major GPU resources on the second socket. Therefore:

```text
CPU-only workload
    -> prefer the empirically best CPU execution domain

GPU-associated workload
    -> prefer CPU and memory locality appropriate to the GPU path
```

IRQ service, driver work, memory placement, and I/O completion are part of the same locality problem.

The scheduler therefore operates on **execution domains**, not only on CPU numbers.

A minimal execution-domain description may include:

```yaml
execution_domain:
  socket: ...
  physical_cores: ...
  smt_siblings: ...
  numa_node: ...
  local_devices: ...
  measured_priority: ...
```

Detailed processor internals that do not change placement policy do not belong in the central optimizer model.

---

## 16. Minimal Platform Knowledge

Platform Compiler intentionally avoids building an unnecessary digital twin of the machine.

The optimizer generally needs only facts that influence generated behavior.

For CPU policy, that may include:

```text
CPU generation/family
relevant feature set
socket/core/SMT topology
NUMA relation
measured execution-domain order
```

For memory policy:

```text
memory generation/class where relevant
topology
NUMA relation
measured locality behavior
```

For I/O:

```text
relevant device
PCIe/upstream path when needed
NUMA/socket locality
IRQ/runtime-PM relationship when needed
```

If a fact does not affect a generated decision, it should not automatically become part of the optimizer's canonical model.

---

## 17. Canonical ACPI: Fix the Platform Description Before Working Around It

ADR-002 defines Canonical Platform ACPI.

The Version 1 scope is deliberately narrow:

```text
resource-range normalization
legacy IRQ ownership
HPET
RTC
LPC
verified UNIX/BSD-oriented production personality
PCI/GPU endpoint and upstream-path semantics
```

Linux documentation explicitly recognizes that `_OSI` paths are widely misused and that many OEM systems have historically been tested primarily through Windows paths. citeturn33search54turn33search59

Platform Compiler does not simply select an unusual `_OSI` identity on an unmodified OEM DSDT and hope for the best.

Its policy is:

```text
analyze desired production path
        |
normalize required resources and methods
        |
compile with zero mandatory errors
        |
validate runtime behavior
        |
then select the verified personality
```

Linux also provides an official ACPI table-upgrade path for replacing buggy platform tables without physically rewriting motherboard firmware. citeturn33search60turn33search65

---

## 18. Reference Platforms Are Engineering Assets

The project owner maintains a set of complete reference platform dumps.

They are not generic patch collections.

A reference platform is used to show how a similar, functioning platform solves a responsibility:

```text
HPET ownership
RTC resources
LPC path
CPU/socket organization
PEG/GPU representation
power methods
OS-personality behavior
```

For the first platform, MacPro7,1 is the primary reference because it is the closest available project reference and has already been used successfully in target DSDT adaptation.

A reference implementation may teach the system **how** to express a responsibility. Only target evidence determines **what values and resources** belong to the target.

---

## 19. Why LLMs Are in the Project

The project does not use an LLM because Python cannot manipulate configuration files.

A deterministic program can already:

- collect hardware inventory;
- run compilers;
- read sysfs/procfs;
- compare hashes;
- execute known transformations;
- generate kernel configuration;
- apply deterministic policies.

The LLM is justified by the expensive human task that remains:

> **investigate an unfamiliar platform by moving among runtime evidence, firmware code, Linux source, device topology, specifications, and reference implementations until the causal chain is understood.**

ADR-001 therefore defines the LLM primarily as a **runtime investigation engine**.

The normal loop is:

```text
Observe live machine
        |
Forensic analysis
        |
Targeted additional observation
        |
Evidence-backed diagnosis
        |
Repair synthesis
        |
Blind semantic review
        |
Deterministic verification
        |
Controlled runtime verification
```

Without this loop, uncommon DSDT work would fall back to manual engineering, which the project specifically intends to avoid.

---

## 20. LLM Role Separation

Initial reference roles are:

```text
Runtime Forensic Analyzer
    -> Nemotron 3 Nano

Deep Runtime Forensic Analyzer
    -> Nemotron 3 Super

Repair Engineer
    -> GPT-OSS 20B / high reasoning

Deep Repair Engineer
    -> GPT-OSS 120B / high reasoning

Optional Frontier Reviewer
    -> selected model through Kilo AI Gateway
```

These assignments reflect project-specific testing, not permanent model loyalty.

The architecture depends on the roles, not the model names.

The LLM cannot mark its own work verified.

---

## 21. Local Inference and Tooling

Local inference is the normal path.

`llama.cpp` is the initial reference inference runtime; Python remains responsible for orchestration, tool execution, evidence storage, policy, escalation, and verification.

The LLM should operate through permissioned semantic tools rather than unrestricted host access.

Examples include:

```text
ACPI table and namespace inspection
ACPI method tracing
PCI tree and upstream-path inspection
runtime-PM inspection
IRQ inspection
NUMA/task-placement inspection
kernel log/source retrieval
reference-platform lookup
specification/web retrieval
offline compilation and sandbox AML execution
```

State-changing operations remain behind a separate trust boundary.

---

## 22. No Experimental Production State

The project may perform experiments in an analysis environment, but it does not define a third "experimental candidate" production image.

The boot model is intentionally simple:

```text
Production
    verified machine-specific environment

Recovery
    standard distribution environment
```

A proposed correction becomes production only after the required verification gates pass.

---

## 23. Kernel Configuration Is Generated

The production `.config` is not an input architecture document.

It is generated from verified platform requirements.

```text
Verified platform requirements
        +
Workload requirements
        |
        v
Kconfig resolution
        |
        v
Machine-specific .config
        |
        v
Native production kernel
```

Generic distribution configurations remain useful for recovery, comparison, and dependency research.

They are not the authoritative production configuration.

---

## 24. Compilation Is Native by Design

Production binary portability is not a project goal.

Compiler and kernel settings may target the actual installed CPU generation and feature set.

The project should still measure the benefit of compiler choices. Native compilation is an architectural permission, not a claim that every native compiler flag improves real workloads.

---

## 25. Recovery Must Stay Boring

Recovery is not another optimization project.

The recovery path is the conventional distribution kernel/environment.

Its purpose is to boot the machine when the production environment cannot be used.

Do not make recovery depend on custom scheduling, canonical ACPI, specialized memory policy, or LLM services.

---

## 26. Project Development Priorities

The project should prioritize work according to measured value on the first platform.

### Priority A: runtime evidence collection

Build the tool layer that can observe:

- CPU placement and migration;
- NUMA placement and migration;
- IRQ distribution;
- PCIe/device locality;
- runtime PM;
- ACPI method execution;
- memory pressure and streaming-cache behavior;
- workload throughput and latency.

### Priority B: Compact Stable Execution

Implement and compare the topology-aware stable scheduler policy.

### Priority C: memory and streaming-I/O policy

Protect useful working sets and prevent one-pass input/output streams from creating unnecessary reclaim, migration, or controller pressure.

### Priority D: Canonical ACPI Version 1

Automate the bounded ADR-002 transformation scope.

### Priority E: machine-specific kernel generation

Generate only the kernel capabilities required by the verified platform and workload.

The exact order may change when measurements identify a higher-value bottleneck.

---

## 27. Engineering Rules for Contributors

### Rule 1: Do not dismiss reproducible measurements

A result that contradicts expectations is a debugging problem, not automatically a bad measurement.

### Rule 2: Do not optimize what has not been measured

Every optimization needs a target metric or system property.

### Rule 3: Separate mechanism from policy

Examples:

```text
sched_ext        -> mechanism
compact packing  -> policy

NUMA API         -> mechanism
static locality  -> policy

ACPI override    -> mechanism
canonical DSDT   -> policy/artifact
```

### Rule 4: Prefer explicit placement over corrective migration

When topology and workload are known, place correctly first.

### Rule 5: Physical topology matters

Socket, NUMA, PCIe, GPU, storage, IRQ, and memory relationships are part of one execution system.

### Rule 6: Preserve what is irrelevant

Do not rewrite dormant firmware paths merely because they can be rewritten.

### Rule 7: Reference does not mean donor

Never copy hardware constants from a reference platform without target evidence.

### Rule 8: LLM output is not verification

Use the LLM to investigate and synthesize. Use independent evidence to accept.

### Rule 9: Do not add abstraction without a decision that needs it

The project should remain small enough to reason about.

### Rule 10: The final test is useful work

A platform change should ultimately improve the defined workload, latency, thermal behavior, stability, or another explicit project requirement.

---

## 28. Anti-Goals

Platform Compiler is **not** intended to become:

- another general-purpose Linux distribution;
- a universal tuning script;
- a collection of undocumented sysctl folklore;
- a Hackintosh patch bundle for Linux;
- a system that rewrites every DSDT warning;
- a benchmark-cheating framework;
- a generic hardware inventory database;
- a replacement for upstream Linux on arbitrary PCs;
- an agent with unrestricted authority over firmware;
- a requirement to modify motherboard flash.

The project is deliberately narrower:

> **Build the best verified Linux execution environment for a known machine and workload.**

---

## 29. Definition of Success for the First Platform

The project should be considered successful on the first platform when measurements demonstrate that the production Linux environment meaningfully closes the gap identified by the project owner.

The target outcomes are:

1. **CPU throughput:** recover the project-observed 10-25% performance loss where that loss is attributable to platform policy and is reproducible.
2. **CPU locality:** eliminate unnecessary cross-core and cross-socket migration for managed stable workloads.
3. **NUMA locality:** eliminate unnecessary page migration after verified placement.
4. **Active topology:** keep unnecessary execution domains idle rather than spreading work for balancing alone.
5. **Thermal behavior:** reduce avoidable heating caused by unnecessary activity while preserving or improving useful throughput.
6. **Streaming memory behavior:** protect the real process working set from one-pass media I/O and control dirty-output buffering.
7. **Peripheral responsiveness:** remove the project-observed external-device stalls/lag under the intended production workload.
8. **GPU/PCIe stability:** apply verified endpoint/upstream-path power and resource policy where required.
9. **ACPI quality:** provide a verified production ACPI path with no mandatory compiler errors and no known unresolved production-path resource defects.
10. **Recovery:** preserve a simple standard distribution recovery environment.

The 10-25% target and peripheral/thermal observations are **user-measured first-platform goals**. They are not published as generic Linux performance claims.

---

## 30. The Project Contract

Platform Compiler makes the following engineering commitment:

> We will not assume that generic defaults are wrong simply because they are generic.
>
> We will not assume that OEM firmware is correct simply because it shipped.
>
> We will not assume that a documented behavior is the behavior observed on the target machine.
>
> We will measure, investigate, explain where possible, and encode only the improvements that survive verification.

The project exists because a machine-specific build is allowed to know things a universal distribution cannot know in advance.

Its purpose is to turn that knowledge into an explicit, reproducible, evidence-backed Linux platform.

---

## 31. Working Motto

> **Do not make the machine adapt to generic policy when the policy can be compiled for the machine.**

A second, equally important rule follows from ADR-001 and ADR-002:

> **No change is better than an unnecessary change, but no reproducible loss should be dismissed merely because the platform was expected to work differently.**

---

## References

- Linux Kernel documentation, *ACPI _OSI and _REV methods*. The documentation explicitly discusses systems tested primarily with Windows and firmware bugs exposed through alternate ACPI paths. citeturn33search54turn33search57
- Linux Kernel documentation, *Upgrading ACPI tables via initrd*. Linux supports replacing or adding ACPI tables to test and work around buggy platform firmware without modifying the underlying firmware image. citeturn33search60turn33search62
- Linux Kernel documentation, *Extensible Scheduler Class*. `sched_ext` permits BPF-defined scheduling behavior and provides fallback to the standard scheduler on scheduler failure or stall. citeturn33search66turn33search68
- SUSE System Analysis and Tuning Guide, *Automatic NUMA balancing*. The guide describes automatic memory migration, notes overhead from NUMA balancing, and recommends disabling it when static NUMA policies already provide correct locality. citeturn33search72turn33search74
