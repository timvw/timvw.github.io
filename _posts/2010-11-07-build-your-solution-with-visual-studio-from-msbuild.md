---
id: 1947
title: Build your solution with Visual Studio from MSBuild
date: 2010-11-07T20:16:36+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1947
permalink: /2010/11/07/build-your-solution-with-visual-studio-from-msbuild/
categories:
  - Uncategorized
tags:
  - MSBuild
  - ssas
  - Visual Studio
---
Unfortunately MSBuild and [BIDS Helper](http://bidshelper.codeplex.com/) are not able to build an .asdatabase from our Analysis Services project (.dwproj). Here is a task which invokes Visual Studio to build such a solution:

```xml
<Target Name="DevEnvBuild">
	<Error Condition="'$(SolutionFile)'=="" Text="Missing SolutionFile" />
	<PropertyGroup>
		<DevEnvTool Condition="'$(DevEnvTool)'=="">C:\Program Files\Microsoft Visual Studio 9.0\Common7\IDE\devenv.exe</DevEnvTool>
		<DevEnvSwitch Condition="'$(DevEnvSwitch)'=="">Build</DevEnvSwitch>
		<DevEnvBuildCommand>"$(DevEnvTool)" "$(SolutionFile)" /$(DevEnvSwitch)</DevEnvBuildCommand>
	</PropertyGroup>
	<Exec Command="$(DevEnvBuildCommand)" />
</Target>
```
