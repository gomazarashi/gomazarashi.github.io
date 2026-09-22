# justfile

set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default:
  @just --list

check:
  @command -v tola >/dev/null
  @command -v typst >/dev/null
  @command -v just >/dev/null
  @command -v python3 >/dev/null
  @echo "required commands are available"

build:
  just check
  python3 scripts/build-og.py
  rm -rf docs/images/og
  tola build --skip-drafts
  ./scripts/remove-404-from-sitemap.sh
  python3 scripts/validate-og.py
  test -f docs/CNAME
  test "$(cat docs/CNAME)" = "gomazarashi.com"
  @echo "build complete: docs/ is ready for GitHub Pages"

og:
  just check
  python3 scripts/build-og.py

validate-og:
  python3 scripts/validate-og.py

serve:
  just check
  python3 scripts/build-og.py --include-drafts
  tola serve

clean:
  rm -rf docs .tola

rebuild: clean build

doctor: check
  @just --version
  @tola --version
  @typst --version
  @python3 scripts/build-og.py --check-env
