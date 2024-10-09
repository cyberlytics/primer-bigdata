import pandas as pd
import time

print("Begin...")
t1 = time.time()
df = pd.read_csv('data/allbibles.csv')
t2 = time.time()
word_count = df['t'].str.split(expand=True).stack().value_counts()
t3 = time.time()

print(word_count[:50])
print("load CSV file:",t2 - t1,"s")
print("word count:",t3 - t2,"s")
#input()