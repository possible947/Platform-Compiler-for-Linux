"""Bounded read-only access to kernel interfaces, injectable for fixture tests."""

from __future__ import annotations

import errno
import hashlib
import re
from collections.abc import Callable
from datetime import datetime, timezone
from pathlib import Path
from typing import Protocol, TypeVar

from platform_compiler.evidence.models import Provenance
from platform_compiler.snapshot.models import (
    Capture,
    CollectionError,
    CollectionStatus,
    CollectorResult,
    Observation,
)

T = TypeVar("T")
R = TypeVar("R")


def utc_now() -> datetime:
    return datetime.now(timezone.utc)


class CaptureLimitExceeded(ValueError):
    pass


class KernelReader:
    def __init__(self, proc_root: Path = Path("/proc"), sys_root: Path = Path("/sys")) -> None:
        self.proc_root = proc_root.resolve()
        self.sys_root = sys_root.resolve()

    def path(self, interface: str) -> Path:
        parts = Path(interface).parts
        if len(parts) < 2 or parts[0] != "/" or ".." in parts:
            raise ValueError("invalid kernel interface")
        roots = {"proc": self.proc_root, "sys": self.sys_root}
        root = roots.get(parts[1])
        if root is None:
            raise ValueError("interface is not procfs or sysfs")
        path = root.joinpath(*parts[2:])
        if not path.resolve().is_relative_to(root):
            raise ValueError("kernel interface escapes its filesystem")
        return path

    def read(self, interface: str) -> bytes:
        with self.path(interface).open("rb") as stream:
            content = stream.read(8 * 1024 * 1024 + 1)
        if len(content) > 8 * 1024 * 1024:
            raise CaptureLimitExceeded()
        return content

    def entries(self, interface: str) -> tuple[str, ...]:
        return tuple(sorted(path.name for path in self.path(interface).iterdir()))

    def canonical(self, interface: str) -> str:
        path = self.path(interface).resolve(strict=True)
        prefix = "/proc" if interface.startswith("/proc/") else "/sys"
        root = self.proc_root if prefix == "/proc" else self.sys_root
        return prefix + "/" + path.relative_to(root).as_posix()

    def probe(self, interface: str) -> None:
        with self.path(interface).open("rb"):
            pass


class DeferredCapture(ValueError):
    pass


class CollectionContext:
    def __init__(self, reader: KernelReader, architecture: str) -> None:
        self.reader = reader
        self.architecture = architecture


class Collector(Protocol):
    name: str

    def collect(self, context: CollectionContext) -> CollectorResult:
        ...


def error_status(error: Exception) -> CollectionStatus:
    if isinstance(error, DeferredCapture):
        return CollectionStatus.UNSUPPORTED
    if isinstance(error, PermissionError):
        return CollectionStatus.PERMISSION_DENIED
    if isinstance(error, (FileNotFoundError, NotADirectoryError)):
        return CollectionStatus.UNAVAILABLE
    if isinstance(error, OSError) and error.errno in {errno.ENOSYS, errno.EOPNOTSUPP}:
        return CollectionStatus.UNSUPPORTED
    return CollectionStatus.FAILED


class CaptureSession:
    def __init__(self, name: str, context: CollectionContext) -> None:
        self.name = name
        self.context = context
        self.started_at = utc_now()
        self.captures: list[Capture] = []
        self.errors: list[CollectionError] = []

    def problem(self, source: str, status: CollectionStatus, message: str) -> None:
        self.errors.append(CollectionError(source=source, status=status, message=message))

    def capture(
        self, interface: str, operation: Callable[[], bytes],
        transformation: str | None = None,
    ) -> bytes | None:
        now = utc_now()
        content = None
        status = CollectionStatus.SUCCESS
        error_message = None
        try:
            content = operation()
        except (OSError, ValueError, UnicodeError) as error:
            status = error_status(error)
            error_message = {
                CollectionStatus.PERMISSION_DENIED: "permission denied",
                CollectionStatus.UNAVAILABLE: "interface unavailable",
                CollectionStatus.UNSUPPORTED: "interface unsupported",
            }.get(status, "interface could not be captured")
            if isinstance(error, DeferredCapture):
                error_message = str(error)
            elif isinstance(error, CaptureLimitExceeded):
                error_message = "capture exceeds 8 MiB limit"
            self.problem(interface, status, error_message)
        digest = hashlib.sha256(content).hexdigest() if content is not None else None
        self.captures.append(Capture(
            capture_id=f"{self.name}-{len(self.captures):05d}",
            provenance=Provenance(
                source="linux-kernel", reference=interface, observed_at=now, sha256=digest,
            ),
            status=status,
            size_bytes=len(content) if content is not None else None,
            content_sha256=digest,
            transformation=transformation,
            error=error_message,
            content=content,
        ))
        return content

    def read(
        self, interface: str, transform: Callable[[bytes], bytes] | None = None,
        transformation: str | None = None,
    ) -> bytes | None:
        def operation() -> bytes:
            content = self.context.reader.read(interface)
            return transform(content) if transform else content
        return self.capture(interface, operation, transformation)

    def text(self, interface: str) -> str | None:
        content = self.read(interface)
        return self.parse(interface, content, lambda value: value.decode("ascii").strip())

    def parse(
        self, interface: str, value: T | None, parser: Callable[[T], R],
    ) -> R | None:
        if value is None:
            return None
        try:
            return parser(value)
        except (ValueError, UnicodeError, IndexError):
            self.problem(interface, CollectionStatus.FAILED, "invalid interface format")
            return None

    def integer(self, interface: str) -> int | None:
        return self.parse(interface, self.text(interface), int)

    def cpu_list(self, interface: str) -> tuple[int, ...] | None:
        return self.parse(interface, self.text(interface), parse_cpu_list)

    def entries(self, interface: str, pattern: str) -> tuple[str, ...] | None:
        def operation() -> bytes:
            names = [
                name for name in self.context.reader.entries(interface)
                if re.fullmatch(pattern, name)
            ]
            return "\n".join(names).encode("ascii")
        content = self.capture(interface, operation, "filtered_directory_inventory")
        return tuple(content.decode("ascii").splitlines()) if content is not None else None

    def finish(self, observations: Observation | None = None) -> CollectorResult:
        successes = any(c.status == CollectionStatus.SUCCESS for c in self.captures)
        if successes:
            status = CollectionStatus.PARTIAL if self.errors else CollectionStatus.SUCCESS
        elif self.errors:
            statuses = {error.status for error in self.errors}
            status = next(s for s in (
                CollectionStatus.FAILED, CollectionStatus.PERMISSION_DENIED,
                CollectionStatus.UNAVAILABLE, CollectionStatus.UNSUPPORTED,
            ) if s in statuses)
        else:
            status = CollectionStatus.UNAVAILABLE
        return CollectorResult(
            name=self.name, started_at=self.started_at, finished_at=utc_now(),
            status=status, observations=observations,
            captures=tuple(self.captures), errors=tuple(self.errors),
        )


def parse_cpu_list(value: str) -> tuple[int, ...]:
    result: set[int] = set()
    if not value:
        return ()
    for item in value.split(","):
        if not re.fullmatch(r"\d+(?:-\d+)?", item):
            raise ValueError("invalid CPU list")
        limits = [int(part) for part in item.split("-")]
        first, last = limits[0], limits[-1]
        if first > last or last > 1_048_575:
            raise ValueError("invalid CPU range")
        result.update(range(first, last + 1))
    return tuple(sorted(result))
