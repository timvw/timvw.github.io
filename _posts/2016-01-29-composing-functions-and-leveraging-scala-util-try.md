---
title: Composing functions and leveraging scala.util.Try
layout: post
guid: http://www.timvw.be/?p=2532
categories:
  - Uncategorized
tags:
  - fsharp
  - railway oriented programming
  - scala
---
Last couple of days I have been hacking around trying to find a cute way to express the intent of my code. Typically it involves parsing some input, validating whatever rules that are in charge and persisting some values. In scala one can compose such a function by using the [andThen](http://www.scala-lang.org/api/2.11.x/index.html#scala.Function1) method. Here is a concrete example:

```scala
def id(x: String) = x  
def parseInput = id _
def validate = id _
def persist = id _

def usecase1 = parseInput andThen validate andThen persist
```
Inspired by the excellent series on [Railway Oriented Programming](http://fsharpforfunandprofit.com/posts/recipe-part2/) series by [Scott Wlaschin](@ScottWlaschin) I wanted to take advange of [scala.util.Try](http://www.scala-lang.org/files/archive/api/current/index.html#scala.util.Try) to remove try/catch clutter from my code. With a little helper function I can now compose my usecase as following:

```scala
def makeTry[TIn, TOut](fn: TIn => TOut) = (x: TIn) => Try(fn(x))

def usecase =
	makeTry(parseInput andThen validate andThen persist) andThen
	processErrors andThen
	proceedOrRetry
```
Instead of composing functions I could have also written code as a chain of values that are transformed by subsequent functions as following (Very much fsharp like):

```scala
class Pipe[T](val x: T) {
	def |> [U](f: T => U) = f(x)
}

implicit def toPipe[T](x: T) = new Pipe(x)

def usecase(x: String) = 
	Try(x |> parseInput |> validate |> persist) |>
	processErrors |>
	proceedOrRetry
```

As you can see, with scala there is more than one way to express something in an elegant way!