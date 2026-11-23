from __future__ import annotations

import hashlib
from collections.abc import Mapping
from datetime import datetime, timezone
from typing import Protocol

from pydantic import BaseModel, ConfigDict

from platform_compiler.inference.config import (
    InferenceConfig,
    InferenceRole,
    RoleConfig,
)


class InferenceRequest(BaseModel):
    model_config = ConfigDict(frozen=True)

    role: InferenceRole
    prompt: str
    evidence_ids: tuple[str, ...] = ()


class InferenceRecord(BaseModel):
    """Inference provenance only; it has no verification state."""

    model_config = ConfigDict(frozen=True)

    role: InferenceRole
    provider: str
    model: str
    request_sha256: str
    response: str
    created_at: datetime


class InferenceProvider(Protocol):
    """Provider adapter contract; implementations may target local OpenAI APIs."""

    def complete(self, request: InferenceRequest, config: RoleConfig) -> str:
        """Return model output without treating it as verified evidence."""
        ...


class InferenceRouter:
    """Route role requests to injected provider adapters."""

    def __init__(
        self,
        config: InferenceConfig,
        providers: Mapping[str, InferenceProvider],
    ) -> None:
        self._config = config
        self._providers = providers

    def infer(self, request: InferenceRequest) -> InferenceRecord:
        role_config = self._config.roles.get(request.role)
        if role_config is None:
            raise ValueError(f"no inference configuration for role: {request.role}")
        provider = self._providers.get(role_config.provider)
        if provider is None:
            raise ValueError(f"no inference provider registered: {role_config.provider}")

        response = provider.complete(request, role_config)
        request_digest = hashlib.sha256(
            request.model_dump_json().encode("utf-8")
        ).hexdigest()
        return InferenceRecord(
            role=request.role,
            provider=role_config.provider,
            model=role_config.model,
            request_sha256=request_digest,
            response=response,
            created_at=datetime.now(timezone.utc),
        )
