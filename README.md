# Python linting and testing using black and flake8

A GitHub action that checks Python code using [bandit](https://github.com/PyCQA/bandit),
[black](https://github.com/psf/black), [dlint](https://github.com/dlint-py/dlint),
[safety](https://pypi.org/project/safety/) and [flake8](https://gitlab.com/pycqa/flake8)
with some additional plugins.

## Tools and plugins installed

[bandit](https://github.com/PyCQA/bandit) - security linter\
[black](https://github.com/psf/black) - code formatter\
[dlint](https://github.com/dlint-py/dlint) - static code analysis\
[flake8](https://gitlab.com/pycqa/flake8) - glues together Python tools and plugins\
[flake8-bugbear](https://pypi.org/project/flake8-bugbear/) - bug finder\
[flake8-deprecated](https://pypi.org/project/flake8-deprecated/) - warns about deprecated method calls\
[flake8-executable](https://pypi.org/project/flake8-executable/) - checks executable permissions and shebangs\
[safety](https://pypi.org/project/safety/) - checks dependencies for known security vulnerabilities

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

if [ -f ./requirements.txt ]; then
  safety check --bare --file ./requirements.txt
fi

black --check --diff --no-color --quiet .
flake8 .
bandit --silent --recursive .
```
