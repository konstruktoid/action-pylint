#!/bin/sh
set -euf

export PATH="/root/.local/bin:${PATH}"
export UV_CACHE_DIR="/root/.cache/uv"
export RUFF_CACHE_DIR="/root/.cache/ruff"

mkdir -p "${UV_CACHE_DIR}" "${RUFF_CACHE_DIR}"

REPO_ROOT="${GITHUB_WORKSPACE:-.}"

cd "${REPO_ROOT}"

ruff format --check --diff "${REPO_ROOT}"

if [ -f "${REPO_ROOT}/pyproject.toml" ]; then
  ruff check "${REPO_ROOT}"
else
  ruff check --select ALL "${REPO_ROOT}"
fi

ty check "${REPO_ROOT}"
