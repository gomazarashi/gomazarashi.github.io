#!/usr/bin/env python3
"""Fixture tests for the OG templates.

Compiles og/post.typ and og/default.typ against temporary metadata in
.og/fixtures/ and checks the expected pass/fail outcomes and PNG size.
Production content is never touched.

Usage: python3 scripts/test-og.py   (or: just test-og)
"""

import json
import shutil
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import og_common as og  # noqa: E402

LONG_JAPANESE_TITLE = (
    "このタイトルは非常に長く、日本語の文字が延々と続くためにどのサイズでも"
    "四行以内に収まらず、本番ビルドを明示的に失敗させることを確認するための"
    "テストです。"
)

CASES: tuple[dict, ...] = (
    {"stem": "short-one-line", "title": "短いタイトル", "tags": []},
    {"stem": "normal-two-lines", "title": "Typstでつくる小さなWebサイト", "tags": []},
    {
        "stem": "long-three-lines",
        "title": "TypstとTolaで構築する静的サイトのOG画像生成パイプライン",
        "tags": ["Typst", "Tola", "OGP"],
    },
    {
        "stem": "very-long-japanese-og-title",
        "title": LONG_JAPANESE_TITLE,
        "tags": [],
        "og-title": "長すぎるタイトルの短縮版",
    },
    {
        "stem": "mixed-japanese-english",
        "title": "Typst + Tola でつくる日本語サイトのOGP設計",
        "tags": ["Typst", "OGP"],
    },
    {"stem": "long-word", "title": "SupercalifragilisticexpialidociousXyzzyPlugh", "tags": []},
    {
        "stem": "url-token",
        "title": "Fix https://github.com/gomazarashi/gomazarashi.github.io/blob/develop/content/posts/example.typ rendering",
        "tags": [],
    },
    {"stem": "symbols", "title": "Typst/Tola: build+deploy_2026-09-22", "tags": []},
    {"stem": "tags-one", "title": "タグ1個", "tags": ["Typst"]},
    {"stem": "tags-four", "title": "タグ4個", "tags": ["Typst", "Web", "Design", "Tola"]},
    {
        "stem": "tags-five-plus",
        "title": "タグ5個以上",
        "tags": ["Typst", "Web", "Design", "Tola", "OGP", "GitHub Pages", "静的サイト"],
    },
    {"stem": "long-japanese-tag", "title": "長い日本語タグ", "tags": ["とても長い日本語タグのサンプルです"]},
    {
        "stem": "long-english-tag",
        "title": "long english tag",
        "tags": ["a-very-long-english-tag-with-many-words-and-hyphens"],
    },
    {
        "stem": "overflow-without-og-title",
        "title": LONG_JAPANESE_TITLE,
        "tags": [],
        "expect": "fail",
    },
)


def compile_og(
    entry: Path, output: Path, font: str, inputs: dict[str, str]
) -> subprocess.CompletedProcess:
    cmd = [
        "typst",
        "compile",
        "--root",
        str(og.ROOT),
        "--ppi",
        "144",
        "--input",
        f"og-font={font}",
        "--input",
        "og-author=gomazarashi",
    ]
    for key, value in inputs.items():
        cmd += ["--input", f"{key}={value}"]
    cmd += [str(entry), str(output)]
    return subprocess.run(cmd, cwd=og.ROOT, capture_output=True, text=True)


def check_dimensions(path: Path, failures: list[str]) -> None:
    try:
        width, height = og.png_dimensions(path)
    except ValueError as exc:
        failures.append(str(exc))
        return
    if (width, height) != (og.CANVAS_WIDTH, og.CANVAS_HEIGHT):
        failures.append(
            f"{path.name}: expected {og.CANVAS_WIDTH}x{og.CANVAS_HEIGHT}, got {width}x{height}"
        )


def main() -> None:
    og.require_commands("typst")
    font = og.detect_og_font()

    fixture_dir = og.OG_WORK_DIR / "fixtures"
    shutil.rmtree(fixture_dir, ignore_errors=True)
    fixture_dir.mkdir(parents=True)

    records = []
    for case in CASES:
        records.append(
            {
                "stem": case["stem"],
                "path": f"content/posts/20990101-{case['stem']}.typ",
                "permalink": f"/posts/{case['stem']}/",
                "title": case["title"],
                "summary": "fixture",
                "date": "2099-01-01",
                "author": None,
                "draft": False,
                "tags": case["tags"],
                "og-title": case.get("og-title"),
            }
        )
    data = fixture_dir / "cases.json"
    data.write_text(json.dumps(records, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    data_input = "/" + str(data.relative_to(og.ROOT))

    failures: list[str] = []
    passed = 0
    try:
        default_output = fixture_dir / "default.png"
        proc = compile_og(og.ROOT / "og" / "default.typ", default_output, font, {})
        if proc.returncode != 0:
            failures.append(
                "default: compilation failed:\n" + (proc.stderr or proc.stdout).strip()
            )
        else:
            check_dimensions(default_output, failures)
            passed += 1

        for case in CASES:
            stem = case["stem"]
            output = fixture_dir / f"{stem}.png"
            proc = compile_og(
                og.ROOT / "og" / "post.typ",
                output,
                font,
                {"data": data_input, "stem": stem},
            )
            expected_failure = case.get("expect") == "fail"
            if expected_failure:
                if proc.returncode == 0:
                    failures.append(f"{stem}: expected failure but compilation succeeded")
                else:
                    passed += 1
                continue
            if proc.returncode != 0:
                failures.append(
                    f"{stem}: compilation failed:\n" + (proc.stderr or proc.stdout).strip()
                )
                continue
            check_dimensions(output, failures)
            passed += 1
    finally:
        shutil.rmtree(fixture_dir, ignore_errors=True)

    if failures:
        for failure in failures:
            print(f"error: {failure}", file=sys.stderr)
        og.fail(f"OG fixture tests failed ({len(failures)} failure(s))")
    print(f"og: fixture tests passed ({passed} case(s), font: {font})")


if __name__ == "__main__":
    main()
