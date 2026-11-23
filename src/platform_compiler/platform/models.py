from __future__ import annotations

from pydantic import BaseModel, ConfigDict, Field


class ExecutionDomain(BaseModel):
    """A topology grouping relevant to an execution or placement decision."""

    model_config = ConfigDict(frozen=True)

    identifier: str
    cpu_ids: tuple[int, ...] = ()
    numa_node: int | None = None
    device_ids: tuple[str, ...] = ()


class WorkloadProfile(BaseModel):
    """Workload intent, separate from the identity of the physical platform."""

    model_config = ConfigDict(frozen=True)

    name: str
    priorities: dict[str, int] = Field(default_factory=dict)
