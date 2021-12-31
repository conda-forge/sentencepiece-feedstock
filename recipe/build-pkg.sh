#!/bin/bash

set -ex

cd $SRC_DIR/python
${PYTHON} setup.py build
${PYTHON} setup.py install
