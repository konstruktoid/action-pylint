FROM konstruktoid/alpine:latest@sha256:ffb6dfdf73f6cdd7ceaf86399f750c3b052272d982d01f434bcc5ded660f3f1b

LABEL "com.github.actions.name"="Konstruktoid Python linting"
LABEL "com.github.actions.description"="Python linting using black, ruff and ty"
LABEL "com.github.actions.icon"="bell"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/konstruktoid/action-pylint"
LABEL "homepage"="https://github.com/konstruktoid/action-pylint"
LABEL "maintainer"="Thomas Sjögren <konstruktoid@users.noreply.github.com>"

COPY requirements.txt /requirements.txt

ENV PATH="${PATH}:/root/.local/bin"

RUN apk --no-cache add gcc musl-dev python3 python3-dev py3-pip && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    python3 -m pip install --break-system-packages --no-cache-dir --upgrade pipx && \
    for p in $(grep -v '^#' /requirements.txt); do pipx install "${p}"; done && \
    apk del gcc musl-dev python3-dev && \
    rm -rf /var/cache/apk/

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
