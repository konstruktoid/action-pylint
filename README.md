# Python linting and testing using black and flake8

A GitHub action that checks Python code using
[black](https://github.com/psf/black) and
[ruff](https://github.com/charliermarsh/ruff).

## Github Actions configuration examples

```yaml
on: [push, pull_request]
name: Python Linting

permissions:
  contents: read

jobs:
  PythonLinting:
    name: Python linting
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - name: Konstruktoid Python linting
        uses: konstruktoid/action-pylint@master
```

## Script

```sh
#!/bin/sh

set -euf

black --check --diff --no-color --quiet .
ruff check --select ALL --ignore ANN --ignore D --ignore INP --ignore PTH --ignore T20 .
```
