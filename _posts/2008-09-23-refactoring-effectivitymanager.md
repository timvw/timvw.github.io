---
id: 588
title: Refactoring EffectivityManager
date: 2008-09-23T17:33:22+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=588
permalink: /2008/09/23/refactoring-effectivitymanager/
tags:
  - 'C#'
  - Patterns
---
A while ago i presented the [EffectivityManager](http://www.timvw.be/presenting-a-generic-effectivitymanager/). Having used this class for a while i have decided to rename it to Temporal<T>. The implementation of IList<T> is not required anymore because a user is typically only interested in a specific effectivity, not the evolution of the effectivities.

```csharp
public interface ITemporal<T>
{
	void Modify(T element, DateTime from);
	IEffectivity<T> GetSnapshot(DateTime validityDate);
	bool TryGetSnapshot(DateTime validityDate, out IEffectivity<T> effectivity);
}
```

In the implementation i have added a constructor that accepts a [DiscreteValuesGenerator<DateTime>](http://www.timvw.be/presenting-a-generic-discreterange/) which makes it possible to create Periods with a resolution of a day instead of seconds.
