---
date: "2008-07-19T00:00:00Z"
guid: http://www.timvw.be/?p=260
tags:
- Book reviews
title: ".NET Domain-Driven Design with C#: Problem -- Design -- Solution"
aliases:
 - /2008/07/19/net-domain-driven-design-with-c-problem-design-solution/
 - /2008/07/19/net-domain-driven-design-with-c-problem-design-solution.html
---
Since i didn't find many reviews on [Tim McCarthy's](http://blogs.interknowlogy.com/timmccarthy/) book: [.NET Domain-Driven Design with C#: Problem -- Design -- Solution](http://www.amazon.com/dp/0470147563?tag=timcsbl-20&camp=14573&creative=327641&linkCode=as1&creativeASIN=0470147563&adid=0G2QZKFS5TEKWFYAGKWG&), i've decided to write a short one myself:

This book offers a real-world example of a project using [DDD](http://en.wikipedia.org/wiki/Domain-driven_design). If you already have experience with DDD you will read pretty quickly through the chapters.

Here are a couple of items in the book i found noteworthy:

  * The IAggregateRoot marker interface that is used as a constraint on the IRepository<T> interface.
  * Code that demonstrated the power of WPF through the implementation of [Model-View-ViewModel](http://blogs.msdn.com/dancre/archive/2006/10/11/datamodel-view-viewmodel-pattern-series.aspx) and usage of the [ICommand](http://msdn.microsoft.com/en-us/library/system.windows.input.icommand.aspx).
  * Used the [IUnitOfWork.Commit](http://martinfowler.com/eaaCatalog/unitOfWork.html) method to plug a Synchronization Service into the application.

All in all, the book is worth the 26$. In case that you're looking for more examples, i would recommend [Domain Driven Design -- Table of contents and source code](http://www.goeleven.com/blog/entryDetail.aspx?entry=89) as another source of inspiration...