---
ID: 463
post_title: 'Presenting ItemEventArgs&lt;T&gt;'
author: timvw
post_date: 2008-09-01 15:22:37
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/09/01/presenting-itemeventargst/
published: true
---
<p>Because i believe in the <a href="http://en.wikipedia.org/wiki/Don%27t_repeat_yourself">DRY</a> principle i decided to add a generic ItemEventArgs class to <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a>:</p>

[code lang="csharp"]public class ItemEventArgs<t> : EventArgs
{
 private T item;

 public ItemEventArgs(T item)
 {
  this.item = item;
 }

 public T Item
 {
  get { return this.item; }
  set { this.item = value; }
 }
}[/code]