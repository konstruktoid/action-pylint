# Python linting and testing using ruff and ty

A GitHub action that checks Python code using
[ruff](https://github.com/astral-sh/ruff) and
[ty](https://github.com/astral-sh/ty).

## Github Actions configuration example

```yaml
on:
  push:
    branches: [main]
  pull_request:
name: Python linting

permissions: {}

jobs:
  PythonLinting:
    name: Python linting
    runs-on: ubuntu-latest
    permissions:
      contents: read
    steps:
      - name: Checkout repository
        uses: actions/checkout@v6

      - name: Python linting
        uses: konstruktoid/action-pylint@v3
```
