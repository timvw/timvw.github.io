---
ID: 225
post_title: Presenting a generic Range
author: timvw
post_date: 2008-05-17 19:14:14
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/05/17/presenting-a-generic-range/
published: true
---
<p>Quite often i'm writing code that compares one value against a range of other values. Most implementations compare the value against the boundaries (smallest and largest in the collection of other values). Having written this sort of code way too much i've decided to generalize the problem and distill an interface:</p>
[code lang="csharp"]public interface IRange<t>
{
 T Begin { get; set; }
 T End { get; set; }
 bool Includes(T t);
 bool Includes(IRange<t> range);
 bool Overlaps(IRange<t> range);
}[/code]
<p>Offcourse, i've also written implementation ;) Feel free to download <a href="http://www.timvw.be/wp-content/code/csharp/IRange.txt">IRange.txt</a>, <a href="http://www.timvw.be/wp-content/code/csharp/Range.txt">Range.txt</a> and <a href="http://www.timvw.be/wp-content/code/csharp/RangeTester.txt">RangeTester.txt</a></p>