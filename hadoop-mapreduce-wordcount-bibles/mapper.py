#!/usr/bin/env python3
"""mapper.py"""

__authors__ = "Your Name"

import sys # read/write to STDIN/STDOUT 

for line in sys.stdin: 
    # TODO: split line into words
    print("{}\t{}".format(line, 1))
