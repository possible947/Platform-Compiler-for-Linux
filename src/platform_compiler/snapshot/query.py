"""Pure lookups over stored PCI observations; no inference or policy."""

from __future__ import annotations

from platform_compiler.snapshot.models import PCIDevice, PCITopology


def pci_device(topology: PCITopology, bdf: str) -> PCIDevice | None:
    wanted = bdf.lower()
    return next((device for device in topology.devices if device.bdf.lower() == wanted), None)


def pci_upstream_path(topology: PCITopology, bdf: str) -> tuple[PCIDevice, ...]:
    """Return the device followed by its observed upstream PCI functions, nearest first.

    The walk follows canonical sysfs parent paths and stops at the first parent that
    is not an observed PCI function (normally the host bridge, e.g. ``pci0000:ae``),
    which remains available as ``path[-1].parent_path``.
    """
    device = pci_device(topology, bdf)
    if device is None:
        raise ValueError(f"PCI device not observed: {bdf}")
    by_path = {item.sysfs_path: item for item in topology.devices if item.sysfs_path}
    path = [device]
    while device.parent_path in by_path:
        device = by_path[device.parent_path]
        if device in path:
            raise ValueError(f"cyclic PCI parent paths at: {device.bdf}")
        path.append(device)
    return tuple(path)


def pci_devices_on_node(topology: PCITopology, node_id: int) -> tuple[PCIDevice, ...]:
    """Devices whose kernel-reported ``numa_node`` equals ``node_id`` (``-1`` is preserved)."""
    return tuple(device for device in topology.devices if device.numa_node == node_id)
