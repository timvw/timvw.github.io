---
date: "2010-02-10T00:00:00Z"
guid: http://www.timvw.be/?p=1669
tags:
- CSharp
title: Another missing method for IEnumerable<T>
---
Currently there are two overloads for OrderBy on Enumerable

* OrderBy(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector)
* OrderBy(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, IComparer<TKey> comparer)

Because i don't want to implement an IComparer<TKey> each time i have implemented the following class

```csharp
class DelegateComparer<T> : IComparer<T>
{
	public Func<t, T, int> CompareFunction { get; set; }

	public DelegateComparer(Func<t, T, int> compareFunction)
	{
		CompareFunction = compareFunction;
	}

	public int Compare(T x, T y)
	{
		return CompareFunction(x, y);
	}
}
```

And now i can define a nice extension method:

```csharp
public static IOrderedEnumerable<tsource> OrderBy<tsource, TKey>(this IEnumerable<tsource> source, Func<tsource, TKey> keySelector, Func<tkey, TKey, int> compareFunction)
{
	var comparer = new DelegateComparer<tkey>(compareFunction);
	return source.OrderBy(keySelector, comparer);
}
```
