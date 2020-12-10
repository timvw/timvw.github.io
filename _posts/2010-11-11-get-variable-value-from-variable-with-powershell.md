---
title: Get variable value from variable with PowerShell
layout: post
guid: http://www.timvw.be/?p=1972
dsq_thread_id:
  - 1923497345
categories:
  - Uncategorized
tags:
  - PowerShell
---
Sometimes you only know at runtime in which variable a certain value is stored. Let me clarify with an example:

```powershell
$tim = 30;
$evy = 24;
$name = Read-Host "Enter your name";
```

In essence, if $name equals tim we want to use $tim and if $name equals evy we want to use $evy. This can be achieved with Get-Variable:

```powershell
$age = Get-Variable $name -valueOnly;
Write-Host "Your age is $age";
```
