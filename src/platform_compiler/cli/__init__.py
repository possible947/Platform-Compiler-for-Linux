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

    parser.print_help()
    return 0
