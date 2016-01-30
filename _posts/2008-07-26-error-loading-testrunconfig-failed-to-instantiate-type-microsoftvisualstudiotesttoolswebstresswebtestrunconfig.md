---
ID: 283
post_title: 'Error loading testrunconfig: Failed to instantiate type Microsoft.VisualStudio.TestTools.WebStress.WebTestRunConfig'
author: timvw
post_date: 2008-07-26 08:40:00
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/07/26/error-loading-testrunconfig-failed-to-instantiate-type-microsoftvisualstudiotesttoolswebstresswebtestrunconfig/
published: true
---
<p>Earlier this week i ran into the following exception when opening a solution: "Error loading TestRunConfig1.testrunconfig: Failed to instantiate type Microsoft.VisualStudio.TestTools.WebStress.WebTestRunConfig".</p>

<img src="http://www.timvw.be/wp-content/images/testrunconfig_notexpectedformat.gif" alt="screenshot of testrunconfig not expected format dialog box"/>

<p>Apparently (<a href="http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=228438&SiteID=1">here</a> and <a href="http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=425717&SiteID=1">here</a>) the VS2005 Developer edition is missing a couple of libraries that the VS2005 Tester edition adds to the testrunconfig. If your tests don't depend on these, the simplest way to solve this problem is to remove all the values nodes, and their childnodes, where the type is defined in the Microsoft.VisualStudio.QualityTools.LoadTest, Microsoft.VisualStudio.QualityTools.WebTest and Microsoft.VisualStudio.QualityTools.LoadTest.WebStress assemblies.</p>