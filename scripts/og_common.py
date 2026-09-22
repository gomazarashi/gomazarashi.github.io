#!/usr/bin/env python3
"""Shared helpers for the OG image build/validation scripts.

Standard library only. Requires Python 3.11+ (tomllib).
"""

from __future__ import annotations

import json
import struct
import subprocess
import sys
from pathlib import Path

if sys.version_info < (3, 11):
    print("error: Python 3.11+ is required for the OG scripts", file=sys.stderr)
    raise SystemExit(1)

import tomllib  # noqa: E402  (import after the version check)

ROOT = Path(__file__).resolve().parent.parent

OG_WORK_DIR = ROOT / ".og"
POSTS_JSON = OG_WORK_DIR / "posts.json"
MANIFEST_JSON = OG_WORK_DIR / "manifest.json"
OG_ASSET_DIR = ROOT / "assets" / "images" / "og"
OG_DOCS_DIR = ROOT / "docs" / "images" / "og"

DEFAULT_IMAGE_PATH = "/images/og/default.png"
ARTICLE_IMAGE_DIR = "/images/og/posts/"
CANVAS_WIDTH = 1200
CANVAS_HEIGHT = 630
PNG_SIZE_WARN_BYTES = 750 * 1024
PNG_SIZE_ERROR_BYTES = 1024 * 1024

FONT_CANDIDATES = ("Noto Sans JP", "Noto Sans CJK JP")

# Versions documented in README.md / AGENTS.md. Mismatches are reported as
# warnings (not build failures) because tool upgrades are a separate decision.
EXPECTED_TYPST_VERSION = "0.14.2"
EXPECTED_TOLA_VERSION = "0.7.1"

PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"


def fail(message: str) -> "None":
    print(f"error: {message}", file=sys.stderr)
    raise SystemExit(1)


def warn(message: str) -> None:
    print(f"warning: {message}", file=sys.stderr)


def run(cmd: list[str]) -> subprocess.CompletedProcess:
    """Run a command in the repository root; fail with its output on error."""
    proc = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
    if proc.returncode != 0:
        detail = (proc.stderr or proc.stdout or "").strip()
        fail(f"command failed ({proc.returncode}): {' '.join(cmd)}\n{detail}")
    return proc


def require_commands(*names: str) -> None:
    from shutil import which

    missing = [name for name in names if which(name) is None]
    if missing:
        fail(f"required command(s) not found: {', '.join(missing)}")


def command_version(command: str) -> str:
    proc = subprocess.run(
        [command, "--version"], cwd=ROOT, capture_output=True, text=True
    )
    output = (proc.stdout or proc.stderr).strip()
    return output.splitlines()[0] if output else "unknown"


def documented_version_mismatches() -> list[str]:
    """Return human-readable mismatches against the documented tool versions."""
    mismatches = []
    for tool, expected in (
        ("typst", EXPECTED_TYPST_VERSION),
        ("tola", EXPECTED_TOLA_VERSION),
    ):
        version = command_version(tool)
        if expected not in version:
            mismatches.append(f"{version} (documented: {expected})")
    return mismatches


def load_config() -> dict:
    with (ROOT / "tola.toml").open("rb") as handle:
        return tomllib.load(handle)


def site_url() -> str:
    url = load_config().get("site", {}).get("info", {}).get("url", "")
    if not url:
        fail("tola.toml [site.info].url is required for OG URLs")
    return str(url).rstrip("/")


def site_author() -> str:
    return str(load_config().get("site", {}).get("info", {}).get("author", ""))


def detect_og_font() -> str:
    """Return the first available Japanese font from FONT_CANDIDATES.

    Never falls back to another OS font: the build fails explicitly instead.
    """
    require_commands("typst")
    proc = subprocess.run(
        ["typst", "fonts"], cwd=ROOT, capture_output=True, text=True
    )
    if proc.returncode != 0:
        fail(f"`typst fonts` failed:\n{(proc.stderr or proc.stdout).strip()}")
    available = {line.strip() for line in proc.stdout.splitlines() if line.strip()}
    for candidate in FONT_CANDIDATES:
        if candidate in available:
            return candidate
    fail(
        "no supported OG font found; install one of: "
        + ", ".join(FONT_CANDIDATES)
    )
    raise AssertionError("unreachable")


def png_dimensions(path: Path) -> tuple[int, int]:
    data = path.read_bytes()
    if not data.startswith(PNG_SIGNATURE):
        raise ValueError(f"{path} is not a PNG file")
    if data[12:16] != b"IHDR":
        raise ValueError(f"{path} has no PNG IHDR chunk")
    width, height = struct.unpack(">II", data[16:24])
    return width, height


def read_json(path: Path) -> object:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError:
        fail(f"missing {path.relative_to(ROOT)}; run `just og` first")
    except json.JSONDecodeError as exc:
        fail(f"invalid JSON in {path.relative_to(ROOT)}: {exc}")
    raise AssertionError("unreachable")


def relative(path: Path) -> str:
    try:
        return str(path.relative_to(ROOT))
    except ValueError:
        return str(path)
