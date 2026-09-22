#!/usr/bin/env python3
"""Patch Tola's generated sitemap.

Tola 0.7.1 cannot drop the noindex 404 page or add URLs hosted outside this
repository, so `just build` post-processes docs/sitemap.xml with this script.
"""

import re
import sys
from pathlib import Path

# Public tools hosted outside this repository but served under the same domain.
EXTERNAL_URLS = (
    "https://gomazarashi.com/text-diff/",
    "https://gomazarashi.com/simple-text-counter/",
)

sitemap_path = Path(sys.argv[1] if len(sys.argv) > 1 else "docs/sitemap.xml")
if not sitemap_path.exists():
    raise SystemExit(0)

text = sitemap_path.read_text(encoding="utf-8")
text = re.sub(
    r"<url>\s*<loc>[^<]*/404\.html/?</loc>(?:\s*<lastmod>[^<]*</lastmod>)?\s*</url>",
    "",
    text,
)

closing_tag = "</urlset>"
if closing_tag not in text:
    raise SystemExit(f"error: {sitemap_path}: missing {closing_tag}")

entries = [
    f"<url><loc>{url}</loc></url>"
    for url in EXTERNAL_URLS
    if f"<loc>{url}</loc>" not in text
]
if entries:
    text = text.replace(closing_tag, "".join(entries) + closing_tag, 1)

sitemap_path.write_text(text, encoding="utf-8")
