---
date: "2009-11-19T00:00:00Z"
guid: http://www.timvw.be/?p=1517
tags:
- Silverlight
title: Silverlight and unit testing..
---
A while ago i was looking for a unittesting framework that can be used with Silverlight. Because i don't want to launch a webbrowser on my buildserver i ruled the [Unit Test Framework for Microsoft Silverlight](http://code.msdn.microsoft.com/silverlightut/) out. A couple of websearches later i decided to try a Silverlight port of good ol' NUnit, [nunitsilverlight](http://code.google.com/p/nunitsilverlight/), and was pretty pleased with results.

A couple of things to keep in mind though:

  * Make sure your test runner loads the correct System assembly (Possible solution: set Copy Local to true in your test project)
  * In case your test runner has to run tests in both 'regular' and 'silverlight' assemblies, make sure that your runner uses separate AppDomains (For NUnit use the /Domain=Multiple option)
