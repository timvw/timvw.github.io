---
date: "2010-11-11T00:00:00Z"
guid: http://www.timvw.be/?p=1972
tags:
- PowerShell
title: Get variable value from variable with PowerShell
aliases:
 - /2010/11/11/get-variable-value-from-variable-with-powershell/
 - /2010/11/11/get-variable-value-from-variable-with-powershell.html
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
