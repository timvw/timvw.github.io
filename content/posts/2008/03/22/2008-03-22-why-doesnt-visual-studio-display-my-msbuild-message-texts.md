---
date: "2008-03-22T00:00:00Z"
tags:
- Visual Studio
title: "Why doesn't Visual Studio display my MSBuild message texts?"
aliases:
 - /2008/03/22/why-doesnt-visual-studio-display-my-msbuild-message-texts/
 - /2008/03/22/why-doesnt-visual-studio-display-my-msbuild-message-texts.html
---
In order to debug an [MSBuild](http://msdn2.microsoft.com/en-us/library/wea2sca5.aspx) script i added a couple of <Message> tasks, but when i asked Visual Studio to Build i didn't get to see the output... By default Visual Studio will use "Minimal" as [verbosity](http://msdn2.microsoft.com/en-us/library/ms164311.aspx) level. You can change this via Tools -> Options -> Projects and Solutions -> Build and Run.

![screenshot of configuration dialog in visual studio that allows the user to set the verbosity of msbuild](http://www.timvw.be/wp-content/images/msbuildverbosity.gif)
