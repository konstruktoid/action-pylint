#!/bin/sh
set -euf

export PATH="/home/linter/.local/bin:${PATH}"
export UV_CACHE_DIR="/home/linter/.cache/uv"
export RUFF_CACHE_DIR="/home/linter/.cache/ruff"

mkdir -p "${UV_CACHE_DIR}" "${RUFF_CACHE_DIR}"

REPO_ROOT="${GITHUB_WORKSPACE:-.}"

cd "${REPO_ROOT}" || exit 1

if [ -f "${REPO_ROOT}/pyproject.toml" ]; then
  ruff format --check --diff "${REPO_ROOT}"
  ruff check "${REPO_ROOT}"
else
  ruff format --check --diff "${REPO_ROOT}"
  ruff check --select ALL "${REPO_ROOT}"
fi

ty check "${REPO_ROOT}"
