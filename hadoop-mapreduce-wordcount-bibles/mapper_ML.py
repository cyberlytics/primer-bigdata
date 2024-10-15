#!/usr/bin/env python3
"""mapper.py"""

__authors__ = "Christoph P. Neumann"

import sys # read/write to STDIN/STDOUT 

def myMapFunction():
    for line in sys.stdin: 
        line = line.strip()
        # remove punctuation
        punctuation = ".,;:!?()[]{}`'-*\"\t\n\r"
        translation_table = str.maketrans(punctuation, ' ' * len(punctuation))
        cleaned_line = line.translate(translation_table)
        # split line into words
        words = cleaned_line.split()
        for word in words:
            # the mapper uses TAB '\t' for separation.
            # This must be adhered to, by the reducer!
            print("{}\t{}".format(word, 1))

if __name__ == "__main__":
    myMapFunction()
