---
date: "2009-03-14T00:00:00Z"
guid: http://www.timvw.be/?p=857
tags:
- C#
- Visual Studio
title: Another reason for not using mstest
aliases:
 - /2009/03/14/another-reason-for-not-using-mstest/
 - /2009/03/14/another-reason-for-not-using-mstest.html
---
As you can read in [CA1001](http://msdn.microsoft.com/en-us/library/ms182172(VS.80).aspx): Types that own disposable fields should be disposable. Pretty solid advice, but for some reason the mstest runner does not dispose of classes that implement IDisposable. A possible workaround is to apply a [TestCleanupAttribute](http://msdn.microsoft.com/en-us/library/microsoft.visualstudio.testtools.unittesting.testcleanupattribute(VS.80).aspx) to the Dispose method, but this is really contradictory with the "Shared test fixture" approach mstest uses. Imho, there is only one clean solution: use a decent testing framework instead.
