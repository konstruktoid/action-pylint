FROM ghcr.io/astral-sh/uv:0.11.24-python3.13-trixie@sha256:0d7a6c7f14e7959a9a81fe8aefe38f8521e2ae64358d42925afe72057b0fd814 AS uv
FROM konstruktoid/alpine:latest@sha256:fb3d68542d42431977eb0f668f4a053d84b71cf481b433ad2ed12bf4994dde9e

LABEL org.opencontainers.image.title="action-pylint"
LABEL org.opencontainers.image.description="Python linting using ruff and ty"
LABEL org.opencontainers.image.url="https://github.com/konstruktoid/action-pylint"
LABEL org.opencontainers.image.source="https://github.com/konstruktoid/action-pylint"
LABEL org.opencontainers.image.licenses="GPL-3.0"

COPY requirements.txt /requirements.txt

RUN apk --no-cache add python3 && \
    rm -rf /var/cache/apk/

COPY --from=uv /usr/local/bin/uv /usr/local/bin/uvx /usr/local/bin/

ENV PATH="/root/.local/bin:${PATH}" \
    UV_CACHE_DIR="/root/.cache/uv"

RUN mkdir -p "/root/.local/bin" "${UV_CACHE_DIR}" && \
    for pkg in $(grep -vE '^$|#' /requirements.txt); do \
      uv tool install "$pkg"; \
    done && \
    rm -rf "${UV_CACHE_DIR}"

WORKDIR /github/workspace

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
