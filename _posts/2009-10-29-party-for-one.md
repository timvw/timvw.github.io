---
title: Party for one
layout: post
guid: http://www.timvw.be/?p=1490
tags:
  - 'C#'
---
Inspired by Jimmy Bogard's [More missing LINQ operators](http://www.lostechies.com/blogs/jimmy_bogard/archive/2009/10/15/more-missing-linq-operators.aspx) i found another one

```csharp
public static IEnumerable<T> MakeEnumerable<T>(this T element)
{
	yield return element;
}
```
