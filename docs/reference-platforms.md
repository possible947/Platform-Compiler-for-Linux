# Local reference artifact access

The reference layer is a data-access boundary only. The caller chooses a
reference explicitly; for the first platform the identifier is
`reference_id = "MacPro7,1"`. `ReferenceSource` retrieves artifacts for that
identifier and does not discover a best match, assess applicability, or make
verification decisions.

## What remains

- `ReferenceSource` is the generic retrieval/materialization contract.
- `LocalReferenceSource` provides hash-verified access to local artifacts.
- `DarwinDumpedSource` privately adapts the DarwinDumped repository layout to
  the generic identifier and artifact types. ProductFamily/Model directory
  structure is not exposed as a Platform Compiler domain model.
- Artifact metadata records the explicit reference identifier, source, source
  revision (Git commit, or `working-tree` when no Git metadata exists), opaque
  artifact identifier, and SHA-256 digest.
- A local index cache reuses hashes when file size and modification time are
  unchanged. Retrieval verifies content against the indexed digest.
- Materialization writes a local immutable snapshot under the caller-supplied
  workspace/cache, with a manifest containing artifact hashes and provenance.
  Files are placed under `artifacts/<artifact_id>`; source repository paths are
  not part of the generic artifact model.
- Artifact count and per-artifact byte limits bound snapshot retrieval.
- The source operates on an existing local checkout and performs no network
  access.

Example configuration:

```toml
[knowledge_sources.darwin_dumped]
enabled = true
type = "reference_platform_repository"
repository = "possible947/DarwinDumped"
local_path = "/path/to/local/DarwinDumped"
index_cache_path = "/path/to/cache/darwindumped-index.json"
network_runtime_access = false
```

The caller supplies the explicit identifier and external workspace:

```python
source = create_darwin_dumped_source(config.knowledge_sources.darwin_dumped)
snapshot = source.materialize_snapshot(
    "MacPro7,1",
    workspace_path,
    max_artifacts=8,
    max_bytes_per_artifact=16_384,
)
```

Each snapshot is keyed by the reference identifier, source revision, and
requested artifact set. If the checkout's Git revision changes, the adapter
refuses retrieval until the caller explicitly refreshes its index. Artifact
hashes also detect content changes since indexing, including for non-Git local
sources. Repeating materialization for the same request reuses the snapshot
only if its manifest and files still match; a changed snapshot is rejected
rather than overwritten.

## Intentionally removed or deferred

This milestone removes automatic hardware-feature matching, candidate scoring
and selection, feature extractors, DarwinDumped-specific selection policy,
Native Gate/reference acceptance workflows, reference-driven verification,
semantic applicability decisions, and the premature ACPI comparison
implementation.

Reference selection remains an explicit caller decision. Patch generation,
correction workflows, verification gates, semantic ACPI comparison, and
platform applicability analysis are intentionally deferred. Retrieved
reference artifacts are source material only; this layer does not promote them
to target evidence or decide whether they apply to a target.
