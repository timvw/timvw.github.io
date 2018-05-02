---
id: 227
title: Presenting a generic EffectivityManager
date: 2008-05-19T19:09:33+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=227
permalink: /2008/05/19/presenting-a-generic-effectivitymanager/
tags:
  - Patterns
---
I've already presented a [Generic Effectivity](http://www.timvw.be/presenting-a-generic-effectivity/). Offcourse, managing all these effectivities (versions of data) can be handled in a generic way too. A bit of experience mixed with [Patterns for things that change with time](http://martinfowler.com/ap2/timeNarrative.html) allowed me to come up with the following interface

```csharp
public interface IEffectivityManager<T> : IList<ieffectivity<T>>
{
	IEffectivity<T> Add(T t, DateTime begin);
	IEffectivity<T> GetSnapshot(DateTime validityDate);
	bool TryGetSnapshot(DateTime validityDate, out IEffectivity<T> effectivity);
}
```

Feel free to download [IEffectivityManager.txt](http://www.timvw.be/wp-content/code/csharp/IEffectivityManager.txt), [EffectivityManager.txt](http://www.timvw.be/wp-content/code/csharp/EffectivityManager.txt) and [EffectivityManagerTester.txt](http://www.timvw.be/wp-content/code/csharp/EffectivityManagerTester.txt).
