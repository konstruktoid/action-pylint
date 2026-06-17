FROM ghcr.io/astral-sh/uv:0.11.21-python3.13-trixie@sha256:04d969bff9e2dc75a93cd37dee5bc6238ca913a7a843ee16949adb1fae60ab66 AS uv
FROM konstruktoid/alpine:latest@sha256:6fc26a01699a5b166fb11fb56d7f00b6feeaa3188a4f1e3060f193ff09953ff9

LABEL org.opencontainers.image.title="action-pylint"
LABEL org.opencontainers.image.description="Python linting using ruff and ty"
LABEL org.opencontainers.image.url="https://github.com/konstruktoid/action-pylint"
LABEL org.opencontainers.image.source="https://github.com/konstruktoid/action-pylint"
LABEL org.opencontainers.image.licenses="GPL-3.0"

COPY requirements.txt /requirements.txt

RUN apk --no-cache add python3 && \
    rm -rf /var/cache/apk/

RUN adduser -D -u 1000 linter

COPY --from=uv /usr/local/bin/uv /usr/local/bin/uvx /usr/local/bin/

USER linter

ENV PATH="/home/linter/.local/bin:${PATH}" \
    UV_CACHE_DIR="/home/linter/.cache/uv"

RUN mkdir -p "${HOME}/.local/bin" "${UV_CACHE_DIR}" && \
    while IFS= read -r pkg; do \
      case "$pkg" in ''|'#'*) continue ;; esac; \
      uv tool install "$pkg"; \
    done < /requirements.txt && \
    rm -rf "${UV_CACHE_DIR}"

WORKDIR /github/workspace

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
