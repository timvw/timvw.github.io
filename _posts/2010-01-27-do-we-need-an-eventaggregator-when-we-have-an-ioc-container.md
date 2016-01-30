---
ID: 1642
post_title: >
  Do we need an EventAggregator when we
  have an IOC container?
author: timvw
post_date: 2010-01-27 12:55:34
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/01/27/do-we-need-an-eventaggregator-when-we-have-an-ioc-container/
published: true
---
<p>An <a href="http://msdn.microsoft.com/en-us/library/cc707867.aspx">Event Aggregator</a> is an example of a <a href="http://www.eaipatterns.com/PublishSubscribeChannel.html">Publish/Subscribe channel</a>. A while ago i started wondering if we still need an Event Aggregator in our compisite applications if we have an IOC container that takes cares of dependency wiring. An IOC container can easily inject the Event/MessageHandler(s) in the Event/MessagePublisher(s)...  I'm still not sure about the answer (Yes/No).</p>