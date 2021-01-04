---
date: "2009-10-29T00:00:00Z"
guid: http://www.timvw.be/?p=1490
tags:
- CSharp
title: Party for one
aliases:
 - /2009/10/29/party-for-one/
 - /2009/10/29/party-for-one.html
---
Inspired by Jimmy Bogard's [More missing LINQ operators](http://www.lostechies.com/blogs/jimmy_bogard/archive/2009/10/15/more-missing-linq-operators.aspx) i found another one

```csharp
public static IEnumerable<T> MakeEnumerable<T>(this T element)
{
	yield return element;
}
```
