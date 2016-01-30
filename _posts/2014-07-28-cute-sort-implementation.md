---
ID: 2425
post_title: Cute sort implementation
author: timvw
post_date: 2014-07-28 09:08:31
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2014/07/28/cute-sort-implementation/
published: true
---
<p>For years I had been implementing my <a href="http://msdn.microsoft.com/en-us/library/tfakywbh(v=vs.110).aspx">sort functions</a> as following:</p>
[code lang="csharp"](x,y) =&gt; {
   if (x.PartName == null &amp;&amp; y.PartName == null) return 0;
   if (x.PartName == null) return -1;
   if (y.PartName == null) return 1;
   return x.PartName.CompareTo(y.PartName);
}[/code]
<p>Earlier today I found the following cute variant while browsing through the <a href="https://github.com/ServiceStack/ServiceStack/blob/v3/src/ServiceStack/WebHost.Endpoints/Utils/FilterAttributeCache.cs">ServiceStack</a> codebase:</p>
[code lang="csharp"]
(x,y) =&gt; x.Priority - y.Priority
[/code]