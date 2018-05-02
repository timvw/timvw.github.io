---
id: 1955
title: Invoke PowerShell script from MSBuild
date: 2010-11-07T20:30:17+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1955
permalink: /2010/11/07/invoke-powershell-script-from-msbuild/
categories:
  - Uncategorized
tags:
  - MSBuild
  - PowerShell
---
Here is a small MSBuild target that allows you to invoke a PowerShell script, eg: powershell.exe & 'script.ps1' -SomeParam 'x'

```xml
<Target Name="InvokePowerShell">
	<PropertyGroup>
		<PowerShellCommand>"$(PowerShellTool)" "& '$(ScriptFile)' -SomeParam '$(SomeParam)' "</PowerShellCommand>
	</PropertyGroup>
	<Exec Command="$(PowerShellCommand)" />
</Target>
```
