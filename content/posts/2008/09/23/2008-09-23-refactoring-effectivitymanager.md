---
date: "2008-09-23T00:00:00Z"
guid: http://www.timvw.be/?p=588
tags:
- CSharp
- Patterns
title: Refactoring EffectivityManager
aliases:
 - /2008/09/23/refactoring-effectivitymanager/
 - /2008/09/23/refactoring-effectivitymanager.html
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
