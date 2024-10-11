# Python linting and testing using black and ruff

A GitHub action that checks Python code using
[black](https://github.com/psf/black) and
[ruff](https://github.com/charliermarsh/ruff).

## Github Actions configuration examples

```yaml
on: [push, pull_request]
name: Python linting

permissions:
  contents: read

jobs:
  PythonLinting:
    name: Python linting
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Python linting
        uses: konstruktoid/action-pylint@v0.8.0
```

## Script

```sh
#!/bin/sh

set -euf

export PATH="${PATH}:/root/.local/bin"

black --check --diff --no-color --quiet .
ruff check --select ALL .
```
