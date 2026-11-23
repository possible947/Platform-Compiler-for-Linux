"""Minimal access to user-selected, external workspace directories."""

from __future__ import annotations

from pathlib import Path

from pydantic import BaseModel, ConfigDict


class WorkspaceConfig(BaseModel):
    """Validated handle to a local workspace; contents are not stored in Git."""

    model_config = ConfigDict(frozen=True)

    path: Path


class Workspace:
    """Validate or initialize an explicitly supplied workspace directory."""

    def __init__(self, config: WorkspaceConfig) -> None:
        self.config = config

    @classmethod
    def initialize(cls, path: Path) -> Workspace:
        if path.exists() and not path.is_dir():
            raise ValueError(f"workspace path is not a directory: {path}")
        path.mkdir(parents=True, exist_ok=True)
        return cls(WorkspaceConfig(path=path.resolve()))

    @classmethod
    def open(cls, path: Path) -> Workspace:
        if not path.is_dir():
            raise ValueError(f"workspace directory does not exist: {path}")
        return cls(WorkspaceConfig(path=path.resolve()))

    def require_external(self) -> Path:
        """Validate a capture destination before writing any target data."""
        path = self.config.path.resolve()
        if not path.is_dir():
            raise ValueError("workspace directory does not exist")
        for protected in (Path("/proc"), Path("/sys"), Path("/dev")):
            if path.is_relative_to(protected):
                raise ValueError("workspace must not be in a kernel/device filesystem")
        for parent in (path, *path.parents):
            if (parent / ".git").exists():
                raise ValueError("capture workspace must be outside Git repositories")
        source_root = Path(__file__).resolve().parents[2]
        if (source_root / "pyproject.toml").is_file() and path.is_relative_to(source_root):
            raise ValueError("capture workspace must be outside the source checkout")
        return path
