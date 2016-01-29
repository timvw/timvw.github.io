---
ID: 2532
post_title: >
  Composing functions and leveraging
  scala.util.Try
author: timvw
post_date: 2016-01-29 19:25:09
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2016/01/29/composing-functions-and-leveraging-scala-util-try/
published: true
---
<p>Last couple of days I have been hacking around trying to find a cute way to express the intent of my code. Typically it involves parsing some input, validating whatever rules that are in charge and persisting some values. In scala one can compose such a function by using the <a href="http://www.scala-lang.org/api/2.11.x/index.html#scala.Function1">andThen</a> method. Here is a concrete example:</p>

[code lang="scala"]
def id(x: String) = x
def parseInput = id _
def validate = id _
def persist = id _

def usecase1 = parseInput andThen validate andThen persist
[/code]

<p>Inspired by the excellent series on <a href="http://fsharpforfunandprofit.com/posts/recipe-part2/">Railway Oriented Programming</a> series by <a href="@ScottWlaschin">Scott Wlaschin</a> I wanted to take advange of <a href="http://www.scala-lang.org/files/archive/api/current/index.html#scala.util.Try">scala.util.Try</a> to remove try/catch clutter from my code. With a little helper function I can now compose my usecase as following:</p>

[code lang="scala"]
def makeTry[TIn, TOut](fn: TIn =&gt; TOut) = (x: TIn) =&gt; Try(fn(x))

def usecase = 
  makeTry(parseInput andThen validate andThen persist) andThen
  processErrors andThen
  proceedOrRetry
[/code]

<p>Instead of composing functions I could have also written code as a chain of values that are transformed by subsequent functions as following (Very much fsharp like):</p>

[code lang="scala"]
class Pipe[T](val x: T) {
  def |&gt; [U](f: T =&gt; U) = f(x)
}

implicit def toPipe[T](x: T) = new Pipe(x)

def usecase(x: String) = Try(x |&gt; parseInput |&gt; validate |&gt; persist) |&gt;
  processErrors |&gt;
  proceedOrRetry
[/code]

<p>As you can see, with scala there is more than one way to express something in an elegant way! ;)</p>