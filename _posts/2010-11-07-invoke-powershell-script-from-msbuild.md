---
title: Invoke PowerShell script from MSBuild
layout: post
guid: http://www.timvw.be/?p=1955
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
