---
date: "2016-11-20T00:00:00Z"
title: Parsing lines from Spark RDD
---
A typical [Apache Spark](http://spark.apache.org/) application using RDD api starts as following:

```scala
val lines = sc.textFile("/path/to/data")
val records = lines.map(parseLineToRecord)

case class Record(...)

def parseLineToRecord(line: String) : Record = {
  val parts = line.split("\t", -1)
  ...
  Record(..)
}
```

In case of bad records you very often want to discard the unparseable lines:

```scala
def parseLineToRecordOption(line: String) = Option[Record] = {
  try {
    ...
    Some(Record(..))
  } catch {
    case _ => None
  }
}

val records = lines.map(parseLineToRecordOption).filter(x => x.isDefined).map(x => x.get)
```

And then you discover that you there is an [implicit conversion from Option[T] to Iterable[T]](https://github.com/scala/scala/blob/2.12.x/src/library/scala/Option.scala).
The nice thing is that you now can use flatMap instead of filter + map:

```scala
val records = lines.flatMap(parseLineToRecordOption)
```

Strangely enough there is no such implicit conversion for a Try[T] so we convert to Option first:

```scala
def tryParseLineToRecordOption(line: String) : Try[Record] =
  Try {
    ...
    Some(Record(..))
  }

val records = lines.map(tryParseLineToRecordOption).flatMap(x => x.toOption)
```
