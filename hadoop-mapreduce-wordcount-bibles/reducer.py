#!/usr/bin/env python3
"""reducer.py"""

__authors__ = "Your Name"

import sys # read/write to STDIN/STDOUT 

for line in sys.stdin:
    # TODO: handle lines that consist of mapper-based key-value pairs
    print("{}\t{}".format(line, 1))
