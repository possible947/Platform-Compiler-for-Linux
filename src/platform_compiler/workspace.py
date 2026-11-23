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
