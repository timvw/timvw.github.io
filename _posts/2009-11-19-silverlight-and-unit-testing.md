---
ID: 1517
post_title: Silverlight and unit testing..
author: timvw
post_date: 2009-11-19 21:32:13
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/11/19/silverlight-and-unit-testing/
published: true
dsq_thread_id:
  - "1933325202"
---
<p>A while ago i was looking for a unittesting framework that can be used with Silverlight. Because i don't want to launch a webbrowser on my buildserver i ruled the <a href="http://code.msdn.microsoft.com/silverlightut/">Unit Test Framework for Microsoft Silverlight</a> out. A couple of websearches later i decided to try a Silverlight port of good ol' NUnit, <a href="http://code.google.com/p/nunitsilverlight/">nunitsilverlight</a>, and was pretty pleased with results.</p>

<p>A couple of things to keep in mind though:</p>
<ul>
<li>Make sure your test runner loads the correct System assembly (Possible solution: set Copy Local to true in your test project)</li>
<li>In case your test runner has to run tests in both 'regular' and 'silverlight' assemblies, make sure that your runner uses separate AppDomains (For NUnit use the /Domain=Multiple option)</li>
</ul>