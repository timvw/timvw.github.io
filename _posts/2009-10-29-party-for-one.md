---
ID: 1490
post_title: Party for one
author: timvw
post_date: 2009-10-29 09:11:06
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/10/29/party-for-one/
published: true
---
<p>Inspired by Jimmy Bogard's <a href="http://www.lostechies.com/blogs/jimmy_bogard/archive/2009/10/15/more-missing-linq-operators.aspx">More missing LINQ operators</a> i found another one:</p>

[code lang="csharp"]public static IEnumerable<t> MakeEnumerable<t>(this T element)
{
 yield return element;
}[/code]