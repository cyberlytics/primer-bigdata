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
rm -f $DIR/data/allbibles-result.txt

hadoopVersion=$(hadoop version | head -n 1 | awk '{print $2}')

# CORE:
time hadoop jar \
$SDKMAN_DIR/candidates/hadoop/current/share/hadoop/tools/lib/hadoop-streaming-$hadoopVersion.jar \
-file $DIR/mapper_ML.py \
-mapper $DIR/mapper_ML.py \
-file $DIR/reducer_ML.py \
-reducer $DIR/reducer_ML.py \
-input $DIR/data/allbibles.txt \
-output $DIR/SZ1
hadoop fs -copyToLocal $DIR/SZ1/part-00000 $DIR/data/allbibles-result.txt

rm *.pyc 2> /dev/null
#rm -rf $DIR/SZ?*

echo ""
echo "== Resulting WordCount, first and last10 lines, from $DIR/data/allbibles-result.txt =="
head -n 10 $DIR/data/allbibles-result.txt
echo "(...)"
tail -n 10 $DIR/data/allbibles-result.txt
echo ""

unix2dos *.py
