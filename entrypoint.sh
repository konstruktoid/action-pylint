#!/bin/sh

set -euf

if [ -f ./requirements.txt ]; then
  safety check --bare --file ./requirements.txt
fi

bandit --recursive .
black --check --diff --no-color --quiet .
flake8 .
