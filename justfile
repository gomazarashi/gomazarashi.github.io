# justfile

set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default:
  @just --list

check:
  @command -v tola >/dev/null
  @command -v typst >/dev/null
  @command -v just >/dev/null
  @echo "required commands are available"

build:
  tola build

serve:
  tola serve

clean:
  rm -rf docs .tola

rebuild: clean build

doctor: check
  @just --version
  @tola --version
  @typst --version
