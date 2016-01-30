---
ID: 588
post_title: Refactoring EffectivityManager
author: timvw
post_date: 2008-09-23 17:33:22
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/09/23/refactoring-effectivitymanager/
published: true
---
<p>A while ago i presented the <a href="http://www.timvw.be/presenting-a-generic-effectivitymanager/">EffectivityManager</a>. Having used this class for a while i have decided to rename it to Temporal&lt;T&gt;. The implementation of IList&lt;T&gt; is not required anymore because a user is typically only interested in a specific effectivity, not the evolution of the effectivities.</p>

[code lang="csharp"]/// <summary>
/// Represents an element that changes over time.
/// It consists out of effectivities of that element that are effective in different periods.
/// </summary>
public interface ITemporal<t>
{
 /// <summary>
 /// Modifies the element from the given date.
 /// </summary>
 /// <param name="element"></param>
 /// <param name="from"></param>
 /// <returns></returns>
 void Modify(T element, DateTime from);

 /// <summary>
 /// Gets the effectivity that is valid on the given date.
 /// </summary>
 /// <param name="validityDate">The validity date.</param>
 /// <returns></returns>
 IEffectivity<t> GetSnapshot(DateTime validityDate);

 /// <summary>
 /// Tries to get the effectivity that is valid on the given date.
 /// </summary>
 /// <param name="validityDate"></param>
 /// <param name="effectivity"></param>
 /// <returns></returns>
 bool TryGetSnapshot(DateTime validityDate, out IEffectivity<t> effectivity);
}[/code]

<p>In the implementation i have added a constructor that accepts a <a href="http://www.timvw.be/presenting-a-generic-discreterange/">DiscreteValuesGenerator&lt;DateTime&gt;</a> which makes it possible to create Periods with a resolution of a day instead of seconds.</p>