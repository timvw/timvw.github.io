---
ID: 164
post_title: Get the complement of a Color
author: timvw
post_date: 2007-04-26 20:40:13
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/04/26/get-the-complement-of-a-color/
published: true
---
<p>Here is a simple function that returns the complement of a given Color:</p>
[code lang="csharp"]public static void GetComplement(Color color)
{
 return Color.FromArgb(int.MaxValue - color.ToArgb());
}[/code]