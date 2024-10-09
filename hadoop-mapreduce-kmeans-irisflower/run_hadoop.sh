#!/bin/bash

# Copyright (2019) Hassan Elseoudy
# Copyright (2020) Christhph Neumann

echo JAVA_HOME=$JAVA_HOME

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo DIR: $DIR
cd $DIR

chmod a+x *.py 2> /dev/null
dos2unix *.py

rm *.pyc 2> /dev/null
rm -rf $DIR/SZ?*
rm -f $DIR/data/centroids-iter-last.csv
rm -f $DIR/data/centroids-iter-current.csv
rm -f $DIR/data/centroids-result.csv
cp $DIR/data/centroids-init.csv $DIR/data/centroids-iter-last.csv

hadoopVersion=$(hadoop version | head -n 1 | awk '{print $2}')

i=1
while :
do
	time hadoop jar \
	$SDKMAN_DIR/candidates/hadoop/current/share/hadoop/tools/lib/hadoop-streaming-$hadoopVersion.jar \
	-file $DIR/data/centroids-iter-last.csv \
	-file $DIR/mapper.py \
	-mapper $DIR/mapper.py \
	-file $DIR/reducer.py \
	-reducer $DIR/reducer.py \
	-input $DIR/data/iris-flower.csv \
	-output $DIR/SZ$i
	hadoop fs -copyToLocal $DIR/SZ$i/part-00000 $DIR/data/centroids-iter-current.csv
	# Compare centroids-iter-last with centroids-iter-current:
	seeiftrue=`python3 $DIR/reader.py`
	# Replace centroids-iter-last with centroids-iter-current
	mv $DIR/data/centroids-iter-current.csv $DIR/data/centroids-iter-last.csv
	if [ $seeiftrue = 1 ]
	then
		break
	fi
	i=$((i+1))
done

rm *.pyc
#rm -rf $DIR/SZ?*
rm -f $DIR/centroids-iter-last.csv # temporary file? Hadoop does create it as copy.
mv $DIR/data/centroids-iter-last.csv $DIR/data/centroids-result.csv

echo ""
echo "== Resulting Centroids from $DIR/data/centroids-result.csv =="
cat $DIR/data/centroids-result.csv
echo ""

unix2dos *.py
