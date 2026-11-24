# Platform Audit Prompt v2

## Mission
Execute **Step 1 — Platform Specification** only. Your primary task is to complete the questionnaire, not to write an essay and not to diagnose the machine.

Read first:

1. `docs/platform-preparation-protocol.md`
2. `prompts/platform-preparation/01-platform-specification/platform-audit-questionnaire.md`
3. `prompts/platform-preparation/01-platform-specification/platform-audit-report-template.md`

The protocol is normative. The questionnaire defines required coverage. The report template defines presentation.

## Stage isolation
Do not read or use `problems.md`, `goals.md`, previous diagnoses, preferred fixes, Hackintosh/macOS conclusions, reference-platform conclusions, or hidden developer hypotheses. Do not diagnose or tune.

## Primary completion rule
Every questionnaire item must end in exactly one terminal state:

- `observed`
- `deterministically_derived`
- `externally_documented`
- `conflicting`
- `unavailable`
- `unknown`
- `not_applicable`

Never omit an item because it appears unimportant. Never use `unknown` as a shortcut. Before returning `unknown` or `unavailable`, perform every applicable acquisition path listed for the item and record the attempts and dispositions.

## Evidence discipline
For each value record:

- value and unit;
- terminal state;
- evidence/source reference;
- acquisition method;
- scope when relevant (`system`, `socket`, `die`, `core`, `thread`, `NUMA node`, `PCI function`);
- uncertainty/conflict notes.

Do not promote documentation to target observation. Do not promote inference to evidence. Do not invent hashes, timestamps, command results, URLs, document locators, model identity, or execution metadata. Those fields belong to the harness.

## Research behavior
Use local read-only evidence first, then authoritative external sources where the questionnaire requests documented capability. Prefer manufacturer documentation, official specifications, official kernel documentation/source, then reliable secondary sources. Record an exact URL or document identifier for external facts.

If a requested local fact needs elevated privileges:

- in an unprivileged run: record the failed acquisition and mark the field `unavailable` when no safe fallback exists;
- in a privileged run: use the least invasive read-only mechanism available.

Do not change firmware, BIOS options, kernel command line, governors, MSRs, power limits, affinities, IRQ policy, runtime PM, ASPM policy, device state, ACPI state, sysctls, or persistent configuration. Privilege expands read access only.

## Cross-check rule
Complete every `CHECK.*` questionnaire item. A cross-check may reveal a contradiction; record it neutrally without diagnosing its cause.

## Output
Write target-specific outputs only under the external preparation workspace:

```text
<workspace>/preparation/<case-id>/step-01-platform-specification/
    questionnaire.json
    report.json
    report.md
    sources.json
    run.json
```

`questionnaire.json` is the primary completion artifact. `report.json` is the normalized machine-readable platform passport. `report.md` is the human-readable rendering/synthesis. `sources.json` and `run.json` are harness-owned provenance artifacts; do not fabricate missing provenance.

## Done condition
Do not stop merely because platform identity is known. Stop only when every questionnaire item has a terminal state and the report explicitly lists all unresolved/conflicting items. Do not start Step 2.
