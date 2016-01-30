---
ID: 226
post_title: Presenting a generic Effectivity
author: timvw
post_date: 2008-05-19 18:56:36
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/05/19/presenting-a-generic-effectivity/
published: true
---
<p>Very often we have to manage objects and their changes over time. Usually we implement this by adding a <a href="http://www.timvw.be/presenting-a-generic-range/">Range&lt;DateTime&gt;</a> to the data. <a href="http://martinfowler.com/">Martin Fowler</a> has a name for this pattern: <a href="http://martinfowler.com/ap2/effectivity.html">Effectivity</a> and i have an implementation for the following interface:</p>
[code lang="csharp"]public interface IEffectivity<t> : IComparable<ieffectivity<t>>
{
 T Element { get; }
 IRange<dateTime> ValidityPeriod { get; }
 bool IsEffectiveOn(DateTime validityDate);
}[/code]
<p>Feel free to download <a href="http://www.timvw.be/wp-content/code/csharp/IEffectivity.txt">IEffectivity.txt</a>, <a href="http://www.timvw.be/wp-content/code/csharp/Effectivity.txt">Effectivity.txt</a> and <a href="http://www.timvw.be/wp-content/code/csharp/EffectivityTester.txt">EffectivityTester.txt</a>.</p>