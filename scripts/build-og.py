#!/usr/bin/env python3
"""Generate OG images from article metadata.

Pipeline: content/posts/*.typ -> `tola query` (JSON) -> Typst -> PNG.
Source PNGs are written to assets/images/og/ and picked up by Tola's
existing nested asset copy (docs/images/og/).

Usage:
    python3 scripts/build-og.py                  # production (drafts excluded)
    python3 scripts/build-og.py --include-drafts # local serve preview
    python3 scripts/build-og.py --check-env      # environment check only
"""

from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import og_common as og  # noqa: E402

DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")
SOURCE_RE = re.compile(r"^(\d{8})-(.+)\.typ$")
WORK_POSTS_INPUT = "/.og/posts.json"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--include-drafts",
        action="store_true",
        help="also generate OG images for drafts (for `just serve`)",
    )
    parser.add_argument(
        "--check-env",
        action="store_true",
        help="only check required commands and fonts, then exit",
    )
    return parser.parse_args()


def check_env() -> str:
    og.require_commands("typst", "tola")
    return og.detect_og_font()


def report_version_mismatches() -> None:
    for mismatch in og.documented_version_mismatches():
        og.warn(
            f"tool version differs from the documented one: {mismatch}; "
            "OG output may differ from the committed artifacts"
        )


def text_field(item: dict, key: str, errors: list[str]) -> str | None:
    value = item.get(key)
    if value is None:
        return None
    if not isinstance(value, str):
        errors.append(f"{key} must be plain text, got {type(value).__name__}")
        return None
    return value if value.strip() != "" else None


def derive_stem(path: str) -> str:
    filename = path.rsplit("/", 1)[-1]
    return filename[:-4] if filename.endswith(".typ") else filename


def normalize_record(item: dict, *, include_drafts: bool) -> dict | None:
    path = item.get("path")
    if not isinstance(path, str) or not path.startswith("content/posts/"):
        og.fail(f"unexpected `tola query` path: {path!r}")
    filename = path.rsplit("/", 1)[-1]
    stem = derive_stem(path)
    draft = bool(item.get("draft", False))
    errors: list[str] = []

    source_match = SOURCE_RE.match(filename)
    if source_match is None:
        errors.append(f"filename must follow yyyymmdd-slug.typ (got {filename!r})")

    title = text_field(item, "title", errors)
    summary = text_field(item, "summary", errors)
    date = text_field(item, "date", errors)
    update = text_field(item, "update", errors)
    author = text_field(item, "author", errors)
    og_title = text_field(item, "og-title", errors)
    og_image = text_field(item, "og-image", errors)
    og_image_alt = text_field(item, "og-image-alt", errors)

    if title is None:
        errors.append("title is required")
    if summary is None:
        errors.append("summary is required (plain text)")
    if date is None:
        errors.append("date is required")
    elif not DATE_RE.match(date):
        errors.append(f"malformed date {date!r} (expected YYYY-MM-DD)")

    if update is not None:
        if not DATE_RE.match(update):
            errors.append(f"malformed update {update!r} (expected YYYY-MM-DD)")
        elif date is not None and DATE_RE.match(date) and update < date:
            errors.append(f"update {update} is before date {date}")

    if source_match is not None and date is not None and DATE_RE.match(date):
        if source_match.group(1) != date.replace("-", ""):
            errors.append(
                f"filename date {source_match.group(1)} does not match metadata date {date}"
            )

    tags = item.get("tags") or []
    if not isinstance(tags, list) or not all(isinstance(tag, str) for tag in tags):
        errors.append("tags must be a list of strings")

    permalink = item.get("permalink")
    if not isinstance(permalink, str) or not permalink.startswith("/"):
        errors.append(f"invalid permalink: {permalink!r}")

    if og_image is not None and og_image.startswith("/"):
        candidates = (
            og.ROOT / "assets" / og_image.lstrip("/"),
            og.ROOT / "docs" / og_image.lstrip("/"),
        )
        if not any(candidate.exists() for candidate in candidates):
            errors.append(f"og-image {og_image!r} not found under assets/ or docs/")

    if errors:
        if draft:
            for error in errors:
                og.warn(f"{path}: {error} (draft skipped)")
            return None
        og.fail("\n".join(f"{path}: {error}" for error in errors))

    if draft and not include_drafts:
        return None

    return {
        "stem": stem,
        "path": path,
        "permalink": permalink,
        "title": title,
        "summary": summary,
        "date": date,
        "update": update,
        "author": author,
        "draft": draft,
        "tags": tags,
        "og-title": og_title,
        "og-image": og_image,
        "og-image-alt": og_image_alt,
    }


def query_posts() -> list[dict]:
    og.OG_WORK_DIR.mkdir(parents=True, exist_ok=True)
    og.run(
        [
            "tola",
            "query",
            "content/posts",
            "--drafts",
            "--pretty",
            "--output",
            str(og.POSTS_JSON.relative_to(og.ROOT)),
        ]
    )
    if not og.POSTS_JSON.exists():
        og.POSTS_JSON.write_text("[]\n", encoding="utf-8")
    data = og.read_json(og.POSTS_JSON)
    if not isinstance(data, list):
        og.fail(f"{og.relative(og.POSTS_JSON)}: expected a JSON array")
    return data


def compile_png(
    entry: Path, output: Path, font: str, author: str, inputs: dict[str, str], context: str
) -> None:
    if not entry.exists():
        og.fail(f"missing Typst entry: {og.relative(entry)}")
    output.parent.mkdir(parents=True, exist_ok=True)
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
        f"og-author={author}",
    ]
    for key, value in inputs.items():
        cmd += ["--input", f"{key}={value}"]
    cmd += [str(entry), str(output)]

    proc = subprocess.run(cmd, cwd=og.ROOT, capture_output=True, text=True)
    if proc.returncode != 0:
        detail = (proc.stderr or proc.stdout).strip()
        og.fail(f"Typst OG rendering failed for {context}:\n{detail}")

    width, height = og.png_dimensions(output)
    if (width, height) != (og.CANVAS_WIDTH, og.CANVAS_HEIGHT):
        og.fail(
            f"{og.relative(output)}: expected {og.CANVAS_WIDTH}x{og.CANVAS_HEIGHT} px, "
            f"got {width}x{height}"
        )
    size = output.stat().st_size
    if size > og.PNG_SIZE_ERROR_BYTES:
        og.fail(
            f"{og.relative(output)}: {size / 1024:.0f} KB exceeds the 1 MB budget"
        )
    if size > og.PNG_SIZE_WARN_BYTES:
        og.warn(
            f"{og.relative(output)}: {size / 1024:.0f} KB exceeds the 750 KB budget"
        )


def main() -> None:
    args = parse_args()
    font = check_env()

    if args.check_env:
        print(f"python: {sys.version.split()[0]}")
        for tool, expected in (
            ("typst", og.EXPECTED_TYPST_VERSION),
            ("tola", og.EXPECTED_TOLA_VERSION),
        ):
            version = og.command_version(tool)
            marker = "" if expected in version else f" [documented: {expected} -> mismatch]"
            print(f"{tool}: {version}{marker}")
        print(f"og-font: {font}")
        return

    report_version_mismatches()
    author = og.site_author() or "gomazarashi"

    # Recreate generated directories so stale files can never survive a build.
    shutil.rmtree(og.OG_WORK_DIR, ignore_errors=True)
    shutil.rmtree(og.OG_ASSET_DIR, ignore_errors=True)
    og.OG_WORK_DIR.mkdir(parents=True)
    (og.OG_ASSET_DIR / "posts").mkdir(parents=True)

    raw_records = query_posts()

    # A stem is the OG image identity, so duplicates are always fatal,
    # including collisions between a draft and a published article.
    stem_sources: dict[str, str] = {}
    for item in raw_records:
        path = item.get("path")
        if not isinstance(path, str) or not path.startswith("content/posts/"):
            og.fail(f"unexpected `tola query` path: {path!r}")
        stem = derive_stem(path)
        if stem in stem_sources:
            og.fail(
                f"duplicate OG source stem {stem!r}: "
                f"{stem_sources[stem]} and {path}"
            )
        stem_sources[stem] = path

    records = [
        record
        for item in raw_records
        if (record := normalize_record(item, include_drafts=args.include_drafts))
        is not None
    ]

    # Typst reads this file; it is derived from `tola query`, never hand-edited.
    og.POSTS_JSON.write_text(
        json.dumps(records, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )

    compile_png(
        og.ROOT / "og" / "default.typ",
        og.OG_ASSET_DIR / "default.png",
        font,
        author,
        {},
        context="default OG image",
    )

    manifest_entries = []
    generated = 0
    for record in records:
        stem = record["stem"]
        custom = record["og-image"]
        if custom:
            image = custom
            generated_now = False
        else:
            image = og.ARTICLE_IMAGE_DIR + stem + ".png"
            compile_png(
                og.ROOT / "og" / "post.typ",
                og.OG_ASSET_DIR / "posts" / f"{stem}.png",
                font,
                author,
                {"data": WORK_POSTS_INPUT, "stem": stem},
                context=record["path"],
            )
            generated_now = True
            generated += 1
        manifest_entries.append(
            {
                "stem": stem,
                "path": record["path"],
                "permalink": record["permalink"],
                "title": record["title"],
                "summary": record["summary"],
                "date": record["date"],
                "update": record["update"],
                "author": record["author"],
                "draft": record["draft"],
                "tags": record["tags"],
                "og-title": record["og-title"],
                "og-image-alt": record["og-image-alt"],
                "image": image,
                "generated": generated_now,
            }
        )

    manifest = {
        "site_url": og.site_url(),
        "font": font,
        "author": author,
        "default": og.DEFAULT_IMAGE_PATH,
        "posts": manifest_entries,
    }
    og.MANIFEST_JSON.write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )

    draft_note = " (drafts included)" if args.include_drafts else ""
    print(
        f"og: generated default.png and {generated} article image(s){draft_note}"
    )


if __name__ == "__main__":
    main()
