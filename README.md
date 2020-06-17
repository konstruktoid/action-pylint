# Python linting and testing using black and flake8

A GitHub action that checks Python code using [black](https://github.com/psf/black),
[safety](https://pypi.org/project/safety/) and [flake8](https://gitlab.com/pycqa/flake8)
with some additional plugins.

## Tools and plugins installed

[black](https://github.com/psf/black) - code formatter\
[flake8](https://gitlab.com/pycqa/flake8) - glues together Python tools and plugins\
[flake8-bandit](https://pypi.org/project/flake8-bandit/) - security testing\
[flake8-bugbear](https://pypi.org/project/flake8-bugbear/) - bug finder\
[flake8-deprecated](https://pypi.org/project/flake8-deprecated/) - warns about deprecated method calls\
[flake8-executable](https://pypi.org/project/flake8-executable/) - checks executable permissions and shebangs\
[safety](https://pypi.org/project/safety/) - checks dependencies for known security vulnerabilities

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
#!/bin/sh

set -euf

if [ -f ./requirements.txt ]; then
  safety check --bare --file ./requirements.txt
fi

black --quiet --check .
flake8 .
```
