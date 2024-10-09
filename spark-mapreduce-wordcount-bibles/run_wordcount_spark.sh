#!/bin/bash

# Copyright (2024) Christhph P. Neumann

echo JAVA_HOME=$JAVA_HOME
echo HADOOP_HOME=$HADOOP_HOME
echo SPARK_HOME=$SPARK_HOME

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo DIR: $DIR
cd $DIR

me=$(basename -- $BASH_SOURCE)
me="${me%.*}"
echo me=$me

dos2unix *.scala

# Remove previous result files
rm -rf $DIR/SZ?* 2> /dev/null
rm -f $DIR/data/allbibles-result.txt 2> /dev/null

# CORE:
spark-shell -I "$me.scala"
hadoop fs -copyToLocal $DIR/SZ1/part-00000 $DIR/data/allbibles-result.txt

# OPTIONAL: Remove intermediat files
#rm -rf $DIR/SZ?*

echo
echo "== Resulting WordCount from $DIR/data/allbibles-result.txt =="
head -n 10 $DIR/data/allbibles-result.txt
tail -n 10 $DIR/data/allbibles-result.txt
echo

unix2dos *.scala
