---
ID: 2523
post_title: Using Gson to serialize Scala objects
author: timvw
post_date: 2016-01-14 21:43:09
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2016/01/14/using-gson-to-serialize-scala-objects/
published: true
---
<p><a href="https://github.com/google/gson">gson</a> is a pretty nice library that converts Java objects into JSON and back. When using this library from Scala things become a bit harder (eg: Plenty of people have difficulties when their scala object has an (im)mutable Map or List).</p>

<p>Here is an example to convert a JSON object to a Map[String,String]:</p>
[code lang="scala"]
import com.google.gson.Gson
import scala.collection.JavaConversions._

val mapJson = &quot;{ 'a': 'b', 'c': 'd' }&quot;
val map = new Gson().fromJson(mapJson, classOf[java.util.Map[String, String]])
[/code]

<p>Now that we know that this works, we hide the java types in the constructor and expose a nicer scala type via a method:</p>

[code lang="scala"]
case class Dummy(private val settings: java.util.Map[String, String]) {
  def getSettings = settings.toMap
}

val dummyJson = &quot;{ 'settings' : { 'a': 'b', 'c': 'd' } }&quot;
val dummy = new Gson().fromJson(dummyJson, classOf[Dummy])

case class Dummy2(private val options: java.util.List[String]) {
  def getOptions = options.toList
}

val dummy2Json = &quot;{ 'options' : [ 'a', 'b', 'c', 'd' ] }&quot;
val dummy2 = new Gson().fromJson(dummy2Json, classOf[Dummy2])

[/code]