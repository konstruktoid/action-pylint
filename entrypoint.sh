#!/bin/sh

set -euf

export PATH="${PATH}:/root/.local/bin"

black --check --diff --no-color --quiet .
ruff check --select ALL .
ty check .
