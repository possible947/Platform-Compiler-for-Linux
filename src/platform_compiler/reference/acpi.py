from __future__ import annotations

from collections.abc import Mapping

from platform_compiler.reference.models import (
    ACPIComparisonResult,
    ACPIDifference,
    ACPIResultStatus,
)


def compare_acpi_structure(
    target: Mapping[str, str] | None,
    reference: Mapping[str, str] | None,
    *,
    target_evidence_ids: tuple[str, ...] = (),
    reference_evidence_ids: tuple[str, ...] = (),
    target_device_paths: Mapping[str, str] | None = None,
    reference_device_paths: Mapping[str, str] | None = None,
    parse_error: str | None = None,
) -> ACPIComparisonResult:
    """Compare normalized object-path/value maps; differences are not defect claims."""
    if parse_error is not None:
        return ACPIComparisonResult(
            status=ACPIResultStatus.FAILED,
            target_evidence_ids=target_evidence_ids,
            reference_evidence_ids=reference_evidence_ids,
            error=parse_error,
        )
    if not target or not reference:
        return ACPIComparisonResult(
            status=ACPIResultStatus.INSUFFICIENT_EVIDENCE,
            target_evidence_ids=target_evidence_ids,
            reference_evidence_ids=reference_evidence_ids,
        )
    target_devices = target_device_paths or {}
    reference_devices = reference_device_paths or {}
    differences = tuple(
        ACPIDifference(
            path=path,
            target_value=target.get(path),
            reference_value=reference.get(path),
            target_device_id=target_devices.get(path),
            reference_device_id=reference_devices.get(path),
        )
        for path in sorted(set(target) | set(reference))
        if target.get(path) != reference.get(path)
    )
    return ACPIComparisonResult(
        status=ACPIResultStatus.MODIFIED if differences else ACPIResultStatus.UNCHANGED,
        differences=differences,
        target_evidence_ids=target_evidence_ids,
        reference_evidence_ids=reference_evidence_ids,
    )
