---
title: Improve readability with LINQ
layout: post
guid: http://www.timvw.be/?p=1278
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
