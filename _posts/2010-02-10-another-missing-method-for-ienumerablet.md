---
ID: 1669
post_title: 'Another missing method for IEnumerable&lt;T&gt;'
author: timvw
post_date: 2010-02-10 19:29:33
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/02/10/another-missing-method-for-ienumerablet/
published: true
---
<p>Currently there are two overloads for OrderBy on Enumerable:</p>

<ul>
<li>OrderBy(this IEnumerable&lt;TSource&gt; source, Func&lt;TSource, TKey&gt; keySelector)</li>
<li>OrderBy(this IEnumerable&lt;TSource&gt; source, Func&lt;TSource, TKey&gt; keySelector, IComparer&lt;TKey&gt; comparer)</li>
</ul>

<p>Because i don't want to implement an IComparer&lt;TKey&gt; each time i have implemented the following class:</p>

[code lang="csharp"]class DelegateComparer<t> : IComparer<t>
{
 public Func<t, T, int> CompareFunction { get; set; }

 public DelegateComparer(Func<t, T, int> compareFunction)
 {
  CompareFunction = compareFunction;
 }

 public int Compare(T x, T y)
 {
  return CompareFunction(x, y);
 }
}[/code]

<p>And now i can define a nice extension method:</p>

[code lang="csharp"]public static IOrderedEnumerable<tsource> OrderBy<tsource, TKey>(this IEnumerable<tsource> source, Func<tsource, TKey> keySelector, Func<tkey, TKey, int> compareFunction)
{
 var comparer = new DelegateComparer<tkey>(compareFunction);
 return source.OrderBy(keySelector, comparer);
}[/code]