---
ID: 751
post_title: Presenting MyTestRunner
author: timvw
post_date: 2008-12-24 13:58:11
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/12/24/presenting-mytestrunner/
published: true
---
<p>Here are a couple of reasons why i dislike the <a href="http://msdn.microsoft.com/en-us/library/ms243147(VS.80).aspx">Unit Testing Framework</a> that comes with <a href="http://msdn.microsoft.com/en-us/library/fda2bad5(VS.80).aspx">Visual Studio Team System</a>:</p>

<ul>
<li>Not all versions of Visual Studio are capable of running the tests.</li>
<li>Test inheritance is not supported.</li>
<li>Running tests via mstest.exe is slow.</li>
<li>Visual Studio creating tens of .vmsdi files.</li>
</ul>

<p>There are already a couple of better frameworks out there, and currently <a href="http://mbunit.com/">MbUnit</a> is my favorite one, certainly in combination with <a href="http://www.testdriven.net/">TestDriven.NET</a>.</p>

<p>I have created a custom implementation of the Microsoft.VisualStudio.QualityTools.UnitTestingFramework assembly. Actually, the assembly only has a couple of Attributes for the moment but contributions are always welcome ;)</p>

<p>In order to achieve better performance i decided to implement a custom test runner. Currently <a href="http://www.gallio.org/">Gallio</a> uses mstest.exe but there might be a day that i decide to write a plugin so that mytestrunner can be used instead.</p>

<p>I was inspired by <a href="http://docs.mbunit.com/help/html/MbUnitAndVisualStudio/CreatingSelfTestingAssemblies.htm">Creating Self-testing Assemblies</a> and decided to use that approach but for some odd reason visual studio insists on running unit tests although the assembly is a console application :( Anyway, i can still invoke mytestrunner via the external tools as following:</p>

<img src="http://www.timvw.be/wp-content/images/mytestrunner-external-tools.gif" alt="screenshot of external tools dialog"/>

<p>The source code is available at <a href="http://code.google.com/p/mytestrunner/">http://code.google.com/p/mytestrunner/</a>.</p>