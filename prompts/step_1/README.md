# Step 1 Prompt Package

This directory contains the executable prompt package for **Step 1: Platform Specification**.

## Files

```text
HANDOFF.md
    Short launcher pasted into the agent input field.

PROMPT.md
    Main Step 1 instruction executed by the agent.

ADR-STEP-1-EXECUTION.md
    Step-specific decisions about role, isolation, tool use and execution mechanics.

OUTPUT-CONTRACT.md
    Durable output requirements for the Step 1 run.
```

## Normal use

1. Start the desired agent/harness in the Platform Compiler repository.
2. Paste the complete contents of `HANDOFF.md` into the agent input field.
3. The handoff assigns the Step 1 role and directs the agent to `PROMPT.md`.
4. `PROMPT.md` loads the normative project documents from `docs/` and executes the audit.
5. Review the durable Step 1 outputs before they are accepted as input to Step 2.

## Why this package exists

Repository-wide agent instructions are intentionally avoided for Step 1 because unrelated coding or maintenance agents must not automatically inherit platform-investigation behavior.

The handoff is deliberately short, while the main prompt is detailed enough to make the Step 1 role explicit and reproducible across lightweight agent harnesses and different models.

## Isolation rule

Step 1 does not consume:

```text
problems.md
goals.md
```

It performs no diagnosis and no remediation.
