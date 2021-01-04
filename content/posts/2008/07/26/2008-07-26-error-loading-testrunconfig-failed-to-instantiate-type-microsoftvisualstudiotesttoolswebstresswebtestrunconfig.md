---
date: "2008-07-26T00:00:00Z"
guid: http://www.timvw.be/?p=283
tags:
- Visual Studio
title: "Error loading testrunconfig: Failed to instantiate type Microsoft.VisualStudio.TestTools.WebStress.WebTestRunConfig"
---
Earlier this week i ran into the following exception when opening a solution: "Error loading TestRunConfig1.testrunconfig: Failed to instantiate type Microsoft.VisualStudio.TestTools.WebStress.WebTestRunConfig".

![screenshot of testrunconfig not expected format dialog box](http://www.timvw.be/wp-content/images/testrunconfig_notexpectedformat.gif)

Apparently ([here](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=228438&SiteID=1) and [here](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=425717&SiteID=1)) the VS2005 Developer edition is missing a couple of libraries that the VS2005 Tester edition adds to the testrunconfig. If your tests don't depend on these, the simplest way to solve this problem is to remove all the values nodes, and their childnodes, where the type is defined in the Microsoft.VisualStudio.QualityTools.LoadTest, Microsoft.VisualStudio.QualityTools.WebTest and Microsoft.VisualStudio.QualityTools.LoadTest.WebStress assemblies.