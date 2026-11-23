"""Role-based inference configuration and provider routing."""

from platform_compiler.inference.config import (
    InferenceConfig,
    InferenceRole,
    RoleConfig,
    load_inference_config,
)
from platform_compiler.inference.provider import (
    InferenceProvider,
    InferenceRecord,
    InferenceRequest,
    InferenceRouter,
)

__all__ = [
    "InferenceConfig",
    "InferenceProvider",
    "InferenceRecord",
    "InferenceRequest",
    "InferenceRole",
    "InferenceRouter",
    "RoleConfig",
    "load_inference_config",
]
