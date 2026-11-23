from __future__ import annotations

from pathlib import Path

import pytest

from platform_compiler.cli import main


def test_cli_help_and_version(capsys: pytest.CaptureFixture[str]) -> None:
    with pytest.raises(SystemExit) as error:
        main(["--help"])
    assert error.value.code == 0
    assert "workspace" in capsys.readouterr().out
    assert main(["version"]) == 0
    assert capsys.readouterr().out.strip() == "0.1.0"


def test_cli_initializes_external_workspace(
    tmp_path: Path, capsys: pytest.CaptureFixture[str]
) -> None:
    path = tmp_path / "local-workspace"
    assert main(["workspace", "init", str(path)]) == 0
    assert path.is_dir()
    assert "Workspace ready" in capsys.readouterr().out
