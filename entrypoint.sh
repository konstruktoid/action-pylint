#!/bin/sh -l

black --quiet --check .
flake8 .
