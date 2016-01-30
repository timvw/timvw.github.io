---
ID: 1278
post_title: Improve readability with LINQ
author: timvw
post_date: 2009-09-29 18:18:32
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/09/29/improve-readability-with-linq/
published: true
---
<p>At first i was not very fond of LINQ but it seems that i am finally convinced that LINQ may improve readability:</p>

[code lang="csharp"]bool IsCompleted()
{
 var boxesNotOnGoal = from cell in Cells
                      where cell.HoldsBox() && !cell.IsGoal()
                      select cell.Piece;

 return boxesNotOnGoal.Any();
}[/code]