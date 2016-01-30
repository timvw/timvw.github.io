---
ID: 1493
post_title: Presenting PathBuilder
author: timvw
post_date: 2009-10-29 09:19:40
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/10/29/presenting-pathbuilder/
published: true
---
<p>Currently it is annoying to build a path with <a href="http://msdn.microsoft.com/en-us/library/fyy7a5kt.aspx">Path.Combine</a>:</p>

[code lang="csharp"]var home1 = Path.Combine(Path.Combine(Path.Combine("C", "Users"), "timvw"), "My Documents");[/code]

<p>And here is how it can be:</p>

[code lang="csharp"]var home2 = PathBuilder.Combine("C", "Users", "timvw", "My Documents");[/code]

<p>The implementation is pretty simple:</p>

[code lang="csharp"]public static class PathBuilder
{
 public static string Combine(params string[] parts)
 {
  return parts.Aggregate((l, r) => Path.Combine(l, r));
 }
}[/code]