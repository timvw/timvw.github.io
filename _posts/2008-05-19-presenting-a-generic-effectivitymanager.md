---
ID: 227
post_title: Presenting a generic EffectivityManager
author: timvw
post_date: 2008-05-19 19:09:33
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/05/19/presenting-a-generic-effectivitymanager/
published: true
---
<p>I've already presented a <a href="http://www.timvw.be/presenting-a-generic-effectivity/">Generic Effectivity</a>. Offcourse, managing all these effectivities (versions of data) can be handled in a generic way too. A bit of experience mixed with <a href="http://martinfowler.com/ap2/timeNarrative.html">Patterns for things that change with time</a> allowed me to come up with the following interface:</p>
[code lang="csharp"]public interface IEffectivityManager<t> : IList<ieffectivity<t>>
{
 IEffectivity<t> Add(T t, DateTime begin);
 IEffectivity<t> GetSnapshot(DateTime validityDate);
 bool TryGetSnapshot(DateTime validityDate, out IEffectivity<t> effectivity);
}[/code]
<p>Feel free to download <a href="http://www.timvw.be/wp-content/code/csharp/IEffectivityManager.txt">IEffectivityManager.txt</a>, <a href="http://www.timvw.be/wp-content/code/csharp/EffectivityManager.txt">EffectivityManager.txt</a> and <a href="http://www.timvw.be/wp-content/code/csharp/EffectivityManagerTester.txt">EffectivityManagerTester.txt</a>.</p>