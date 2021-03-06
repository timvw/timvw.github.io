---
date: "2011-03-05T00:00:00Z"
guid: http://www.timvw.be/?p=2067
tags:
- PowerShell
- SSIS
title: Consume custom SSIS tasks without GAC installation
---
For a while i thought that in order to consume a custom SSIS task you had to install the assembly in the GAC. Now i know better 😉

For the designer (BIDS) you have to copy the files to
* C\:\Program Files\Microsoft SQL Server\100\DTS\Tasks
* C\:\Program Files\Microsoft SQL Server\100\DTS\PipelineComponents

For the runtime (BIDS) you have to copy the files to
* C\:\Program Files\Microsoft Visual Studio 9.0\Common7\IDE\PrivateAssemblies

And for dtexec you have to copy the files to
* C\:\Program Files\Microsoft SQL Server\100\DTS\Binn

Here is a small powershell script that gives you the paths where you want to copy your assembly to:

```powershell
# Lookup Tasks, PipelineComponents and DtExec paths  
$DtsPath = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\100\DTS\Setup').SQLPath;
$DtsTasksPath = (Resolve-Path "$DtsPath\Tasks");

$DtsPipelineComponentsPath = (Resolve-Path "$DtsPath\Pipelinecomponents");
$DtExecPath = (Resolve-Path "$DtsPath\Binn");

# Lookup VS2008/Bids path
$Vs2008Path = (Get-ItemProperty 'HKLM:\Software\Microsoft\VisualStudio\9.0').InstallDir;
$Vs2008PrivateAssembliesPath = (Resolve-Path "$Vs2008Path\PrivateAssemblies");
```
