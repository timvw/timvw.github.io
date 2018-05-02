---
id: 1986
title: Load all script files at PowerShell startup
date: 2010-11-17T21:28:25+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1986
permalink: /2010/11/17/load-all-script-files-at-powershell-startup/
categories:
  - Uncategorized
tags:
  - PowerShell
---
These days i have quite some scripts files that i want to be loaded each time i launch PowerShell. [Windows PowerShell Profiles](http://msdn.microsoft.com/en-us/library/bb613488%28VS.85%29.aspx) teaches me where i should store my $profile. Here is what it looks like:

```powershell
# Lookup powershell scripts location
$UserProfile = (Get-ChildItem Env:UserProfile).Value;
$ScriptFolder = "$UserProfile\My documents\WindowsPowerShell";

# Source all .ps1 files in PowerShell profile folder  
Get-ChildItem $ScriptFolder -name -include '*.ps1' -exclude 'profile.ps1'   
| foreach { (. "$ScriptFolder\$_") };

# Configure environment for VS2010  
SetVS2010;
```
