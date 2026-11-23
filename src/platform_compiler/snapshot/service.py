"""Fail-safe external storage for one read-only collection event."""

from __future__ import annotations

import hashlib
import os
import sys
import uuid
from collections.abc import Sequence
from pathlib import Path

from platform_compiler import __version__
from platform_compiler.evidence.models import Provenance
from platform_compiler.snapshot.collectors import default_collectors
from platform_compiler.snapshot.models import (
    CollectionError,
    CollectionStatus,
    CollectorResult,
    KernelEnvironment,
    SystemSnapshot,
)
from platform_compiler.snapshot.reader import (
    CollectionContext,
    Collector,
    KernelReader,
    utc_now,
)
from platform_compiler.snapshot.store import (
    MANIFEST_NAME,
    RAW_DIRECTORY,
    SNAPSHOT_ID_PATTERN,
    SNAPSHOTS_DIRECTORY,
)
from platform_compiler.workspace import Workspace


def _write_private(path: Path, content: bytes) -> None:
    fd = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL | os.O_NOFOLLOW, 0o600)
    with os.fdopen(fd, "wb") as stream:
        stream.write(content)
        stream.flush()
        os.fsync(stream.fileno())


def collect_snapshot(
    workspace: Workspace,
    *,
    context: CollectionContext | None = None,
    collectors: Sequence[Collector] | None = None,
    snapshot_id: str | None = None,
) -> tuple[SystemSnapshot, Path]:
    root = workspace.require_external()
    if context is None:
        if not sys.platform.startswith("linux"):
            raise ValueError("current-system collection is supported only on Linux")
        context = CollectionContext(KernelReader(), os.uname().machine)
    if any(root.is_relative_to(source) for source in (
        context.reader.proc_root, context.reader.sys_root,
    )):
        raise ValueError("workspace must be outside the collection interfaces")
    started = utc_now()
    identifier = snapshot_id if snapshot_id is not None else (
        started.strftime("%Y%m%dT%H%M%SZ") + "-" + uuid.uuid4().hex
    )
    if not SNAPSHOT_ID_PATTERN.fullmatch(identifier):
        raise ValueError("invalid snapshot identifier")
    snapshots = root / SNAPSHOTS_DIRECTORY
    if snapshots.is_symlink():
        raise ValueError("snapshot storage must not be a symlink")
    snapshots.mkdir(mode=0o700, exist_ok=True)
    if snapshots.resolve().parent != root:
        raise ValueError("snapshot storage escapes workspace")
    destination = snapshots / identifier
    destination.mkdir(mode=0o700)
    raw = destination / RAW_DIRECTORY
    raw.mkdir(mode=0o700)

    results = []
    selected = default_collectors() if collectors is None else collectors
    for collector_index, collector in enumerate(selected):
        collector_started = utc_now()
        try:
            result = collector.collect(context)
            if not isinstance(result, CollectorResult):
                raise ValueError("invalid collector result")
        except Exception:
            result = CollectorResult(
                name=collector.name,
                started_at=collector_started, finished_at=utc_now(),
                status=CollectionStatus.FAILED,
                errors=(CollectionError(
                    source=collector.name, status=CollectionStatus.FAILED,
                    message="collector failed unexpectedly",
                ),),
            )
        captures = []
        for capture_index, capture in enumerate(result.captures):
            if capture.status == CollectionStatus.SUCCESS:
                if capture.content is None:
                    raise ValueError("successful capture has no content")
                filename = f"{collector_index:02d}-{capture_index:05d}.bin"
                target = raw / filename
                digest = hashlib.sha256(capture.content).hexdigest()
                if (
                    digest != capture.content_sha256
                    or digest != capture.provenance.sha256
                    or len(capture.content) != capture.size_bytes
                ):
                    raise ValueError("capture content does not match its provenance")
                _write_private(target, capture.content)
                if hashlib.sha256(target.read_bytes()).hexdigest() != digest:
                    raise ValueError("persisted capture failed hash verification")
                capture = capture.model_copy(update={"raw_path": f"{RAW_DIRECTORY}/{filename}"})
            captures.append(capture)
        results.append(result.model_copy(update={"captures": tuple(captures)}))
    usable = any(
        capture.status == CollectionStatus.SUCCESS
        and capture.provenance.reference.startswith(("/proc/", "/sys/"))
        and capture.transformation not in {"filtered_directory_inventory", "existence_check"}
        for result in results for capture in result.captures
    )
    status = CollectionStatus.FAILED
    if usable:
        status = (
            CollectionStatus.SUCCESS
            if all(result.status == CollectionStatus.SUCCESS for result in results)
            else CollectionStatus.PARTIAL
        )
    kernel = next((
        result.observations for result in results
        if isinstance(result.observations, KernelEnvironment)
    ), None)
    snapshot = SystemSnapshot(
        snapshot_id=identifier, captured_at=started, finished_at=utc_now(),
        program_version=__version__, architecture=context.architecture,
        kernel_release=kernel.release if kernel else None,
        kernel_version=kernel.version if kernel else None,
        provenance=Provenance(
            source="current-linux-system", reference=identifier, observed_at=started,
        ),
        status=status, collectors=tuple(results),
    )
    temporary_manifest = destination / ".manifest.json.tmp"
    _write_private(temporary_manifest, (snapshot.model_dump_json(indent=2) + "\n").encode("utf-8"))
    os.link(temporary_manifest, destination / MANIFEST_NAME)
    temporary_manifest.unlink()
    directory = os.open(destination, os.O_RDONLY | os.O_DIRECTORY)
    try:
        os.fsync(directory)
    finally:
        os.close(directory)
    return snapshot, destination
