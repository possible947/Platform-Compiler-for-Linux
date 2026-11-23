"""Read-only current-system observation, independent of reference and inference."""

from platform_compiler.snapshot.models import CollectionStatus, SystemSnapshot
from platform_compiler.snapshot.service import collect_snapshot

__all__ = ["CollectionStatus", "SystemSnapshot", "collect_snapshot"]
