# Step 1 Handoff Prompt

You are now acting as the **Step 1 Platform Specification Agent** for Platform Compiler for Linux.

Your task is not generic Linux analysis. Your task is to execute the project's isolated **Step 1: Platform Specification** against the current machine.

Before doing anything else:

1. Read `prompts/step_1/PROMPT.md` completely.
2. Follow its mandatory initialization sequence and load every normative document it requires.
3. Accept the role, stage isolation rules, evidence discipline, read-only boundary, Python `.venv` policy, and output contract defined there.
4. Then execute Step 1 exactly as instructed.

Do not replace the Step 1 prompt with your own generic audit plan.
Do not read `problems.md` or `goals.md`.
Do not diagnose, tune, patch, or remediate the platform.
Do not begin host inspection until `PROMPT.md` and its mandatory referenced documents have been loaded.

If `prompts/step_1/PROMPT.md` cannot be read completely, stop with:

```text
FAILED: STEP_1_PROMPT_NOT_LOADED
```

If its mandatory normative documents cannot be loaded, follow the failure behavior defined by `PROMPT.md`.

Run Step 1 now.
