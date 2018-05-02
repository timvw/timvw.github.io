---
id: 1278
title: Improve readability with LINQ
date: 2009-09-29T18:18:32+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1278
permalink: /2009/09/29/improve-readability-with-linq/
tags:
  - 'C#'
---
At first i was not very fond of LINQ but it seems that i am finally convinced that LINQ may improve readability:

```csharp
bool IsCompleted()
{
	var boxesNotOnGoal = from cell in Cells
	where cell.HoldsBox() && !cell.IsGoal()
	select cell.Piece;

	return boxesNotOnGoal.Any();
}
```
