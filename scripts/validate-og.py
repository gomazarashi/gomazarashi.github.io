#!/usr/bin/env python3
"""Validate OG output produced by `just build`.

Checks:
- HTML: canonical, description, Open Graph / Twitter Card fields, article
  fields, duplicate singleton tags, 404 noindex.
- PNG: 1200x630, PNG format, repository size budget.
- Mapping: every local og:image URL exists under docs/.
- Stale files: docs/images/og must match the build manifest exactly.
- Redirect (alias) pages must not contain OG tags.

Usage: python3 scripts/validate-og.py
"""

from __future__ import annotations

import sys
from html.parser import HTMLParser
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import og_common as og  # noqa: E402

OG_SINGLETONS = (
    "og:title",
    "og:description",
    "og:url",
    "og:type",
    "og:site_name",
    "og:locale",
    "og:image",
    "og:image:width",
    "og:image:height",
    "og:image:type",
    "og:image:alt",
    "article:published_time",
    "article:modified_time",
)
TWITTER_SINGLETONS = (
    "twitter:card",
    "twitter:title",
    "twitter:description",
    "twitter:image",
    "twitter:image:alt",
)
FIXED_PAGES = (
    ("/", "index.html"),
    ("/posts/", "posts/index.html"),
    ("/tools/", "tools/index.html"),
    ("/banners/", "banners/index.html"),
    ("/404.html", "404.html"),
)


class HeadParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.metas: list[tuple[str, str, str]] = []
        self.canonical: str | None = None
        self.title: str | None = None
        self._in_title = False

    def handle_starttag(self, tag: str, attrs) -> None:
        attr = dict(attrs)
        if tag == "title":
            self._in_title = True
        elif tag == "meta":
            if "property" in attr:
                self.metas.append(
                    ("property", attr["property"], attr.get("content", ""))
                )
            elif "name" in attr:
                self.metas.append(("name", attr["name"], attr.get("content", "")))
        elif tag == "link" and attr.get("rel") == "canonical":
            self.canonical = attr.get("href")

    def handle_endtag(self, tag: str) -> None:
        if tag == "title":
            self._in_title = False

    def handle_data(self, data: str) -> None:
        if self._in_title and self.title is None:
            self.title = data.strip()

    def values(self, kind: str, key: str) -> list[str]:
        return [
            content
            for meta_kind, meta_key, content in self.metas
            if meta_kind == kind and meta_key == key
        ]


class Report:
    def __init__(self) -> None:
        self.errors: list[str] = []
        self.warnings: list[str] = []

    def error(self, message: str) -> None:
        self.errors.append(message)

    def warning(self, message: str) -> None:
        self.warnings.append(message)


def ensure_leading_slash(path: str) -> str:
    return path if path.startswith("/") else "/" + path


def absolute_url(path: str) -> str:
    if path.startswith("https://") or path.startswith("http://"):
        return path
    return og.site_url() + ensure_leading_slash(path)


def url_to_docs_relative(url: str) -> str | None:
    base = og.site_url()
    if url == base:
        return "index.html"
    if url.startswith(base + "/"):
        return url[len(base) + 1 :]
    return None


def check_png(report: Report, path: Path) -> None:
    rel = og.relative(path)
    if not path.exists():
        report.error(f"{rel}: missing generated PNG")
        return
    try:
        width, height = og.png_dimensions(path)
    except ValueError as exc:
        report.error(f"{rel}: {exc}")
        return
    if (width, height) != (og.CANVAS_WIDTH, og.CANVAS_HEIGHT):
        report.error(
            f"{rel}: expected {og.CANVAS_WIDTH}x{og.CANVAS_HEIGHT} px, got {width}x{height}"
        )
    size = path.stat().st_size
    if size > og.PNG_SIZE_ERROR_BYTES:
        report.error(f"{rel}: {size / 1024:.0f} KB exceeds the 1 MB budget")
    elif size > og.PNG_SIZE_WARN_BYTES:
        report.warning(f"{rel}: {size / 1024:.0f} KB exceeds the 750 KB budget")


def check_singletons(report: Report, path: str, parser: HeadParser) -> None:
    keys = [(kind, key) for kind in ("property",) for key in OG_SINGLETONS]
    keys += [("name", key) for key in TWITTER_SINGLETONS]
    keys += [("name", "description"), ("name", "robots")]
    for kind, key in keys:
        values = parser.values(kind, key)
        if len(values) > 1:
            report.error(f"{path}: duplicate {key} ({len(values)} occurrences)")


def require_meta(
    report: Report, path: str, parser: HeadParser, kind: str, key: str, label: str
) -> str:
    values = parser.values(kind, key)
    if not values:
        report.error(f"{path}: missing {label}")
        return ""
    for value in values:
        if value.strip() == "":
            report.error(f"{path}: empty {label}")
    return values[0]


def check_common_head(
    report: Report, path: str, parser: HeadParser, expected_url: str, expected_image: str
) -> tuple[str, str]:
    if parser.canonical is None:
        report.error(f"{path}: missing canonical link")
    elif not parser.canonical.startswith("https://"):
        report.error(f"{path}: canonical must be an absolute HTTPS URL")
    elif parser.canonical != expected_url:
        report.error(
            f"{path}: canonical {parser.canonical} does not match {expected_url}"
        )

    require_meta(report, path, parser, "name", "description", "description")
    og_title = require_meta(report, path, parser, "property", "og:title", "og:title")
    require_meta(report, path, parser, "property", "og:description", "og:description")
    og_url = require_meta(report, path, parser, "property", "og:url", "og:url")
    require_meta(report, path, parser, "property", "og:type", "og:type")
    require_meta(report, path, parser, "property", "og:site_name", "og:site_name")
    require_meta(report, path, parser, "property", "og:locale", "og:locale")
    image = require_meta(report, path, parser, "property", "og:image", "og:image")
    require_meta(report, path, parser, "property", "og:image:alt", "og:image:alt")
    require_meta(report, path, parser, "name", "twitter:card", "twitter:card")
    require_meta(report, path, parser, "name", "twitter:title", "twitter:title")
    require_meta(
        report, path, parser, "name", "twitter:description", "twitter:description"
    )
    twitter_image = require_meta(
        report, path, parser, "name", "twitter:image", "twitter:image"
    )
    require_meta(
        report, path, parser, "name", "twitter:image:alt", "twitter:image:alt"
    )

    if og_url and og_url != expected_url:
        report.error(f"{path}: og:url {og_url} does not match {expected_url}")
    if image and not image.startswith("https://"):
        report.error(f"{path}: og:image must be an absolute HTTPS URL")
    if image and image != expected_image:
        report.error(f"{path}: og:image {image} does not match {expected_image}")
    if twitter_image and twitter_image != image:
        report.error(f"{path}: twitter:image must match og:image")
    card = parser.values("name", "twitter:card")
    if card and card[0] != "summary_large_image":
        report.error(f"{path}: twitter:card must be summary_large_image")

    if image:
        local = url_to_docs_relative(image)
        if local is not None and not (og.ROOT / "docs" / local).exists():
            report.error(f"{path}: og:image file docs/{local} does not exist")
    return og_title, image


def check_generated_image_attributes(
    report: Report, path: str, parser: HeadParser
) -> None:
    for key, expected in (
        ("og:image:width", str(og.CANVAS_WIDTH)),
        ("og:image:height", str(og.CANVAS_HEIGHT)),
        ("og:image:type", "image/png"),
    ):
        value = require_meta(report, path, parser, "property", key, key)
        if value and value != expected:
            report.error(f"{path}: {key} must be {expected}, got {value}")


def check_fixed_page(
    report: Report, path: str, parser: HeadParser, expected_url: str, expected_image: str
) -> None:
    check_singletons(report, path, parser)
    check_common_head(report, path, parser, expected_url, expected_image)
    og_type = parser.values("property", "og:type")
    if og_type and og_type[0] != "website":
        report.error(f"{path}: og:type must be website")
    check_generated_image_attributes(report, path, parser)


def check_article_page(
    report: Report,
    path: str,
    parser: HeadParser,
    expected_url: str,
    entry: dict,
) -> None:
    expected_image = absolute_url(str(entry["image"]))
    generated = bool(entry.get("generated"))
    check_singletons(report, path, parser)
    og_title, _ = check_common_head(report, path, parser, expected_url, expected_image)

    og_type = parser.values("property", "og:type")
    if og_type and og_type[0] != "article":
        report.error(f"{path}: og:type must be article")

    social_title = entry.get("og-title") or entry["title"]
    if og_title and og_title != social_title:
        report.error(f"{path}: og:title must be {social_title!r}, got {og_title!r}")

    image_alt = parser.values("property", "og:image:alt")
    custom_alt = entry.get("og-image-alt")
    if custom_alt and image_alt and image_alt[0] != custom_alt:
        report.error(f"{path}: og:image:alt must be {custom_alt!r}")

    description = parser.values("property", "og:description")
    if description and description[0] != entry["summary"]:
        report.error(f"{path}: og:description must match the article summary")

    published = require_meta(
        report, path, parser, "property", "article:published_time", "article:published_time"
    )
    if published and entry.get("date") and published != entry["date"]:
        report.error(f"{path}: article:published_time must be {entry['date']}")

    modified = parser.values("property", "article:modified_time")
    if entry.get("update"):
        if not modified:
            report.error(f"{path}: missing article:modified_time")
        elif modified[0] != entry["update"]:
            report.error(f"{path}: article:modified_time must be {entry['update']}")
    elif modified:
        report.error(f"{path}: article:modified_time must be omitted without update")

    tags = parser.values("property", "article:tag")
    if tags != list(entry.get("tags", [])):
        report.error(
            f"{path}: article:tag {tags!r} does not match metadata tags "
            f"{list(entry.get('tags', []))!r}"
        )

    if generated:
        check_generated_image_attributes(report, path, parser)


def check_404(report: Report, path: str, parser: HeadParser) -> None:
    robots = parser.values("name", "robots")
    if "noindex" not in robots:
        report.error(f"{path}: 404 page must have <meta name=\"robots\" content=\"noindex\">")


def check_redirect_pages(report: Report, expected_paths: set[Path]) -> None:
    for html_file in (og.ROOT / "docs").rglob("*.html"):
        if html_file.resolve() in expected_paths:
            continue
        text = html_file.read_text(encoding="utf-8", errors="replace")
        rel = og.relative(html_file)
        if "http-equiv=\"refresh\"" in text or "http-equiv='refresh'" in text:
            if "property=\"og:" in text or "property='og:" in text:
                report.error(f"{rel}: redirect/alias page must not contain OG tags")
        else:
            report.error(
                f"{rel}: HTML page is not covered by OG validation; add it to "
                "FIXED_PAGES in scripts/validate-og.py (or make it an alias)"
            )


def check_stale_pngs(report: Report, manifest: dict) -> tuple[int, int]:
    docs_dir = og.ROOT / "docs"
    expected = {Path("images/og/default.png")}
    for entry in manifest.get("posts", []):
        if entry.get("draft") or not entry.get("generated"):
            continue
        url = absolute_url(str(entry["image"]))
        local = url_to_docs_relative(url)
        if local is None:
            report.error(f"manifest image is not on the site domain: {url}")
            continue
        expected.add(Path(local))

    actual = (
        {path.relative_to(docs_dir) for path in og.OG_DOCS_DIR.rglob("*.png")}
        if og.OG_DOCS_DIR.is_dir()
        else set()
    )
    for missing in sorted(expected - actual):
        report.error(f"docs/{missing}: expected OG PNG is missing")
    for extra in sorted(actual - expected):
        report.error(
            f"docs/{extra}: stale/orphan OG PNG (article deleted, renamed, or draft)"
        )
    return len(expected), len(actual)


def main() -> None:
    if not (og.ROOT / "docs").is_dir():
        og.fail("docs/ not found; run `just build` first")
    manifest = og.read_json(og.MANIFEST_JSON)
    if not isinstance(manifest, dict):
        og.fail(f"{og.relative(og.MANIFEST_JSON)}: expected a JSON object")

    report = Report()
    expected_html: set[Path] = set()
    checked_pages = 0

    check_png(report, og.ROOT / "docs" / "images" / "og" / "default.png")

    for path, rel in FIXED_PAGES:
        page = og.ROOT / "docs" / rel
        expected_html.add(page.resolve())
        if not page.exists():
            report.error(f"docs/{rel}: missing page")
            continue
        parser = HeadParser()
        parser.feed(page.read_text(encoding="utf-8", errors="replace"))
        expected_url = og.site_url() + (path if path != "/" else "/")
        expected_image = absolute_url(og.DEFAULT_IMAGE_PATH)
        check_fixed_page(report, f"docs/{rel}", parser, expected_url, expected_image)
        if path == "/404.html":
            check_404(report, f"docs/{rel}", parser)
        checked_pages += 1

    for entry in manifest.get("posts", []):
        if entry.get("draft"):
            continue
        permalink = ensure_leading_slash(str(entry["permalink"]))
        rel = permalink.strip("/") + "/index.html"
        page = og.ROOT / "docs" / rel
        expected_html.add(page.resolve())
        if not page.exists():
            report.error(f"docs/{rel}: missing article page")
            continue
        parser = HeadParser()
        parser.feed(page.read_text(encoding="utf-8", errors="replace"))
        expected_url = og.site_url() + permalink
        check_article_page(report, f"docs/{rel}", parser, expected_url, entry)
        if entry.get("generated"):
            local = url_to_docs_relative(absolute_url(str(entry["image"])))
            if local is not None:
                check_png(report, og.ROOT / "docs" / local)
        checked_pages += 1

    expected_count, actual_count = check_stale_pngs(report, manifest)
    check_redirect_pages(report, expected_html)

    for message in report.warnings:
        og.warn(message)
    for message in report.errors:
        print(f"error: {message}", file=sys.stderr)

    if report.errors:
        og.fail(
            f"OG validation failed with {len(report.errors)} error(s); "
            "fix the source and run `just build` again"
        )
    print(
        f"og: validation passed ({checked_pages} page(s), "
        f"{expected_count} expected PNG(s), {actual_count} on disk)"
    )


if __name__ == "__main__":
    main()
