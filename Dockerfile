FROM ghcr.io/astral-sh/uv:0.11.25-python3.13-trixie@sha256:952c3ad2c57bc823c8d7e989089a498f7c6c3ab6419397788181d40ba4cd7871 AS uv
FROM konstruktoid/alpine:latest@sha256:731ddd017ad870339bca068e3eb8269e8a60bbdebca598c9ffc8de944844b77d

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