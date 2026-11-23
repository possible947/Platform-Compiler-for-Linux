"""Narrow adapter for an externally supplied ACPICA iASL executable.

Platform Compiler never downloads, builds or installs ACPICA. The executable is the
explicitly configured one, otherwise the first ``iasl`` on ``PATH``.
"""

from __future__ import annotations

import hashlib
import os
import re
import shutil
import subprocess
from collections.abc import Sequence
from dataclasses import dataclass
from pathlib import Path

from platform_compiler.evidence.models import ToolInvocation

IASL_ENVIRONMENT = {"LC_ALL": "C"}
_VERSION_LINE = re.compile(r"^.*\bversion\s+(\S+)\s*$", re.MULTILINE)
_VERSION_TIMEOUT = 30.0


class ToolUnavailable(ValueError):
    pass


@dataclass(frozen=True)
class IaslExecutable:
    path: Path
    sha256: str
    version: str


@dataclass(frozen=True)
class IaslRun:
    invocation: ToolInvocation
    stdout: bytes
    stderr: bytes


def _file_sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        while chunk := stream.read(1024 * 1024):
            digest.update(chunk)
    return digest.hexdigest()


def resolve_iasl(configured: Path | None = None) -> IaslExecutable:
    """Resolve a configured executable or toolchain directory, else ``iasl`` on PATH."""
    if configured is not None:
        candidate = configured.expanduser()
        if candidate.is_dir():
            candidate = candidate / "iasl"
        if not candidate.is_file() or not os.access(candidate, os.X_OK):
            raise ToolUnavailable(f"configured iasl is not an executable file: {configured}")
    else:
        found = shutil.which("iasl")
        if found is None:
            raise ToolUnavailable(
                "ACPICA iasl was not found on PATH; install the ACPICA toolchain "
                "separately or pass --iasl /path/to/iasl"
            )
        candidate = Path(found)
    executable = candidate.resolve(strict=True)
    try:
        result = subprocess.run(
            [str(executable), "-v"], capture_output=True, env=IASL_ENVIRONMENT,
            timeout=_VERSION_TIMEOUT, shell=False, check=False, stdin=subprocess.DEVNULL,
        )
    except (OSError, subprocess.SubprocessError) as error:
        raise ToolUnavailable(f"iasl could not report its version: {executable}") from error
    match = _VERSION_LINE.search(result.stdout.decode("utf-8", "replace"))
    if result.returncode != 0 or match is None:
        raise ToolUnavailable(f"iasl did not report a recognizable version: {executable}")
    return IaslExecutable(executable, _file_sha256(executable), match[1])


def run_iasl(
    iasl: IaslExecutable,
    arguments: Sequence[str],
    working_directory: Path,
    *,
    working_directory_policy: str,
    timeout: float,
) -> IaslRun:
    """Run iASL once with a fixed environment; never through a shell."""
    if _file_sha256(iasl.path) != iasl.sha256:
        raise ToolUnavailable("iasl executable changed after it was resolved")
    argv = (str(iasl.path), *arguments)
    timed_out = False
    try:
        result = subprocess.run(
            argv, cwd=working_directory, capture_output=True, env=IASL_ENVIRONMENT,
            timeout=timeout, shell=False, check=False, stdin=subprocess.DEVNULL,
        )
        stdout, stderr, status = result.stdout, result.stderr, result.returncode
    except subprocess.TimeoutExpired as error:
        timed_out = True
        stdout, stderr, status = error.stdout or b"", error.stderr or b"", None
    return IaslRun(
        invocation=ToolInvocation(
            tool="iasl", executable=str(iasl.path), executable_sha256=iasl.sha256,
            version=iasl.version, argv=argv, working_directory=working_directory_policy,
            environment=dict(IASL_ENVIRONMENT), timeout_seconds=timeout,
            timed_out=timed_out, exit_status=status,
            stdout_sha256=hashlib.sha256(stdout).hexdigest(),
            stderr_sha256=hashlib.sha256(stderr).hexdigest(),
        ),
        stdout=stdout, stderr=stderr,
    )
