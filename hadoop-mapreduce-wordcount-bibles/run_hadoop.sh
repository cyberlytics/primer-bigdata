#!/bin/bash

# Copyright (2024) Christhph P. Neumann

echo JAVA_HOME=$JAVA_HOME

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo DIR: $DIR
cd $DIR

chmod a+x *.py 2> /dev/null
dos2unix *.py

rm *.pyc 2> /dev/null
rm -rf $DIR/SZ?* 2> /dev/null
rm -f $DIR/Dataset_Bibles/allbibles-result.txt

time ~/hadoop/hadoop-3.3.6/bin/hadoop jar \
~/hadoop/hadoop-3.3.6/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
-file $DIR/mapper.py \
-mapper $DIR/mapper.py \
-file $DIR/reducer.py \
-reducer $DIR/reducer.py \
-input $DIR/Dataset_Bibles/allbibles.txt \
-output $DIR/SZ1
hadoop fs -copyToLocal $DIR/SZ1/part-00000 $DIR/Dataset_Bibles/allbibles-result.txt

rm *.pyc 2> /dev/null
#rm -rf $DIR/SZ?*

echo ""
echo "== Resulting WordCount from $DIR/Dataset_Bibles/allbibles-result.txt =="
head -n 10 $DIR/Dataset_Bibles/allbibles-result.txt
tail -n 10 $DIR/Dataset_Bibles/allbibles-result.txt
echo ""

unix2dos *.py
