#!/bin/sh

set -euf

if [ -f ./requirements.txt ]; then
  safety check --bare --file ./requirements.txt
fi

black --check --diff --no-color --quiet .
flake8 .
bandit --silent --recursive .
