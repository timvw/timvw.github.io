---
ID: 1512
post_title: >
  Couple of methods missing on
  ObservableCollection
author: timvw
post_date: 2009-11-06 16:42:40
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/11/06/couple-of-methods-missing-on-observablecollection/
published: true
---
<p>Here are a couple of methods that are missing on <a href="http://msdn.microsoft.com/en-us/library/ms668604.aspx">ObservableCollection&lt;T&gt;</a>:</p>

[code lang="csharp"]public static class ObservableCollectionExtensions
{
 public static void AddRange<t>(this ObservableCollection<t> observableCollection, IEnumerable<t> elements)
 {
  foreach (var element in elements) observableCollection.Add(element);
 }

 public static ObservableCollection<t> Create<t>(IEnumerable<t> elements)
 {
  var observableCollection = new ObservableCollection<t>();
  observableCollection.AddRange(elements);
  return observableCollection;
 }
}[/code]