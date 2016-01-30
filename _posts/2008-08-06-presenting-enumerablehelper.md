---
ID: 350
post_title: Presenting EnumerableHelper
author: timvw
post_date: 2008-08-06 18:36:23
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/08/06/presenting-enumerablehelper/
published: true
dsq_thread_id:
  - "1933324487"
---
<p>I noticed (eg: <a href="http://derek-says.blogspot.com/2008/08/generic-collections-and-inheritance.html">here</a>) that i'm not the only one that has experienced some annoyances when working with generics. Here are a couple of methods that i find extremely helpful when i'm working with  <a href="http://msdn.microsoft.com/en-us/library/9eekhta0.aspx">IEnumerable&lt;T&gt;</a>:</p>

[code lang="csharp"]IEnumerable<tbase> Convert<tderived, TBase>(IEnumerable<tderived> enumerable) where TDerived : TBase;
IEnumerable<t> Convert<t>(IEnumerable enumerable);
bool HaveSameElements<t>(IEnumerable<t> enumerable1, IEnumerable<t> enumerable2, Func<bool, T, T> areEqual);
bool HaveSameElements(IEnumerable enumerable1, IEnumerable enumerable2, Func<bool, object, object> areEqual);
bool HaveSameElements(IEnumerable enumerable1, IEnumerable enumerable2);[/code]
<p>You can download the actual implementation of this Be.Timvw.Framework.Collections.Generic.EnumerableHelper class in <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a>.</p>