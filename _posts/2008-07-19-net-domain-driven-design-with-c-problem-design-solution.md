---
ID: 260
post_title: '.NET Domain-Driven Design with C#: Problem &#8211; Design &#8211; Solution'
author: timvw
post_date: 2008-07-19 15:43:18
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/07/19/net-domain-driven-design-with-c-problem-design-solution/
published: true
---
<p>Since i didn't find many reviews on <a href="http://blogs.interknowlogy.com/timmccarthy/">Tim McCarthy's</a> book: <a href="http://www.amazon.com/dp/0470147563?tag=timcsbl-20&camp=14573&creative=327641&linkCode=as1&creativeASIN=0470147563&adid=0G2QZKFS5TEKWFYAGKWG&">.NET Domain-Driven Design with C#: Problem - Design - Solution</a>, i've decided to write a short one myself:</p>

<p>This book offers a real-world example of a project using <a href="http://en.wikipedia.org/wiki/Domain-driven_design">DDD</a>. If you already have experience with DDD you will read pretty quickly through the chapters.</p>

<p>Here are a couple of items in the book i found noteworthy:</p>
<ul>
<li>The IAggregateRoot marker interface that is used as a constraint on the IRepository&lt;T&gt; interface.</li>
<li>Code that demonstrated the power of WPF through the implementation of <a href="http://blogs.msdn.com/dancre/archive/2006/10/11/datamodel-view-viewmodel-pattern-series.aspx">Model-View-ViewModel</a> and usage of the <a href="http://msdn.microsoft.com/en-us/library/system.windows.input.icommand.aspx">ICommand</a>.</li>
<li>Used the <a href="http://martinfowler.com/eaaCatalog/unitOfWork.html">IUnitOfWork.Commit</a> method to plug a Synchronization Service into the application.</li>
</ul>

<p>All in all, the book is worth the 26$. In case that you're looking for more examples, i would recommend <a href="http://www.goeleven.com/blog/entryDetail.aspx?entry=89">Domain Driven Design - Table of contents and source code</a> as another source of inspiration...</p>