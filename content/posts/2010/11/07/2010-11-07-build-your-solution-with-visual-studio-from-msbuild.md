---
date: "2010-11-07T00:00:00Z"
guid: http://www.timvw.be/?p=1947
tags:
- MSBuild
- ssas
- Visual Studio
title: Build your solution with Visual Studio from MSBuild
aliases:
 - /2010/11/07/build-your-solution-with-visual-studio-from-msbuild/
 - /2010/11/07/build-your-solution-with-visual-studio-from-msbuild.html
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
