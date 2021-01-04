---
date: "2016-01-14T00:00:00Z"
guid: http://www.timvw.be/?p=2523
tags:
- gson
- scala
title: Using Gson to serialize Scala objects
aliases:
 - /2016/01/14/using-gson-to-serialize-scala-objects/
 - /2016/01/14/using-gson-to-serialize-scala-objects.html
---
[gson](https://github.com/google/gson) is a pretty nice library that converts Java objects into JSON and back. When using this library from Scala things become a bit harder (eg: Plenty of people have difficulties when their scala object has an (im)mutable Map or List).

Here is an example to convert a JSON object to a Map\[String,String\]:

```scala
import com.google.gson.Gson
import scala.collection.JavaConversions._

val mapJson = "{ 'a': 'b', 'c': 'd' }"
val map = new Gson().fromJson(mapJson, classOf[java.util.Map[String, String]])
```

Now that we know that this works, we hide the java types in the constructor and expose a nicer scala type via a method:

```scala
case class Dummy(private val settings: java.util.Map[String, String]) {
	def getSettings = settings.toMap
}

val dummyJson = "{ 'settings' : { 'a': 'b', 'c': 'd' } }"
val dummy = new Gson().fromJson(dummyJson, classOf[Dummy])

case class Dummy2(private val options: java.util.List[String]) {
	def getOptions = options.toList
}

val dummy2Json = "{ 'options' : [ 'a', 'b', 'c', 'd' ] }"
val dummy2 = new Gson().fromJson(dummy2Json, classOf[Dummy2])
```

**Edit:** One could simply use [lift-json](https://github.com/lift/lift/tree/master/framework/lift-base/lift-json) instead and get pretty good scala support for free.