# Step 1 Output Contract

## 1. Required files

A completed Step 1 run produces:

```text
report.json
report.md
sources.json
run.json
```

No private chain-of-thought is stored.

## 2. `report.json`

`report.json` is the primary machine-readable Platform Specification.

Minimum top-level structure:

```json
{
  "schema_version": "1",
  "stage": "step_1_platform_specification",
  "status": "complete_with_unknowns",
  "platform": {},
  "cpu": {},
  "memory": {},
  "numa": {},
  "pci": {},
  "firmware": {},
  "acpi": {},
  "iommu": {},
  "contradictions": [],
  "unknowns": [],
  "limitations": [],
  "evidence_refs": []
}
```

Allowed stage status values:

```text
complete
complete_with_unknowns
partial
failed
```

A missing fact must not be represented as a fabricated value.

Where a field requires epistemic state, use one of:

```text
known
unknown
unavailable
not_applicable
not_collected
conflicting_sources
```

Values that depend on sources should carry source/evidence references or point to a normalized evidence record.

## 3. `report.md`

Human-readable technical platform passport derived from `report.json`.

It should include:

- platform identity summary;
- CPU/topology summary;
- CPU capability summary;
- memory/NUMA summary;
- PCIe/I/O topology summary;
- firmware/ACPI inventory summary;
- contradictions;
- unknowns;
- execution limitations.

It must not add diagnoses or remediation recommendations absent from `report.json`.

## 4. `sources.json`

Minimum conceptual structure:

```json
{
  "schema_version": "1",
  "sources": [
    {
      "id": "source-id",
      "class": "observed_target",
      "kind": "sysfs",
      "locator": "/sys/...",
      "description": "...",
      "observed_at": "...",
      "content_sha256": null
    }
  ]
}
```

Recommended source classes:

```text
observed_target
deterministic_derived
external_authoritative
reference_platform
model_inference
```

For external sources, preserve title/provider/URL or another reproducible locator when available.

For local file artifacts, preserve hashes when practical.

## 5. `run.json`

Minimum conceptual structure:

```json
{
  "schema_version": "1",
  "stage": "step_1_platform_specification",
  "status": "complete",
  "started_at": "...",
  "completed_at": "...",
  "prompt": {
    "path": "prompts/step_1/PROMPT.md",
    "sha256": "..."
  },
  "model": {
    "provider": "unknown",
    "model_id": "unknown"
  },
  "repository": {
    "revision": "..."
  },
  "python": {
    "executable": ".venv/bin/python",
    "version": "..."
  },
  "commands": [],
  "generated_helpers": [],
  "limitations": [],
  "output_hashes": {}
}
```

Record what is actually known. Do not fabricate provider/model/runtime values if the harness does not expose them.

Command records should be sufficient for audit/reproduction without embedding irrelevant huge output blobs.

## 6. Contradiction record

Conceptual form:

```json
{
  "id": "contradiction-001",
  "subject": "...",
  "claim_a": {
    "value": "...",
    "source_refs": ["..."]
  },
  "claim_b": {
    "value": "...",
    "source_refs": ["..."]
  },
  "resolution": "unresolved"
}
```

Step 1 does not force causal resolution.

## 7. Unknown record

Conceptual form:

```json
{
  "field": "cpu.frequency_capability.turbo_by_active_core_count",
  "state": "unknown",
  "reason": "No authoritative value established",
  "attempted_sources": []
}
```

## 8. Validation

Before completion:

- every JSON document must parse successfully;
- output files must be non-empty;
- report JSON and Markdown must agree materially;
- no `problems.md` or `goals.md` content may appear as Step 1 evidence;
- unresolved values remain explicitly unresolved;
- no remediation section is permitted in `report.json` or `report.md`.
