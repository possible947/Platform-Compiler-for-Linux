# Historical ADR-001: LLM Inference Architecture

> **Status:** Superseded historical proposal. Production LLM inference is not
> part of the current architecture. See `docs/ARCHITECTURE.md` and ADR-003.

- **Status:** Proposed / Initial Baseline
- **Decision Type:** Architecture
- **Project:** Platform Compiler for Linux
- **Version:** 0.1

## 1. Context

Platform Compiler uses LLM reasoning as a core analytical capability, but LLM output is never authoritative by itself.

The system must analyze machine-specific evidence including ACPI/AML, Linux kernel and driver behavior, resource graphs, hardware topology, firmware diagnostics, specifications, and verified reference implementations. The expected workload combines two substantially different cognitive tasks:

1. **Technical analysis:** accurately interpret existing complex engineering artifacts and extract their semantics.
2. **Solution synthesis:** reason across evidence, specifications, references, and tool results to produce a new correction or configuration when a correction is proven necessary.

The system is intentionally designed around multiple inference roles rather than a single universal model.

Local inference is available on project-controlled hardware. The expected deployment can run models in approximately the 20B-30B class primarily in GPU memory and significantly larger models through combined GPU/CPU inference. Cloud inference is available as an optional escalation and independent-review path.

The inference architecture must remain replaceable. Platform Compiler must depend on model roles and capabilities, not on a single vendor, hosted service, checkpoint, or subscription.

---

## 2. Decision

Platform Compiler will use a **role-based, local-first LLM inference architecture** with an OpenAI-compatible provider abstraction.

The initial reference roles are:

```text
ANALYZER
    NVIDIA Nemotron 3 Nano

DEEP_ANALYZER
    NVIDIA Nemotron 3 Super

SYNTHESIZER
    GPT-OSS 20B, high reasoning effort

DEEP_SYNTHESIZER
    GPT-OSS 120B, high reasoning effort

FRONTIER_REVIEWER
    Selected frontier model through Kilo AI Gateway
    when external review is justified
```

The project core will not expose those model names as business logic. They are reference model assignments behind abstract reasoning roles.

---

## 3. Architectural Principle

The central inference rule is:

> **Models propose interpretations and solutions. Evidence and deterministic verification decide what becomes part of the verified platform model.**

LLM confidence, model size, agreement between models, or quality of explanation is not proof.

A second governing rule is:

> **Platform Compiler does not repair firmware for correctness in the abstract. It corrects only verified defects relevant to the target machine, operating environment, or workload.**

Therefore:

> **No change is preferable to an unnecessary correct change.**

An unreachable or irrelevant firmware defect should normally be preserved and documented rather than repaired.

---

## 4. Inference Roles

### 4.1 ANALYZER

The ANALYZER interprets existing technical artifacts. It should favor precision, semantic stability, and repeatability over creative generation.

Initial reference model:

```text
NVIDIA Nemotron 3 Nano
```

Primary responsibilities:

- analyze DSDT/SSDT and ASL/AML semantics;
- analyze Linux kernel and driver source;
- identify namespace dependencies;
- trace method calls and external references;
- identify `OperationRegion` and `Field` dependencies;
- extract `_CRS`, `_PRS`, `_SRS`, `_PRT`, `_STA`, `_DSM`, and related semantics;
- analyze control-flow branches;
- extract resource relationships;
- correlate devices into resource clusters;
- compare two implementations semantically;
- analyze a proposed correction without being told what the correction is expected to accomplish;
- report unexpected semantic differences.

The ANALYZER should not be asked to invent a correction when semantic extraction is sufficient.

### 4.2 DEEP_ANALYZER

The DEEP_ANALYZER performs the same class of work when the evidence graph is unusually large or interconnected.

Initial reference model:

```text
NVIDIA Nemotron 3 Super
```

Typical escalation cases include:

- cross-table DSDT/SSDT dependencies;
- large resource clusters;
- complex interactions among ACPI, kernel subsystems, and drivers;
- IOMMU/PCI/NUMA relationships;
- large reference comparisons;
- cases where the normal ANALYZER cannot produce a complete semantic model.

Model size alone is not a reason to invoke this role.

### 4.3 SYNTHESIZER

The SYNTHESIZER performs evidence-driven reasoning and creates new candidate solutions.

Initial reference model:

```text
GPT-OSS 20B
reasoning effort: high
```

Primary responsibilities:

- combine hardware evidence, firmware evidence, specifications, reference implementations, and Linux behavior;
- formulate causal hypotheses;
- identify whether an observed defect is relevant and reachable;
- use permitted retrieval and research tools;
- determine what additional evidence is required;
- synthesize machine-specific corrections;
- generate or rewrite ASL when a correction is justified;
- propose verification requirements;
- distinguish correction from cosmetic cleanup.

### 4.4 DEEP_SYNTHESIZER

The DEEP_SYNTHESIZER is an escalation role for reasoning chains that the normal SYNTHESIZER cannot close satisfactorily.

Initial reference model:

```text
GPT-OSS 120B
reasoning effort: high
```

It should be invoked because a task remains unresolved, not merely because the task is important.

Possible escalation triggers include:

- unresolved contradictions in the evidence;
- incomplete causal explanation;
- failed semantic verification requiring a new hypothesis;
- significant disagreement between independent analyses;
- complex multi-device or multi-subsystem reasoning;
- inability of the normal SYNTHESIZER to produce a correction with verifiable assumptions.

### 4.5 FRONTIER_REVIEWER

The FRONTIER_REVIEWER is an optional external role, normally accessed through Kilo AI Gateway.

Its primary purpose is not routine synthesis. It is independent, high-quality review of difficult or high-value conclusions.

Particularly useful review questions include:

- Is the proposed change actually necessary?
- Is the defect reachable on the target platform?
- Does the proposed solution contain an unsupported assumption?
- Is the system correcting harmless or irrelevant firmware behavior?
- Can the same verified objective be achieved with less intervention?
- Has local analysis confused a platform-specific path with active behavior?

A frontier review may reject unnecessary work even when the proposed patch is technically correct.

---

## 5. Reference Processing Pipeline

The preferred normal path is:

```text
Raw Platform Evidence
        |
        v
Deterministic Extraction
        |
        v
ANALYZER
        |
        v
Normalized Semantic Model
        |
        v
SYNTHESIZER
        |
        v
Repair / Configuration Proposal
        |
        v
ANALYZER
(blind semantic comparison)
        |
        v
Deterministic Verifier
        |
        +-------- FAIL -> reject / gather evidence / escalate
        |
        v
Verified Platform Model
```

The second ANALYZER pass should, where practical, be blind to the SYNTHESIZER's claimed intent.

Example:

```text
SYNTHESIZER claim:
    "Only HPET resource semantics were changed."

ANALYZER input:
    original ASL
    modified ASL

ANALYZER output:
    actual semantic changes A, B, C

Verifier:
    intended change = A
    observed changes = A, B, C

Result:
    B and C require explanation or the proposal is rejected.
```

This is intended to reduce confirmation bias between generating and reviewing models.

---

## 6. Independent Analysis

For selected problems, models should analyze different evidence views independently before seeing each other's conclusions.

Example:

```text
GPT-OSS view:
    kernel log
    hardware observations
    specification evidence

Nemotron view:
    DSDT/SSDT
    Linux driver source
    resource graph

              |
              v
       Compare Conclusions
              |
              v
      Resolve Disagreement
              |
              v
     Deterministic Verification
```

Agreement between models increases the value of a hypothesis but does not make it verified.

---

## 7. Reachability and Relevance Classification

Before repair synthesis, an observed firmware defect should be classified.

Initial states:

```text
CORRECT
    Behavior is valid for the target platform.

DEFECTIVE_REACHABLE
    A defect exists and is relevant to an executable or consumed path
    on the target platform.

DEFECTIVE_UNREACHABLE
    A defect exists, but available evidence establishes that it cannot
    affect the target configuration.

INDETERMINATE
    Available evidence is insufficient to prove whether the defect
    affects the target configuration.
```

Default actions:

```text
CORRECT
    -> preserve

DEFECTIVE_UNREACHABLE
    -> preserve and document

INDETERMINATE
    -> preserve and gather more evidence

DEFECTIVE_REACHABLE
    -> allow correction analysis
```

Even `DEFECTIVE_REACHABLE` does not authorize a production change. A correction must still be derived and verified.

---

## 8. Local-First Policy

Routine inference should run locally whenever practical.

Reasons include:

- unlimited iteration within local compute constraints;
- control over machine evidence and logs;
- predictable availability;
- ability to run repeated analysis and critique;
- reduced need to transmit complete platform data externally;
- freedom to evaluate and replace checkpoints.

Cloud inference is an escalation and review capability, not a mandatory dependency of the core system.

---

## 9. Inference Transport

The initial inference transport will be based on an **OpenAI-compatible API abstraction**.

The Platform Compiler should communicate with a generic provider interface rather than call llama.cpp, Kilo, or a named model directly.

Conceptual configuration:

```yaml
inference:
  roles:
    analyzer:
      provider: local
      endpoint: http://llm-nemotron/v1
      model: nemotron-3-nano

    deep_analyzer:
      provider: local
      endpoint: http://llm-nemotron-super/v1
      model: nemotron-3-super

    synthesizer:
      provider: local
      endpoint: http://llm-gpt-oss/v1
      model: gpt-oss-20b
      reasoning_effort: high

    deep_synthesizer:
      provider: local
      endpoint: http://llm-gpt-oss-120b/v1
      model: gpt-oss-120b
      reasoning_effort: high

    frontier_reviewer:
      provider: kilo
      endpoint: https://ai-gateway.kilo.ai/api/v1
      model: configured-frontier-model
```

Exact endpoints, model identifiers, quantization, and serving parameters are deployment configuration, not architecture.

---

## 10. Local Inference Runtime

`llama.cpp` is the initial reference runtime for local inference.

The architecture should not expose llama.cpp-specific details above the provider adapter unless a capability cannot be represented by the common interface.

The local runtime is expected to support:

- chat-style inference;
- structured JSON output when available;
- tool/function calling when supported by the selected model and runtime;
- reasoning-model output handling;
- metrics needed for evaluation and reproducibility.

The local server should be operated as a separate service from the Platform Compiler process.

---

## 11. Structured Output

Free-form prose should not be the normal machine-to-machine contract.

LLM output should preferably be constrained to typed schemas validated by Python models such as Pydantic structures.

Conceptual result:

```yaml
diagnosis:
  classification: DEFECTIVE_REACHABLE
  mechanism: "..."

affected_objects:
  - "..."

evidence:
  - source: hardware
    reference: "..."
    finding: "..."

assumptions:
  - statement: "..."
    verification_required: true

proposed_changes:
  - object: "..."
    semantic_change: "..."
    rationale: "..."

preservation_constraints:
  - "..."

verification_requirements:
  - "..."
```

Schema validity does not imply semantic validity.

---

## 12. Tool Access

Models should receive controlled semantic tools rather than unrestricted authority over the host wherever practical.

Potential tools include:

```text
get_platform_model
get_acpi_object
get_acpi_dependencies
get_resource_cluster
get_pci_device
get_interrupt_map
get_iommu_topology
get_kernel_diagnostic
get_driver_source
search_kernel_source
search_reference_acpi
search_specification
search_web
submit_proposal
run_non_destructive_verification
```

Model-accessible tools must not make the model the authority that marks its own work as verified.

In particular, reasoning models must not directly own operations equivalent to:

```text
mark_verified
install_production
flash_firmware
bypass_verifier
```

---

## 13. Web and Retrieval Policy

Internet and source retrieval are considered reasoning tools, not model features.

The preferred architecture is:

```text
LLM
 |
 v
Tool Request
 |
 v
Platform Compiler Tool Layer
 |
 +-- web search
 +-- specification retrieval
 +-- Linux source retrieval
 +-- reference ACPI retrieval
 +-- verified knowledge base
 |
 v
Evidence returned to model
```

This allows retrieval to be logged, sanitized, cached, attributed, and independently inspected.

The model should reason from retrieved evidence rather than rely on memorized technical facts when authoritative or current evidence is available.

---

## 14. External Inference Through Kilo

Kilo AI Gateway is the initial reference external inference gateway.

It is used for optional frontier review, difficult escalation, model comparison, and access to externally hosted models without coupling Platform Compiler to each upstream provider.

Kilo is not a mandatory dependency of platform scanning, verification, kernel generation, or normal local inference.

---

## 15. GitHub Copilot

GitHub Copilot is classified as a **development-plane tool**, not a production inference dependency.

It may be used extensively for:

- implementation;
- refactoring;
- test generation;
- repository work;
- code review;
- documentation;
- developer-side agent workflows.

Platform Compiler runtime behavior must not depend on the availability of a GitHub Copilot subscription or interactive Copilot surface.

---

## 16. Escalation Policy

Escalation should be evidence-driven, not prestige-driven.

A larger or frontier model is not selected merely because a task is important.

Possible escalation signals include:

```text
missing evidence
unresolved contradiction
incomplete dependency graph
failed semantic verification
unexpected analyzer diff
independent-model disagreement
insufficient causal explanation
unverifiable assumptions
```

Preferred escalation sequence:

```text
ANALYZER / SYNTHESIZER
        |
        v
additional evidence and retry
        |
        v
DEEP_ANALYZER / DEEP_SYNTHESIZER
        |
        v
optional FRONTIER_REVIEWER
        |
        v
Deterministic Verification
```

The exact sequence may differ by task class.

---

## 17. Model Behavioral Assumptions

The initial role assignments are based partly on project-specific empirical testing.

Current empirical assumptions include:

### GPT-OSS

- `gpt-oss-20b` at high reasoning effort is expected to be the default local synthesis/reasoning model.
- `gpt-oss-120b` is reserved for reasoning problems that remain unresolved by the 20B model.
- Tool-assisted reasoning and access to current external evidence are considered important to solution quality.

### Nemotron 3

Project testing currently treats Nemotron 3 as a specialized technical-analysis family rather than a general-purpose creative generator.

Observed project-relevant characteristics to be validated by the project's own evaluation suite include:

- strong analysis of existing complex source code and technical artifacts;
- high precision on narrowly specified engineering prompts;
- low semantic variance across repeated equivalent requests;
- comparatively weaker suitability for unconstrained creation of new code from a high-level description.

These are **project observations**, not assumed universal properties of the model family. They must be measured and may be revised without changing the role-based architecture.

---

## 18. Evaluation Requirements

Public benchmarks are useful background information but do not determine the project's default models.

Platform Compiler will require a project-specific evaluation suite.

Important dimensions include:

```text
ACPI object identification
resource extraction accuracy
method dependency accuracy
control-flow interpretation
Linux driver contract analysis
resource-cluster reasoning
reachability classification
correction quality
unsupported-assumption rate
structured-output reliability
semantic stability across repeated runs
ability to identify unnecessary corrections
```

The evaluation corpus should preferentially contain real cases with known evidence, known outcomes, and validated corrections.

### Semantic Stability

For ANALYZER roles, repeated inference should be evaluated semantically rather than through literal text equality.

Example metrics may compare consistency of:

```text
identified objects
external dependencies
resource descriptions
control-flow branches
side effects
semantic diffs
```

A model that produces stylistically different text but the same semantic extraction is considered stable for this purpose.

---

## 19. Inference Record and Reproducibility

Every significant reasoning operation should be traceable.

A conceptual inference record:

```yaml
task_id: "..."
role: analyzer

model:
  provider: local
  runtime: llama.cpp
  model_id: "..."
  model_hash: "..."
  quantization: "..."

inference:
  reasoning_effort: null
  temperature: 0
  seed: null
  prompt_version: "..."

context:
  platform_model_hash: "..."
  evidence_bundle_hash: "..."
  reference_hashes: []

tools:
  calls: []

output:
  schema_version: "..."
  response_hash: "..."

verification:
  status: "..."
  evidence: []
```

Not every field is guaranteed to be controllable by every backend. The record should capture what was actually configured and observed rather than fabricate missing reproducibility data.

---

## 20. Privacy Boundary

Raw machine evidence should remain local unless external inference genuinely requires it.

Before external inference, the system should construct the smallest useful evidence package and remove irrelevant identifying information where possible.

Examples include:

- serial numbers;
- SMBIOS UUIDs;
- MAC addresses;
- hostnames;
- usernames;
- unrelated logs;
- credentials;
- API secrets.

External review should receive technically sufficient evidence, not an indiscriminate machine dump.

---

## 21. Verification Boundary

The inference subsystem must be architecturally unable to promote its own proposal to verified status merely because a model claims certainty.

Conceptually:

```text
Inference Plane
    |
    v
Proposal
    |
    |  trust boundary
    v
Verification Plane
    |
    v
Verified Platform Model
```

Where practical, verification should use deterministic tools and observations not generated by the same LLM that proposed the change.

---

## 22. Consequences

### Positive

- Most inference can remain local.
- Expensive frontier inference is used selectively.
- Different model families can be assigned tasks matching their observed strengths.
- Model replacement does not require redesigning Platform Compiler.
- Analysis and synthesis are separated.
- Blind semantic review reduces generator confirmation bias.
- Structured contracts simplify Python integration.
- Evidence can be preserved for later model evaluation and domain adaptation.
- The architecture supports future models that do not yet exist.

### Negative

- Multiple local models increase operational complexity.
- Model routing requires evaluation rather than a single global default.
- Large-model CPU/GPU inference may be slow.
- Structured-output compatibility differs among models and serving runtimes.
- External review adds cost and privacy considerations.
- Independent analysis increases total inference work.

These costs are accepted because inference quality, auditability, and replaceability are more important than minimizing the number of model backends.

---

## 23. Rejected Alternatives

### 23.1 One universal LLM for all tasks

Rejected because analysis, synthesis, and independent review benefit from different model behavior and different failure modes.

### 23.2 Cloud-only inference

Rejected as the core architecture because routine analysis can be performed locally and machine evidence should not require external transmission.

### 23.3 Local-only inference with no external review path

Rejected because frontier models provide a useful independent escalation and review capability for difficult cases.

### 23.4 GitHub Copilot as the runtime inference API

Rejected as a core runtime dependency. Copilot remains a development-plane tool.

### 23.5 Model agreement as verification

Rejected. Consensus is still model output and cannot replace hardware, specification, compiler, runtime, or other deterministic evidence.

### 23.6 Automatic repair of every detected firmware defect

Rejected. Defects that are unreachable, irrelevant, harmless, or insufficiently understood should be preserved rather than "cleaned up."

---

## 24. Open Questions

The following are intentionally not frozen by this ADR:

- exact GGUF quantization for each local model;
- exact llama.cpp build and runtime tuning;
- final prompt templates;
- final Pydantic schemas;
- exact tool registry;
- exact web search/retrieval provider;
- thresholds for escalation;
- project-specific semantic-stability metrics;
- selection policy for the frontier reviewer;
- whether particular task classes require mandatory independent model review;
- future replacement of current reference checkpoints.

These should be decided through measurement and subsequent ADRs.

---

## 25. Decision Summary

Platform Compiler adopts a **local-first, role-based, evidence-driven LLM architecture**.

The initial reference stack is:

```text
Technical Analysis
    -> Nemotron 3 Nano

Deep Technical Analysis
    -> Nemotron 3 Super

General Reasoning and Solution Synthesis
    -> GPT-OSS 20B / high reasoning

Deep Solution Synthesis
    -> GPT-OSS 120B / high reasoning

Optional Frontier Review
    -> Kilo AI Gateway / selected frontier model

Local Serving
    -> llama.cpp

Integration Contract
    -> OpenAI-compatible provider abstraction

Development Assistance
    -> GitHub Copilot Max and Kilo Code
```

The architecture is based on **roles, evidence, and verification boundaries**, not permanent loyalty to particular model names.

The defining invariant is:

> **The LLM may determine what should be investigated and may propose what should be changed, but only verified evidence determines what the Platform Compiler accepts.**
