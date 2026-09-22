#!/usr/bin/env bash

set -eu -o pipefail

sitemap_path="${1:-docs/sitemap.xml}"

if [[ ! -f "$sitemap_path" ]]; then
  exit 0
fi

python3 - "$sitemap_path" <<'PY'
import sys
from pathlib import Path

# Public tools hosted outside this repository but served under the same domain.
# Tola 0.7.1 cannot add external URLs to the sitemap, so append them here.
external_urls = (
    "https://gomazarashi.com/text-diff/",
    "https://gomazarashi.com/simple-text-counter/",
)

path = Path(sys.argv[1])
text = path.read_text(encoding="utf-8")

closing_tag = "</urlset>"
if closing_tag not in text:
    raise SystemExit(f"{path}: missing {closing_tag}")

entries = [
    f"<url><loc>{url}</loc></url>"
    for url in external_urls
    if f"<loc>{url}</loc>" not in text
]

if entries:
    text = text.replace(closing_tag, "".join(entries) + closing_tag, 1)
    path.write_text(text, encoding="utf-8")
PY
