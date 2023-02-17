FROM konstruktoid/alpine:latest

LABEL "com.github.actions.name"="Konstruktoid Python linting"
LABEL "com.github.actions.description"="Python linting using black, safety and flake8"
LABEL "com.github.actions.icon"="bell"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/konstruktoid/action-pylint"
LABEL "homepage"="https://github.com/konstruktoid/action-pylint"
LABEL "maintainer"="Thomas Sjögren <konstruktoid@users.noreply.github.com>"

COPY requirements.txt /requirements.txt

RUN apk --no-cache add gcc musl-dev python3 python3-dev && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    python3 -m ensurepip --upgrade && \
    python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir --upgrade --ignore-installed --requirement /requirements.txt && \
    apk del gcc musl-dev python3-dev && \
    rm -rf /var/cache/apk/

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
