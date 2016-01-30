---
ID: 857
post_title: Another reason for not using mstest
author: timvw
post_date: 2009-03-14 07:11:43
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/03/14/another-reason-for-not-using-mstest/
published: true
dsq_thread_id:
  - "1926745973"
---
<p>As you can read in <a href="http://msdn.microsoft.com/en-us/library/ms182172(VS.80).aspx">CA1001</a>: Types that own disposable fields should be disposable. Pretty solid advice, but for some reason the mstest runner does not dispose of classes that implement IDisposable. A possible workaround is to apply a <a href="http://msdn.microsoft.com/en-us/library/microsoft.visualstudio.testtools.unittesting.testcleanupattribute(VS.80).aspx">TestCleanupAttribute</a> to the Dispose method, but this is really contradictory with the "Shared test fixture" approach mstest uses. Imho, there is only one clean solution: use a decent testing framework instead.</p>