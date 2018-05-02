---
id: 1490
title: Party for one
date: 2009-10-29T09:11:06+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1490
permalink: /2009/10/29/party-for-one/
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
