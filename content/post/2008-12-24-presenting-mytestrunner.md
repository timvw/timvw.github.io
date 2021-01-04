---
date: "2008-12-24T00:00:00Z"
guid: http://www.timvw.be/?p=751
tags:
- C#
- Visual Studio
title: Presenting MyTestRunner
aliases:
 - /2008/12/24/presenting-mytestrunner/
 - /2008/12/24/presenting-mytestrunner.html
---
Here are a couple of reasons why i dislike the [Unit Testing Framework](http://msdn.microsoft.com/en-us/library/ms243147(VS.80).aspx) that comes with [Visual Studio Team System](http://msdn.microsoft.com/en-us/library/fda2bad5(VS.80).aspx):

  * Not all versions of Visual Studio are capable of running the tests.
  * Test inheritance is not supported.
  * Running tests via mstest.exe is slow.
  * Visual Studio creating tens of .vmsdi files.

There are already a couple of better frameworks out there, and currently [MbUnit](http://mbunit.com/) is my favorite one, certainly in combination with [TestDriven.NET](http://www.testdriven.net/).

I have created a custom implementation of the Microsoft.VisualStudio.QualityTools.UnitTestingFramework assembly. Actually, the assembly only has a couple of Attributes for the moment but contributions are always welcome 😉

In order to achieve better performance i decided to implement a custom test runner. Currently [Gallio](http://www.gallio.org/) uses mstest.exe but there might be a day that i decide to write a plugin so that mytestrunner can be used instead.

I was inspired by [Creating Self-testing Assemblies](http://docs.mbunit.com/help/html/MbUnitAndVisualStudio/CreatingSelfTestingAssemblies.htm) and decided to use that approach but for some odd reason visual studio insists on running unit tests although the assembly is a console application 🙁 Anyway, i can still invoke mytestrunner via the external tools as following:

![screenshot of external tools dialog](http://www.timvw.be/wp-content/images/mytestrunner-external-tools.gif)

The source code is available at <http://code.google.com/p/mytestrunner/>.