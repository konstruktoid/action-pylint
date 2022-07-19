FROM konstruktoid/alpine:latest

LABEL "com.github.actions.name"="Konstruktoid Python linting"
LABEL "com.github.actions.description"="Python linting using black, safety and flake8"
LABEL "com.github.actions.icon"="bell"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/konstruktoid/action-pylint"
LABEL "homepage"="https://github.com/konstruktoid/action-pylint"
LABEL "maintainer"="Thomas Sjögren <konstruktoid@users.noreply.github.com>"

COPY requirements.txt /requirements.txt

RUN apk --no-cache add gcc musl-dev py3-pip python3 python3-dev && \
    pip3 install --upgrade pip && \
    pip3 install --upgrade --ignore-installed -r /requirements.txt && \
    apk del gcc musl-dev python3-dev && \
    rm -rf /var/cache/apk/

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
