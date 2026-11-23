from __future__ import annotations

import tomllib
from enum import StrEnum
from pathlib import Path
from typing import Any

from pydantic import BaseModel, ConfigDict, Field, HttpUrl


class InferenceRole(StrEnum):
    RUNTIME_FORENSIC_ANALYZER = "runtime_forensic_analyzer"
    DEEP_RUNTIME_FORENSIC_ANALYZER = "deep_runtime_forensic_analyzer"
    REPAIR_ENGINEER = "repair_engineer"
    DEEP_REPAIR_ENGINEER = "deep_repair_engineer"
    FRONTIER_REVIEWER = "frontier_reviewer"


class RoleConfig(BaseModel):
    """Model-independent OpenAI-compatible endpoint and role assignment."""

    model_config = ConfigDict(frozen=True)

    provider: str = "local"
    endpoint: HttpUrl
    model: str
    api_key_env: str | None = None
    reasoning_effort: str | None = None


class InferenceConfig(BaseModel):
    model_config = ConfigDict(frozen=True)

    roles: dict[InferenceRole, RoleConfig] = Field(default_factory=dict)


def load_inference_config(path: Path) -> InferenceConfig:
    """Load role assignments from TOML without requiring a running provider."""
    with path.open("rb") as config_file:
        document: dict[str, Any] = tomllib.load(config_file)
    if "inference" not in document:
        raise ValueError(f"missing [inference] configuration in {path}")
    return InferenceConfig.model_validate(document["inference"])
