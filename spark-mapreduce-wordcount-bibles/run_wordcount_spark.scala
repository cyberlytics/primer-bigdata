val text = sc.textFile("data/allbibles.txt")
val s = System.nanoTime
val wordCounts = text.flatMap(line => line.split(" ")).map(word => (word,1)).reduceByKey(_+_)
wordCounts.collect
//val mostCommon = wordCounts.map(p => (p._2, p._1)).sortByKey(false, 1)
//mostCommon.collect
println("time: "+(System.nanoTime-s)/1e9+"s")
wordCounts.saveAsTextFile("SZ1")
sc.stop()
System.exit(0) // :quit works as alternative is spark-shell