#!/usr/bin/env python3
"""reducer.py"""

__authors__ = "Christoph P. Neumann"

from operator import itemgetter
import sys # read/write to STDIN/STDOUT 

def myReduceFunction():
    current_word = None
    current_count = 0
    word = None
    
    for line in sys.stdin: 
        line = line.strip() 
        # Splitting the data based on TAB '\t' (cf. mapper.py)
        word, count = line.split('\t', 1) 
        # count is initially read as string, thus, convert count to int
        try: 
            count = int(count) 
        except ValueError: 
            continue
    
        # Hadoop sorts mapper output by key (i.e, word, in this case),
        # during shuffling, before Hadoop passes data to the reducer!
        if current_word == word: 
            current_count += count 
        else: 
            # word has changed => finish up this word count
            if current_word: 
                print("{}\t{}".format(current_word, current_count))
            current_count = count 
            current_word = word 
    
    # when stdin has ended: output the last word
    if current_word == word: 
        print("{}\t{}".format(current_word, current_count))


if __name__ == "__main__":
    myReduceFunction()
