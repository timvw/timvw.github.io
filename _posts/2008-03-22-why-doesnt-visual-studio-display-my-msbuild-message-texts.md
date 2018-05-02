---
id: 218
title: 'Why doesn&#039;t Visual Studio display my MSBuild message texts?'
date: 2008-03-22T16:46:12+00:00
author: timvw
layout: post
guid: http://www.timvw.be/why-doesnt-visual-studio-display-my-msbuild-message-texts/
permalink: /2008/03/22/why-doesnt-visual-studio-display-my-msbuild-message-texts/
tags:
  - Visual Studio
---
In order to debug an [MSBuild](http://msdn2.microsoft.com/en-us/library/wea2sca5.aspx) script i added a couple of <Message> tasks, but when i asked Visual Studio to Build i didn't get to see the output... By default Visual Studio will use "Minimal" as [verbosity](http://msdn2.microsoft.com/en-us/library/ms164311.aspx) level. You can change this via Tools -> Options -> Projects and Solutions -> Build and Run.

![screenshot of configuration dialog in visual studio that allows the user to set the verbosity of msbuild](http://www.timvw.be/wp-content/images/msbuildverbosity.gif)
