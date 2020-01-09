# Python linting and testing using black and flake8

A GitHub action that checks Python code using [black](https://github.com/psf/black)
and [flake8](https://gitlab.com/pycqa/flake8) with some addtitional plugins.

## Tools and plugins installed

[black](https://github.com/psf/black)
[flake8](https://gitlab.com/pycqa/flake8)
[flake8-bandit](https://pypi.org/project/flake8-bandit/)
[flake8-bugbear](https://pypi.org/project/flake8-bugbear/)
[flake8-deprecated](https://pypi.org/project/flake8-deprecated/)
[flake8-executable](https://pypi.org/project/flake8-executable/)

## Github Actions configuration examples

```sh
on: [push, pull_request]
name: Python Linting
jobs:
  PythonLinting:
    name: Python linting
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - name: Konstruktoid Python linting
        uses: konstruktoid/action-pylint@master
```

```
workflow "Python Linting" {
  on = "push"
  resolves = ["python-linting"]
}

action "python-linting" {
  uses = "konstruktoid/action-pylint@master"
}
```

## Script

```sh
#!/bin/sh -l

black --quiet --check .
flake8 .
```
