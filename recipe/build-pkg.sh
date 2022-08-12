#!/bin/bash

set -ex

cd $SRC_DIR/python
$PYTHON -m pip install --no-deps --ignore-installed -v .
