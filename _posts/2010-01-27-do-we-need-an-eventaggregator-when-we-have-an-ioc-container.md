---
id: 1642
title: Do we need an EventAggregator when we have an IOC container?
date: 2010-01-27T12:55:34+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1642
permalink: /2010/01/27/do-we-need-an-eventaggregator-when-we-have-an-ioc-container/
tags:
  - Information Technology
  - Patterns
---
An [Event Aggregator](http://msdn.microsoft.com/en-us/library/cc707867.aspx) is an example of a [Publish/Subscribe channel](http://www.eaipatterns.com/PublishSubscribeChannel.html). A while ago i started wondering if we still need an Event Aggregator in our compisite applications if we have an IOC container that takes cares of dependency wiring. An IOC container can easily inject the Event/MessageHandler(s) in the Event/MessagePublisher(s)... I'm still not sure about the answer (Yes/No).
