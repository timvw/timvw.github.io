---
id: 226
title: Presenting a generic Effectivity
date: 2008-05-19T18:56:36+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=226
permalink: /2008/05/19/presenting-a-generic-effectivity/
tags:
  - Patterns
---
Very often we have to manage objects and their changes over time. Usually we implement this by adding a [Range<DateTime>](http://www.timvw.be/presenting-a-generic-range/) to the data. [Martin Fowler](http://martinfowler.com/) has a name for this pattern: [Effectivity](http://martinfowler.com/ap2/effectivity.html) and i have an implementation for the following interface

```csharp
public interface IEffectivity<T> : IComparable<ieffectivity<T>>
{
	T Element { get; }
	IRange<dateTime> ValidityPeriod { get; }
	bool IsEffectiveOn(DateTime validityDate);
}
```

Feel free to download [IEffectivity.txt](http://www.timvw.be/wp-content/code/csharp/IEffectivity.txt), [Effectivity.txt](http://www.timvw.be/wp-content/code/csharp/Effectivity.txt) and [EffectivityTester.txt](http://www.timvw.be/wp-content/code/csharp/EffectivityTester.txt).