#!/usr/bin/env bash

set -eu -o pipefail

sitemap_path="${1:-docs/sitemap.xml}"

if [[ ! -f "$sitemap_path" ]]; then
  exit 0
fi

perl -0pi -e 's#<url>\s*<loc>[^<]*/404\.html/?</loc>(?:\s*<lastmod>[^<]*</lastmod>)?\s*</url>##g' "$sitemap_path"
