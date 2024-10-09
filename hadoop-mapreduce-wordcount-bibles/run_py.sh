#!/bin/bash

# Copyright (2024) Christhph P. Neumann

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo DIR: $DIR
cd $DIR

chmod a+x *.py 2> /dev/null

echo "RUN: py mapper.py | sort -k1,1 | py reducer.py ..."
time cat data/allbibles.txt | python3 mapper.py | sort -k1,1 | python3 reducer.py
