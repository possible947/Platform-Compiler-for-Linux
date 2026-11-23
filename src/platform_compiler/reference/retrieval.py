from __future__ import annotations

from platform_compiler.reference.models import (
    ArtifactClass,
    ReferenceCandidate,
    ReferenceContext,
    RetrievedReferenceArtifact,
)
from platform_compiler.reference.source import ReferenceSource


def build_reference_context(
    source: ReferenceSource,
    candidate: ReferenceCandidate,
    question: str,
    artifact_classes: tuple[ArtifactClass, ...],
    *,
    max_artifacts: int = 8,
    max_bytes_per_artifact: int = 16_384,
) -> ReferenceContext:
    """Retrieve only requested classes and label every excerpt as reference evidence."""
    if max_artifacts < 0:
        raise ValueError("max_artifacts must not be negative")
    if max_bytes_per_artifact < 1:
        raise ValueError("max_bytes_per_artifact must be positive")
    platform = candidate.platform
    model = next(
        (item for item in source.list_platforms() if item.identity == platform),
        None,
    )
    if model is None:
        raise ValueError("reference candidate is not present in the configured source")
    missing_classes = tuple(
        artifact_class
        for artifact_class in artifact_classes
        if artifact_class not in model.available_artifact_classes
    )
    all_artifacts = source.get_artifacts(platform, artifact_classes)
    artifacts = all_artifacts[:max_artifacts]
    retrieved: list[RetrievedReferenceArtifact] = []
    for artifact in artifacts:
        raw, truncated = source.read_excerpt(artifact, max_bytes_per_artifact)
        content = raw.decode("utf-8", errors="replace")
        retrieved.append(
            RetrievedReferenceArtifact(
                artifact=artifact,
                content=content,
                truncated=truncated,
            )
        )
    return ReferenceContext(
        diagnostic_question=question,
        candidate=candidate,
        requested_classes=artifact_classes,
        missing_requested_classes=missing_classes,
        artifacts=tuple(retrieved),
        omitted_artifact_count=max(0, len(all_artifacts) - len(artifacts)),
    )


def render_reference_context(context: ReferenceContext) -> str:
    """Render bounded excerpts with non-ambiguous reference-platform provenance."""
    blocks = [
        "REFERENCE-PLATFORM EVIDENCE ONLY; not facts about the target machine.",
        f"Diagnostic question: {context.diagnostic_question}",
        (
            "Reference candidate: "
            f"{context.candidate.platform.vendor} "
            f"{context.candidate.platform.model_identifier} "
            f"(sample {context.candidate.platform.sample_identifier}; "
            f"score {context.candidate.score:.3f})"
        ),
    ]
    if context.missing_requested_classes:
        classes = ", ".join(item.value for item in context.missing_requested_classes)
        blocks.append(f"Missing requested reference categories: {classes}")
    if context.omitted_artifact_count:
        blocks.append(
            f"Reference artifacts omitted by retrieval limit: "
            f"{context.omitted_artifact_count}"
        )
    for feature in context.candidate.matched_features:
        paths = ", ".join(item.relative_path for item in feature.reference_provenance)
        blocks.append(
            f"Matched hardware feature {feature.feature}: "
            f"target={feature.target_value!r}, reference={feature.reference_value!r}; "
            f"target evidence={feature.target_evidence_ids}; reference paths={paths}"
        )
    for feature in context.candidate.mismatched_features:
        paths = ", ".join(item.relative_path for item in feature.reference_provenance)
        blocks.append(
            f"Mismatched hardware feature {feature.feature}: "
            f"target={feature.target_value!r}, reference={feature.reference_value!r}; "
            f"target evidence={feature.target_evidence_ids}; reference paths={paths}"
        )
    if context.candidate.unknown_features:
        blocks.append(
            "Unknown matching dimensions: "
            + ", ".join(context.candidate.unknown_features)
        )
    for retrieved in context.artifacts:
        artifact = retrieved.artifact
        blocks.extend(
            [
                (
                    f"[REFERENCE {artifact.artifact_class.value}] "
                    f"{artifact.provenance.repository}@"
                    f"{artifact.provenance.revision or 'unknown-revision'}:"
                    f"{artifact.relative_path} "
                    f"sha256={artifact.content_sha256}; "
                    f"parser={artifact.provenance.parser}@"
                    f"{artifact.provenance.parser_version}; "
                    f"status={artifact.provenance.parse_status.value}"
                ),
                "[BEGIN UNTRUSTED REFERENCE ARTIFACT]",
                retrieved.content,
                "[END UNTRUSTED REFERENCE ARTIFACT]",
                "[excerpt truncated]" if retrieved.truncated else "",
            ]
        )
    return "\n".join(block for block in blocks if block)
