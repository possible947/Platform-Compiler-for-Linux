"""Command-line entry point."""

from __future__ import annotations

import argparse
from pathlib import Path
from typing import Sequence

from platform_compiler import __version__
from platform_compiler.workspace import Workspace


def _build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="platform-compiler",
        description="Build verified Linux platform environments from evidence.",
    )
    commands = parser.add_subparsers(dest="command")
    commands.add_parser("version", help="show the installed version")

    workspace = commands.add_parser("workspace", help="manage an external workspace")
    workspace_commands = workspace.add_subparsers(dest="workspace_command", required=True)
    initialize = workspace_commands.add_parser("init", help="initialize an empty workspace")
    initialize.add_argument("path", type=Path, help="path outside the source checkout")
    validate = workspace_commands.add_parser("validate", help="validate a workspace directory")
    validate.add_argument("path", type=Path)

    snapshot = commands.add_parser("snapshot", help="capture read-only current-system evidence")
    snapshot_commands = snapshot.add_subparsers(dest="snapshot_command", required=True)
    collect = snapshot_commands.add_parser("collect", help="collect Linux kernel observations")
    collect.add_argument("--workspace", type=Path, required=True, help="existing external workspace")

    acpi = commands.add_parser("acpi", help="derive offline artifacts from captured ACPI tables")
    acpi_commands = acpi.add_subparsers(dest="acpi_command", required=True)
    disassemble = acpi_commands.add_parser(
        "disassemble", help="jointly disassemble a snapshot's boot DSDT/SSDT set with iASL",
    )
    disassemble.add_argument("--workspace", type=Path, required=True, help="existing external workspace")
    disassemble.add_argument("--snapshot", required=True, help="snapshot ID in the workspace")
    disassemble.add_argument(
        "--iasl", type=Path, help="ACPICA iasl executable or toolchain directory (default: PATH)",
    )
    disassemble.add_argument("--timeout", type=float, default=600.0, help="seconds (default: 600)")
    return parser


def main(argv: Sequence[str] | None = None) -> int:
    parser = _build_parser()
    args = parser.parse_args(argv)

    if args.command == "version":
        print(__version__)
        return 0
    if args.command == "workspace":
        try:
            if args.workspace_command == "init":
                Workspace.initialize(args.path)
            else:
                Workspace.open(args.path)
        except (OSError, ValueError) as error:
            parser.error(str(error))
        print(f"Workspace ready: {args.path}")
        return 0
    if args.command == "snapshot":
        from platform_compiler.snapshot import CollectionStatus, collect_snapshot

        try:
            snapshot, path = collect_snapshot(Workspace.open(args.workspace))
        except (OSError, ValueError) as error:
            parser.error(str(error))
        successful = [r.name for r in snapshot.collectors if r.status == CollectionStatus.SUCCESS]
        incomplete = [
            f"{r.name} ({r.status.value})" for r in snapshot.collectors
            if r.status != CollectionStatus.SUCCESS
        ]
        print(f"Snapshot {snapshot.snapshot_id}: {path}")
        print("Successful collectors: " + (", ".join(successful) or "none"))
        print("Partial/unavailable/failed collectors: " + (", ".join(incomplete) or "none"))
        return 1 if snapshot.status == CollectionStatus.FAILED else 0

    if args.command == "acpi":
        from platform_compiler.acpi import (
            DerivationStatus,
            Publication,
            disassemble_snapshot,
        )

        if args.timeout <= 0:
            parser.error("--timeout must be positive")
        try:
            outcome = disassemble_snapshot(
                Workspace.open(args.workspace), args.snapshot,
                iasl=args.iasl, timeout=args.timeout,
            )
        except (OSError, ValueError) as error:
            parser.error(str(error))
        record = outcome.record
        print(f"Derivation {record.derivation_id}: {outcome.path}")
        print(f"Publication: {outcome.publication.value}")
        print(f"Status: {record.status.value}" + (f" ({record.failure})" if record.failure else ""))
        print("Inputs: " + ", ".join(block.table_name for block in record.inputs))
        if outcome.differing_attempt is not None:
            print(f"Differing attempt preserved: {outcome.differing_attempt}")
        return 0 if (
            record.status == DerivationStatus.SUCCEEDED
            and outcome.publication in {Publication.PUBLISHED, Publication.REPRODUCED}
        ) else 1

    parser.print_help()
    return 0
