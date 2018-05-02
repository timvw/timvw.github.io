---
id: 2090
title: Dynamic scriptblock with PowerShell
date: 2011-03-12T14:00:29+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2090
permalink: /2011/03/12/dynamic-scriptblock-with-powershell/
dsq_thread_id:
  - 1933156152
categories:
  - Uncategorized
tags:
  - PowerShell
---
Earlier this week i tried to run a command on a remote computer but it did not seem to work:

```powershell
$name = 'tim'
$computer = 'localhost'
Invoke-Command -ComputerName $computer -ScriptBlock { Write-Host "Hello $name" }
```

Because powershell serialises the { Write-Host "Hello $name" } as a string this ends up at the remote computer as { Write-Host "Hello $null" }. In order to send our "dynamic"command string over the wire we have to make sure it is serialised correctly:

```powershell
$scriptBlock = $executioncontext.InvokeCommand.NewScriptBlock("Write-Host \`"Hello $name\`"");
Invoke-Command -ComputerName $computer -ScriptBlock $scriptBlock;
```
