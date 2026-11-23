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
  artifact identifier, opaque source locator, and SHA-256 digest. The locator
  identifies the source object for auditability; only the adapter interprets
  its format. DarwinDumped uses a repository-relative path, never a host path
  or a path outside the repository.
- A local index cache reuses hashes when file size and modification time are
  unchanged. This stat cache is a performance optimization, not a trust
  boundary: retrieval and materialization verify actual content against the
  indexed SHA-256, including when reusing an existing snapshot.
- Materialization writes a local immutable snapshot under the caller-supplied
  workspace/cache, with a manifest containing artifact hashes and complete
  provenance, including the locator. Files are placed under
  `artifacts/<artifact_id>`; generic code does not interpret repository layout.
- Per-artifact byte eligibility is checked before the artifact count limit.
  The snapshot and manifest report size and count-limit omissions separately.
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
requested artifact set. A Git reference checkout must be clean to claim its
HEAD commit: staged, modified, deleted, untracked, and ignored files cause
rejection. This deliberately conservative check includes ignored files even
when they are not artifacts, and rejects Git index flags that can hide tracked
changes (`assume-unchanged` and `skip-worktree`). Platform Compiler never
cleans, resets, stashes, or otherwise modifies the reference checkout. If the
checkout becomes dirty, or its Git revision changes, indexing and retrieval
fail closed; after the user resolves the state, a changed revision requires
an explicit index refresh.
Artifact hashes also detect content changes since indexing, including for
non-Git local sources. Repeating materialization reuses a snapshot only if its
source content, manifest, and files still match; integrity failures are
rejected rather than overwritten.

The checkout is not locked against concurrent writers. Callers must avoid
changing it while indexing or retrieving artifacts. For non-Git sources,
`working-tree` is not an immutable revision; the digest identifies the
indexed bytes, and stat-cache collisions can require the user to remove the
external index cache and refresh the index. Git checkout transformations such
as line-ending conversion may make clean working-tree bytes differ from the
commit's blob; the artifact digest always identifies the working-tree bytes.

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
