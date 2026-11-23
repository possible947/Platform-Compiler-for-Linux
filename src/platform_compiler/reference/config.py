from __future__ import annotations

import tomllib
from pathlib import Path
from typing import Any, Literal

from pydantic import BaseModel, ConfigDict, Field

from platform_compiler.reference.darwin_dumped import DarwinDumpedSource
from platform_compiler.reference.source import ReferenceSource


class DarwinDumpedConfig(BaseModel):
    model_config = ConfigDict(frozen=True)

    enabled: bool = False
    type: Literal["reference_platform_repository"] = "reference_platform_repository"
    repository: Literal["possible947/DarwinDumped"] = "possible947/DarwinDumped"
    local_path: Path | None = None
    index_cache_path: Path | None = None
    network_runtime_access: Literal[False] = False


class ReferenceSourcesConfig(BaseModel):
    model_config = ConfigDict(frozen=True)

    darwin_dumped: DarwinDumpedConfig = Field(default_factory=DarwinDumpedConfig)


class KnowledgeSourcesConfig(BaseModel):
    model_config = ConfigDict(frozen=True)

    knowledge_sources: ReferenceSourcesConfig = Field(
        default_factory=ReferenceSourcesConfig
    )


def load_reference_config(path: Path) -> KnowledgeSourcesConfig:
    with path.open("rb") as config_file:
        document: dict[str, Any] = tomllib.load(config_file)
    return KnowledgeSourcesConfig.model_validate(document)


def create_darwin_dumped_source(
    config: DarwinDumpedConfig,
) -> ReferenceSource | None:
    if not config.enabled:
        return None
    if config.local_path is None:
        raise ValueError("DarwinDumped is enabled but local_path is not configured")
    return DarwinDumpedSource(
        config.local_path,
        cache_path=config.index_cache_path,
    )
