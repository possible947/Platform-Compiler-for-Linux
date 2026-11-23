# Local reference-platform sources

DarwinDumped is an optional, read-only source of comparative examples from real
Apple hardware. It is evidence for investigation, not a collection of patches:
Apple firmware descriptions are not assumed correct for another vendor, and
reference constants, ACPI objects, resources, device properties, or PCI data
must never be copied into a target model without independent target evidence.

## Configuration and offline behavior

Set `enabled = true` and provide an existing local checkout in the root TOML
configuration. An optional index cache path stores the deterministic index and
file metadata outside the source checkout. `network_runtime_access` is
deliberately restricted to `false`; indexing, matching, retrieval, and
comparison only read the configured local directory. CI uses synthetic
temporary trees and does not clone DarwinDumped.

```toml
[knowledge_sources.darwin_dumped]
enabled = true
type = "reference_platform_repository"
repository = "possible947/DarwinDumped"
local_path = "/path/to/local/DarwinDumped"
index_cache_path = "/path/to/cache/darwindumped-index.json"
network_runtime_access = false
```

The source is disabled by default. `create_darwin_dumped_source` fails
explicitly when it is enabled without `local_path`.

## Discovery, indexing, and provenance

The adapter discovers the current `ProductFamily/Model` directory hierarchy,
including family and model names it has never seen before. A suffix such as
`(Retail Demo)` is retained as a sample identifier for the base model; an
unsuffixed model has the `default` sample identifier. DarwinDumped is currently
organized into artifact-category directories under each model. Recognized
directory names map to ACPI, DMI, PCI/LSPCI, IORegistry, CPU, memory, device
properties, power, RTC, NVRAM, SMC, kernel, boot, and system-profiler classes.
All files are indexed, including unrecognized names and categories, as `other`
artifacts with their original paths retained. Missing categories are explicitly
listed rather than inferred to be empty. Repository-level files that do not
belong to a model are retained separately as unclassified index entries.

Index rows include an index/parser version, source revision when the local
checkout exposes one, sorted relative source paths, SHA-256 content digests,
sample identity, and artifact category. An optional cache reuses hashes for
files whose recorded size and modification time are unchanged; changed or new
files are hashed again. No timestamp or network-fetched revision is needed for
an index to be reproducible.

Raw files remain the authoritative representation. Parsers are optional,
replaceable implementations of `ArtifactParser`; a parser result retains the
raw digest and provenance and records `PARSED`, `PARTIALLY_PARSED`,
`UNSUPPORTED`, or `FAILED`. A parser failure affects that artifact only.
Provenance identifies the repository, revision if available, model/sample,
relative path, digest, parser, parser version, and status.

## Matching and targeted context

`ReferenceSource` is the generic interface; `DarwinDumpedSource` implements
local discovery and artifact reads. Future corpora can implement the same
interface without exposing their repository paths to diagnostic consumers.
The initial matcher compares only factual feature dimensions supplied by
platform observations or trusted extractors: CPU family/generation, chipset,
package count, PCIe topology, GPU class, device IDs, ACPI characteristics,
power architecture, and memory topology. It does not score model-name
similarity. Exact matches, mismatches, and unknown dimensions are returned
alongside a simple unweighted score; `CandidateScorer` can be replaced as
evaluation evidence develops. A `ReferenceFeatureExtractor` can derive
candidate facts from local artifacts; target inputs use a separate
`TargetPlatformProfile` explicitly marked `observed_target`. If no factual
dimension matches, no candidate is selected. Each target feature carries
evidence IDs, and each reference feature carries artifact provenance; both are
preserved on the match explanation. Equal-scoring candidates are not arbitrarily
selected. Requested categories that are absent are labeled explicitly in the
retrieved context. Physical hardware, firmware-provided,
presented/spoofed, OS-interpreted, and reference identities remain separate;
matching uses factual hardware features rather than spoofed or model names.

The context builder retrieves only requested artifact classes for a selected
candidate, caps per-artifact excerpt size, and labels each block
`REFERENCE-PLATFORM`. This material must remain distinguishable from
`observed_target` evidence and AI-derived hypotheses; it cannot be silently
promoted to a target CPM fact.

## Safety and limitations

Reference comparisons do not select an intervention layer. `evaluate_native_gate`
requires target-side evidence and native-path evaluation before declaring an
escalation eligible; reference-only evidence is always insufficient. ACPI
comparison currently accepts normalized object-path/value maps and reports
structural differences as observations, optionally correlating paths with
device identities. Differences are not defects, and this integration does not
generate ASL patches or replace the project's deterministic ACPI validation
path. Missing/unparseable inputs remain insufficient or failed evidence, not
success-shaped comparisons.

DarwinDumped does not currently provide a uniform machine-readable hardware
feature schema. Until suitable parsers/extractors are added and evaluated,
matching dimensions absent from both target and reference remain explicitly
unknown; names are not used as a fallback.
