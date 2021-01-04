---
date: "2009-09-29T00:00:00Z"
guid: http://www.timvw.be/?p=1278
tags:
- CSharp
title: Improve readability with LINQ
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
