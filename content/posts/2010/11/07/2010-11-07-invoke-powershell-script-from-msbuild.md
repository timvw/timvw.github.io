---
date: "2010-11-07T00:00:00Z"
guid: http://www.timvw.be/?p=1955
tags:
- MSBuild
- PowerShell
title: Invoke PowerShell script from MSBuild
aliases:
 - /2010/11/07/invoke-powershell-script-from-msbuild/
 - /2010/11/07/invoke-powershell-script-from-msbuild.html
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
