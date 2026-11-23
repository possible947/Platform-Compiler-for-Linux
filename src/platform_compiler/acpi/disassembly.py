"""Offline joint iASL disassembly of a stored snapshot's boot AML definition blocks.

Raw evidence is read only through verified capture resolution and is never modified.
Derived files are published under ``<workspace>/derived/<snapshot-id>/acpi-disassembly/``.
"""

from __future__ import annotations

import hashlib
import json
import os
import re
import shutil
import tempfile
from dataclasses import dataclass
from enum import StrEnum
from pathlib import Path

from pydantic import ValidationError

from platform_compiler.acpi.iasl import IaslExecutable, resolve_iasl, run_iasl
from platform_compiler.acpi.models import (
    DERIVATION_SCHEMA_VERSION,
    ACPIDisassembly,
    DefinitionBlockInput,
    DerivationStatus,
    ExcludedTable,
    ExclusionReason,
    FileDigest,
)
from platform_compiler.evidence.models import DerivedArtifact, SourceCapture
from platform_compiler.snapshot.models import ACPIInventory, CollectionStatus
from platform_compiler.snapshot.store import StoredSnapshot, open_snapshot
from platform_compiler.workspace import Workspace

DERIVED_DIRECTORY = "derived"
DISASSEMBLY_DIRECTORY = "acpi-disassembly"
RECORD_NAME = "derivation.json"
JOINT_DISASSEMBLY_OPTION = "-da"
DEFAULT_TIMEOUT_SECONDS = 600.0
_WORKING_DIRECTORY_POLICY = (
    "private per-run staging directory; inputs staged as <capture_id>.dat"
)
_BOOT_ROOT = "/sys/firmware/acpi/tables"
_DYNAMIC_ROOT = "/sys/firmware/acpi/tables/dynamic"
_OEM_SPECIFIC = re.compile(r"OEM[0-9A-Z]")


class Publication(StrEnum):
    PUBLISHED = "published"
    REPRODUCED = "reproduced"
    NONDETERMINISTIC = "nondeterministic"
    TIMED_OUT = "timed_out"


@dataclass(frozen=True)
class DisassemblyOutcome:
    record: ACPIDisassembly
    path: Path
    publication: Publication
    differing_attempt: Path | None = None


def _table_order(name: str) -> tuple[int, int]:
    if name == "DSDT":
        return (0, 0)
    suffix = name[4:]
    return (1, int(suffix) if suffix.isdecimal() else 0)


def select_definition_blocks(
    stored: StoredSnapshot,
) -> tuple[tuple[DefinitionBlockInput, ...], tuple[ExcludedTable, ...]]:
    """Select the boot DSDT and SSDTs by parsed header; account for every other table."""
    inventory = stored.observation(ACPIInventory)
    if inventory is None:
        raise ValueError("snapshot has no ACPI inventory")
    selected: list[DefinitionBlockInput] = []
    excluded: list[ExcludedTable] = []
    for table in inventory.tables:
        capture = stored.capture(table.capture_id)
        boot = table.source == f"{_BOOT_ROOT}/{table.name}"
        signature = table.header.signature if table.header else None
        named_block = table.name[:4] in {"DSDT", "SSDT"}
        if boot and (named_block or signature in {"DSDT", "SSDT"}):
            if capture.status != CollectionStatus.SUCCESS or table.header is None:
                raise ValueError(
                    f"required definition block {table.name} is unavailable "
                    f"({capture.status.value}); joint namespace would be incomplete"
                )
            if signature != table.name[:4] or table.header.length != capture.size_bytes:
                raise ValueError(f"definition block {table.name} header is inconsistent")
            selected.append(DefinitionBlockInput(
                table_name=table.name, signature=signature,
                oem_id=table.header.oem_id, oem_table_id=table.header.oem_table_id,
                source=table.source, capture_id=capture.capture_id,
                content_sha256=capture.content_sha256, size_bytes=capture.size_bytes,
                staged_name=f"{capture.capture_id}.dat",
            ))
            continue
        if table.source.startswith(_DYNAMIC_ROOT + "/") and table.name[:4] in {"DSDT", "SSDT"}:
            reason = ExclusionReason.DYNAMIC_DEFINITION_BLOCK_DEFERRED
        elif _OEM_SPECIFIC.fullmatch(table.name[:4]):
            reason = ExclusionReason.OEM_SPECIFIC_TABLE_DEFERRED
        else:
            reason = ExclusionReason.NOT_A_BOOT_DEFINITION_BLOCK
        excluded.append(ExcludedTable(
            table_name=table.name, signature=signature, source=table.source,
            capture_id=capture.capture_id, capture_status=capture.status.value,
            content_sha256=capture.content_sha256, reason=reason,
        ))
    if [block.signature for block in selected].count("DSDT") != 1:
        raise ValueError("snapshot must contain exactly one readable boot DSDT")
    selected.sort(key=lambda block: _table_order(block.table_name))
    return tuple(selected), tuple(excluded)


def derivation_identity(
    manifest_sha256: str, inputs: tuple[DefinitionBlockInput, ...],
    iasl: IaslExecutable, arguments: tuple[str, ...],
) -> str:
    """Hash of inputs and process identity only; results never contribute."""
    identity = {
        "derivation_schema_version": DERIVATION_SCHEMA_VERSION,
        "kind": "acpi_joint_disassembly",
        "snapshot_manifest_sha256": manifest_sha256,
        "inputs": [[block.capture_id, block.content_sha256] for block in inputs],
        "iasl_executable_sha256": iasl.sha256,
        "iasl_version": iasl.version,
        "arguments": list(arguments),
    }
    encoded = json.dumps(identity, sort_keys=True, separators=(",", ":"))
    return hashlib.sha256(encoded.encode("utf-8")).hexdigest()


def _private_directory(parent: Path, name: str) -> Path:
    path = parent / name
    if path.is_symlink():
        raise ValueError(f"derived storage must not be a symlink: {path}")
    path.mkdir(mode=0o700, exist_ok=True)
    if not path.is_dir() or path.resolve().parent != parent.resolve():
        raise ValueError(f"derived storage escapes workspace: {path}")
    return path


def _write_private(path: Path, content: bytes) -> None:
    fd = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL | os.O_NOFOLLOW, 0o600)
    with os.fdopen(fd, "wb") as stream:
        stream.write(content)
        stream.flush()
        os.fsync(stream.fileno())


def _digest(root: Path, path: Path) -> FileDigest:
    content = path.read_bytes()
    return FileDigest(
        path=path.relative_to(root).as_posix(), size_bytes=len(content),
        sha256=hashlib.sha256(content).hexdigest(),
    )


def _run(
    stored: StoredSnapshot, inputs: tuple[DefinitionBlockInput, ...],
    excluded: tuple[ExcludedTable, ...], iasl: IaslExecutable,
    arguments: tuple[str, ...], derivation_id: str, staging: Path, timeout: float,
) -> ACPIDisassembly:
    work = staging / "work"
    work.mkdir(mode=0o700)
    for block in inputs:
        _write_private(work / block.staged_name, stored.read_capture(block.capture_id))
    run = run_iasl(
        iasl, arguments, work,
        working_directory_policy=_WORKING_DIRECTORY_POLICY, timeout=timeout,
    )
    for block in inputs:
        staged = work / block.staged_name
        if hashlib.sha256(staged.read_bytes()).hexdigest() != block.content_sha256:
            raise ValueError(f"iasl modified its staged input: {block.staged_name}")
        staged.unlink()
    tool = staging / "tool"
    tool.mkdir(mode=0o700)
    _write_private(tool / "stdout.txt", run.stdout)
    _write_private(tool / "stderr.txt", run.stderr)
    produced = {path.name: path for path in work.iterdir()}
    if any(path.is_symlink() or not path.is_file() for path in produced.values()):
        raise ValueError("iasl produced a non-regular output")
    expected = {Path(block.staged_name).with_suffix(".dsl").name for block in inputs}
    failure = None
    if run.invocation.timed_out:
        failure = f"iasl timed out after {timeout:g} seconds"
    elif run.invocation.exit_status != 0:
        failure = f"iasl exited with status {run.invocation.exit_status}"
    elif not expected <= produced.keys():
        failure = "iasl did not produce one DSL file per input: missing " + ", ".join(
            sorted(expected - produced.keys())
        )
    sources = tuple(
        SourceCapture(
            snapshot_id=stored.snapshot.snapshot_id, capture_id=block.capture_id,
            content_sha256=block.content_sha256,
        ) for block in inputs
    )
    artifacts: list[DerivedArtifact] = []
    diagnostics: list[FileDigest] = []
    for path in produced.values():
        path.chmod(0o600)
    if failure is None:
        for block in inputs:
            name = Path(block.staged_name).with_suffix(".dsl").name
            target = _private_directory(staging, "outputs") / name
            os.replace(produced.pop(name), target)
            digest = _digest(staging, target)
            artifacts.append(DerivedArtifact(
                artifact_path=digest.path, size_bytes=digest.size_bytes,
                content_sha256=digest.sha256, derivation_id=derivation_id,
                subject_capture_id=block.capture_id, derived_from=sources,
                derived_by=run.invocation,
            ))
    for name in sorted(produced):
        target = _private_directory(staging, "diagnostics") / name
        os.replace(produced[name], target)
        diagnostics.append(_digest(staging, target))
    work.rmdir()
    return ACPIDisassembly(
        derivation_id=derivation_id, snapshot_id=stored.snapshot.snapshot_id,
        snapshot_manifest_sha256=stored.manifest_sha256,
        status=DerivationStatus.FAILED if failure else DerivationStatus.SUCCEEDED,
        failure=failure, inputs=inputs, excluded_tables=excluded,
        invocation=run.invocation,
        stdout=_digest(staging, tool / "stdout.txt"),
        stderr=_digest(staging, tool / "stderr.txt"),
        artifacts=tuple(artifacts), diagnostics=tuple(diagnostics),
    )


def _files(record: ACPIDisassembly) -> tuple[FileDigest, ...]:
    return (
        record.stdout, record.stderr, *record.diagnostics,
        *(FileDigest(path=a.artifact_path, size_bytes=a.size_bytes, sha256=a.content_sha256)
          for a in record.artifacts),
    )


def _result(record: ACPIDisassembly) -> tuple:
    """Outcome fields only; run settings outside the identity (path, timeout) are excluded."""
    return (
        record.status, record.failure, record.invocation.exit_status,
        record.stdout, record.stderr, record.diagnostics,
        tuple((a.artifact_path, a.size_bytes, a.content_sha256) for a in record.artifacts),
    )


def load_derivation(path: Path) -> ACPIDisassembly:
    """Load a published derivation and verify every recorded file."""
    record_path = path / RECORD_NAME
    if path.is_symlink() or record_path.is_symlink() or not record_path.is_file():
        raise ValueError(f"derivation record is missing: {path}")
    try:
        record = ACPIDisassembly.model_validate_json(record_path.read_bytes())
    except ValidationError as error:
        raise ValueError(f"derivation record is invalid: {path}") from error
    if record.derivation_id != path.name.split(".", 1)[0]:
        raise ValueError(f"derivation record does not match its directory: {path}")
    for item in _files(record):
        target = path / item.path
        if (
            target.is_symlink() or not target.is_file()
            or not target.resolve().is_relative_to(path.resolve())
            or _digest(path, target) != item
        ):
            raise ValueError(f"derived file failed integrity verification: {item.path}")
    return record


def disassemble_snapshot(
    workspace: Workspace,
    snapshot_id: str,
    *,
    iasl: Path | None = None,
    timeout: float = DEFAULT_TIMEOUT_SECONDS,
) -> DisassemblyOutcome:
    """Jointly disassemble the boot DSDT/SSDT set; a failure is recorded, never retried."""
    stored = open_snapshot(workspace, snapshot_id)
    inputs, excluded = select_definition_blocks(stored)
    tool = resolve_iasl(iasl)
    arguments = (JOINT_DISASSEMBLY_OPTION, *(block.staged_name for block in inputs))
    derivation_id = derivation_identity(stored.manifest_sha256, inputs, tool, arguments)

    root = workspace.require_external()
    parent = _private_directory(
        _private_directory(_private_directory(root, DERIVED_DIRECTORY), snapshot_id),
        DISASSEMBLY_DIRECTORY,
    )
    destination = parent / derivation_id
    staging = Path(tempfile.mkdtemp(prefix=".staging-", dir=parent))
    try:
        record = _run(stored, inputs, excluded, tool, arguments, derivation_id, staging, timeout)
        encoded = (record.model_dump_json(indent=2) + "\n").encode("utf-8")
        _write_private(staging / RECORD_NAME, encoded)
        suffix = hashlib.sha256(encoded).hexdigest()[:16]
        if record.invocation.timed_out:
            # A timeout reflects the run environment, not the derivation; never canonical.
            attempt = parent / f"{derivation_id}.timed-out-{suffix}"
            if not attempt.exists():
                os.rename(staging, attempt)
            return DisassemblyOutcome(record, attempt, Publication.TIMED_OUT)
        if destination.exists() or destination.is_symlink():
            existing = load_derivation(destination)
            if _result(existing) == _result(record):
                return DisassemblyOutcome(existing, destination, Publication.REPRODUCED)
            attempt = parent / f"{derivation_id}.attempt-{suffix}"
            if not attempt.exists():
                os.rename(staging, attempt)
            return DisassemblyOutcome(
                existing, destination, Publication.NONDETERMINISTIC, differing_attempt=attempt,
            )
        os.rename(staging, destination)
        return DisassemblyOutcome(record, destination, Publication.PUBLISHED)
    finally:
        if staging.exists():
            shutil.rmtree(staging)
