---
ID: 218
post_title: 'Why doesn&#039;t Visual Studio display my MSBuild message texts?'
author: timvw
post_date: 2008-03-22 16:46:12
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/03/22/why-doesnt-visual-studio-display-my-msbuild-message-texts/
published: true
---
<p>In order to debug an <a href="http://msdn2.microsoft.com/en-us/library/wea2sca5.aspx">MSBuild</a> script i added a couple of &lt;Message&gt; tasks, but when i asked Visual Studio to Build i didn't get to see the output... By default Visual Studio will use "Minimal" as <a href="http://msdn2.microsoft.com/en-us/library/ms164311.aspx">verbosity</a> level. You can change this via Tools -> Options -> Projects and Solutions -> Build and Run.</p>
<img src="http://www.timvw.be/wp-content/images/msbuildverbosity.gif" alt="screenshot of configuration dialog in visual studio that allows the user to set the verbosity of msbuild"/>