from __future__ import annotations

from typing import Protocol

from platform_compiler.reference.models import (
    CandidateFeature,
    ReferenceFeatureFact,
    ReferenceCandidate,
    ReferencePlatformModel,
    ReferenceSelection,
    TargetFeatureFact,
    TargetPlatformProfile,
)
from platform_compiler.reference.source import ReferenceSource

FEATURE_DIMENSIONS = (
    "cpu_family",
    "cpu_generation",
    "chipset_generation",
    "cpu_packages",
    "pcie_topology",
    "gpu_class",
    "device_ids",
    "acpi_characteristics",
    "power_architecture",
    "memory_topology",
)

class CandidateScorer(Protocol):
    def score(
        self,
        target: dict[str, TargetFeatureFact],
        reference: dict[str, ReferenceFeatureFact],
        platform: ReferencePlatformModel,
    ) -> ReferenceCandidate:
        ...


class ReferenceFeatureExtractor(Protocol):
    """Extract factual candidate dimensions from indexed local artifacts."""

    def extract(
        self,
        platform: ReferencePlatformModel,
        source: ReferenceSource,
    ) -> dict[str, ReferenceFeatureFact]:
        ...


class ExactFeatureScorer:
    """Unweighted exact matching; candidate names are never scoring inputs."""

    def score(
        self,
        target: dict[str, TargetFeatureFact],
        reference: dict[str, ReferenceFeatureFact],
        platform: ReferencePlatformModel,
    ) -> ReferenceCandidate:
        matched: list[CandidateFeature] = []
        mismatched: list[CandidateFeature] = []
        unknown: list[str] = []
        for key in FEATURE_DIMENSIONS:
            target_fact = target.get(key)
            reference_fact = reference.get(key)
            if target_fact is None or reference_fact is None:
                unknown.append(key)
            elif target_fact.value == reference_fact.value:
                matched.append(
                    CandidateFeature(
                        feature=key,
                        target_value=target_fact.value,
                        reference_value=reference_fact.value,
                        target_evidence_ids=target_fact.evidence_ids,
                        reference_provenance=reference_fact.provenance,
                    )
                )
            else:
                mismatched.append(
                    CandidateFeature(
                        feature=key,
                        target_value=target_fact.value,
                        reference_value=reference_fact.value,
                        target_evidence_ids=target_fact.evidence_ids,
                        reference_provenance=reference_fact.provenance,
                    )
                )
        comparable = len(matched) + len(mismatched)
        score = len(matched) / comparable if comparable else 0.0
        return ReferenceCandidate(
            platform=platform.identity,
            score=score,
            matched_features=tuple(matched),
            mismatched_features=tuple(mismatched),
            unknown_features=tuple(unknown),
        )


def select_reference_candidates(
    target: TargetPlatformProfile,
    platforms: tuple[ReferencePlatformModel, ...],
    scorer: CandidateScorer | None = None,
    *,
    feature_extractor: ReferenceFeatureExtractor | None = None,
    source: ReferenceSource | None = None,
) -> ReferenceSelection:
    if feature_extractor is not None and source is None:
        raise ValueError(
            "a local reference source is required by the feature extractor"
        )
    strategy = scorer or ExactFeatureScorer()
    candidates = [
        strategy.score(
            target.features,
            (
                feature_extractor.extract(platform, source)
                if feature_extractor is not None and source is not None
                else platform.features
            ),
            platform,
        )
        for platform in platforms
    ]
    candidates.sort(
        key=lambda item: (
            -item.score,
            item.platform.vendor,
            item.platform.product_family,
            item.platform.model_identifier,
            item.platform.sample_identifier,
        )
    )
    has_unique_leader = len(candidates) == 1 or (
        len(candidates) > 1 and candidates[0].score > candidates[1].score
    )
    selected = (
        candidates[0]
        if candidates and candidates[0].matched_features and has_unique_leader
        else None
    )
    return ReferenceSelection(candidates=tuple(candidates), selected=selected)
