# Python linting and testing using black and ruff

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
      - name: Checkout repository
        uses: actions/checkout@8e5e7e5ab8b370d6c329ec480221332ada57f0ab # v3.5.2

      - name: Python linting
        uses: konstruktoid/action-pylint@v0.2.2
```

## Script

```sh
#!/bin/sh

set -euf

black --check --diff --no-color --quiet .
ruff check --select ALL --ignore ANN --ignore D --ignore INP --ignore PTH --ignore T20 .
```
