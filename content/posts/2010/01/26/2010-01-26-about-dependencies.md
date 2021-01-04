---
date: "2010-01-26T00:00:00Z"
guid: http://www.timvw.be/?p=1635
tags:
- Information Technology
title: About dependencies
---
This weekend i noticed a couple of posts by Uncle Bob trying to get some discussions going. In [Mocking Mocking and Testing Outcomes](http://blog.objectmentor.com/articles/2010/01/23/mocking-mocking-and-testing-outcomes) at some point he generates a fake of some class

> “Oh, ick!” you say. Yes, I agree it’s a lot of code. On the other hand, it took me just a single keystroke on my IDE to generate all those dummy methods. (In IntelliJ it was simply command-I to implement all unimplemented methods.) So it wasn’t particularly hard. And, of course, I can put this code somewhere where nobody had to look at it unless they want to. It has the advantage that anybody who knows Java can understand it, and can look right at the methods to see what they are returning. No “special” knowledge of the mocking framework is necessary.

So adding a lot of generated code, which no-one should ever look at, is better than a mocking framework? Hahaha, why would i want to repeat myself creating all those fake objects? ([DRY](http://c2.com/cgi/wiki?DontRepeatYourself))

Another problem that i have with his example is the fact that the 'dependency' has a ton of methods that are not used by the consumer, so it makes me wonder: why are those methods there? Define an interface for the required methods, and have your consumer use that interface instead. This way you don't have to look at those unused methods which only clutter the API.

A second read made it clear that Uncle Bob is talking about unit-tests, which are typically implemented as state-based tests. In case you're doing integration tests, you will have (more) dependencies and want to verify the interaction between your system under test and the dependencies. And that is (imho) the scenario where mocking frameworks really shine 🙂
