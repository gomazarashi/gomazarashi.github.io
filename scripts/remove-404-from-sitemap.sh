#!/usr/bin/env bash

set -eu -o pipefail

sitemap_path="${1:-docs/sitemap.xml}"

if [[ ! -f "$sitemap_path" ]]; then
  exit 0
fi

python3 - "$sitemap_path" <<'PY'
import re
import sys
from pathlib import Path

path = Path(sys.argv[1])
text = path.read_text(encoding="utf-8")
text = re.sub(
    r"<url>\s*<loc>[^<]*/404\.html/?</loc>(?:\s*<lastmod>[^<]*</lastmod>)?\s*</url>",
    "",
    text,
)
path.write_text(text, encoding="utf-8")
PY
