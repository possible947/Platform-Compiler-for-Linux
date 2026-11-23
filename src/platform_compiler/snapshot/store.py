"""Verified offline access to a published snapshot; treats the snapshot as untrusted."""

from __future__ import annotations

import hashlib
import os
import re
import stat
from pathlib import Path, PurePosixPath
from typing import TypeVar

from pydantic import ValidationError

from platform_compiler.snapshot.models import (
    Capture,
    CollectionStatus,
    SystemSnapshot,
)
from platform_compiler.workspace import Workspace

SNAPSHOTS_DIRECTORY = "snapshots"
MANIFEST_NAME = "manifest.json"
RAW_DIRECTORY = "raw"
SNAPSHOT_ID_PATTERN = re.compile(r"[a-zA-Z0-9][a-zA-Z0-9_-]{0,95}")
CAPTURE_ID_PATTERN = re.compile(r"[a-z0-9][a-z0-9_-]{0,63}")
_MANIFEST_LIMIT = 256 * 1024 * 1024
_SHA256 = re.compile(r"[0-9a-f]{64}")

O = TypeVar("O")


def _read_regular(path: Path, limit: int) -> bytes:
    """Read a regular, non-symlinked file with an explicit size bound."""
    fd = os.open(path, os.O_RDONLY | os.O_NOFOLLOW)
    with os.fdopen(fd, "rb", buffering=0) as stream:
        if not stat.S_ISREG(os.fstat(stream.fileno()).st_mode):
            raise ValueError(f"not a regular file: {path.name}")
        chunks = []
        total = 0
        while chunk := stream.read(min(1024 * 1024, limit + 1 - total)):
            total += len(chunk)
            if total > limit:
                raise ValueError(f"file exceeds expected size: {path.name}")
            chunks.append(chunk)
    return b"".join(chunks)


def _real_directory(path: Path, parent: Path) -> Path:
    if path.is_symlink() or not path.is_dir():
        raise ValueError(f"not a directory: {path}")
    if path.resolve().parent != parent.resolve():
        raise ValueError(f"directory escapes its parent: {path}")
    return path


class StoredSnapshot:
    """A published snapshot opened read-only; capture bytes are verified on every read."""

    def __init__(self, root: Path, snapshot: SystemSnapshot, manifest_sha256: str) -> None:
        self.root = root
        self.snapshot = snapshot
        self.manifest_sha256 = manifest_sha256
        self._captures: dict[str, Capture] = {}
        raw_paths: set[str] = set()
        for result in snapshot.collectors:
            for capture in result.captures:
                if not CAPTURE_ID_PATTERN.fullmatch(capture.capture_id):
                    raise ValueError(f"invalid capture identifier: {capture.capture_id!r}")
                if capture.capture_id in self._captures:
                    raise ValueError(f"duplicate capture identifier: {capture.capture_id}")
                self._validate_capture(capture)
                if capture.raw_path is not None:
                    if capture.raw_path in raw_paths:
                        raise ValueError(f"duplicate capture raw path: {capture.raw_path}")
                    raw_paths.add(capture.raw_path)
                self._captures[capture.capture_id] = capture

    @staticmethod
    def _validate_capture(capture: Capture) -> None:
        if capture.status != CollectionStatus.SUCCESS:
            if capture.raw_path is not None:
                raise ValueError(f"unsuccessful capture has raw evidence: {capture.capture_id}")
            return
        if (
            capture.raw_path is None or capture.size_bytes is None
            or capture.content_sha256 is None
            or not _SHA256.fullmatch(capture.content_sha256)
        ):
            raise ValueError(f"successful capture lacks integrity data: {capture.capture_id}")
        if capture.provenance.sha256 != capture.content_sha256:
            raise ValueError(f"capture and provenance hashes disagree: {capture.capture_id}")
        path = PurePosixPath(capture.raw_path)
        if (
            path.is_absolute() or len(path.parts) != 2 or path.parts[0] != RAW_DIRECTORY
            or path.name in {"", ".", ".."} or "\\" in capture.raw_path
            or path.as_posix() != capture.raw_path
        ):
            raise ValueError(f"capture raw path escapes raw evidence: {capture.capture_id}")

    def capture(self, capture_id: str) -> Capture:
        try:
            return self._captures[capture_id]
        except KeyError:
            raise ValueError(f"unknown capture identifier: {capture_id}") from None

    def captures(self) -> tuple[Capture, ...]:
        return tuple(self._captures.values())

    def read_capture(self, capture_id: str) -> bytes:
        """Return raw evidence only after containment, size and SHA-256 verification."""
        capture = self.capture(capture_id)
        if capture.status != CollectionStatus.SUCCESS or capture.raw_path is None:
            raise ValueError(
                f"capture has no raw evidence ({capture.status.value}): {capture_id}"
            )
        raw = _real_directory(self.root / RAW_DIRECTORY, self.root)
        path = raw / PurePosixPath(capture.raw_path).name
        if path.is_symlink() or path.resolve().parent != raw.resolve():
            raise ValueError(f"capture raw path escapes raw evidence: {capture_id}")
        content = _read_regular(path, capture.size_bytes)
        if (
            len(content) != capture.size_bytes
            or hashlib.sha256(content).hexdigest() != capture.content_sha256
        ):
            raise ValueError(f"capture failed integrity verification: {capture_id}")
        return content

    def verify(self) -> int:
        """Verify every persisted capture; return the number verified."""
        verified = 0
        for capture in self._captures.values():
            if capture.raw_path is not None:
                self.read_capture(capture.capture_id)
                verified += 1
        return verified

    def observation(self, kind: type[O]) -> O | None:
        return next((
            result.observations for result in self.snapshot.collectors
            if isinstance(result.observations, kind)
        ), None)


def snapshot_directory(workspace: Workspace, snapshot_id: str) -> Path:
    if not SNAPSHOT_ID_PATTERN.fullmatch(snapshot_id):
        raise ValueError("invalid snapshot identifier")
    root = workspace.require_external()
    snapshots = _real_directory(root / SNAPSHOTS_DIRECTORY, root)
    path = snapshots / snapshot_id
    if not path.exists() and not path.is_symlink():
        raise ValueError(f"snapshot does not exist: {snapshot_id}")
    return _real_directory(path, snapshots)


def open_snapshot(workspace: Workspace, snapshot_id: str) -> StoredSnapshot:
    """Open ``<workspace>/snapshots/<snapshot_id>`` without modifying it."""
    path = snapshot_directory(workspace, snapshot_id)
    manifest_path = path / MANIFEST_NAME
    if not manifest_path.exists() and not manifest_path.is_symlink():
        raise ValueError(f"snapshot is incomplete (no manifest): {snapshot_id}")
    try:
        manifest = _read_regular(manifest_path, _MANIFEST_LIMIT)
    except OSError as error:
        raise ValueError(f"snapshot manifest is unreadable: {snapshot_id}") from error
    try:
        snapshot = SystemSnapshot.model_validate_json(manifest)
    except ValidationError as error:
        raise ValueError(
            f"snapshot manifest is invalid or has an unsupported schema: {snapshot_id}"
        ) from error
    if snapshot.snapshot_id != snapshot_id:
        raise ValueError("snapshot manifest identifier does not match its directory")
    return StoredSnapshot(path, snapshot, hashlib.sha256(manifest).hexdigest())
