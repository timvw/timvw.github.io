---
date: "2012-04-26T00:00:00Z"
guid: http://www.timvw.be/?p=2267
tags:
- PowerShell
title: Multiclean solution
---
One of my favorite powershell commands when cleaning up:

```powershell
$RootFolder = 'C:\tfs'
Get-ChildItem $RootFolder bin -Recurse | Remove-Item -Recurse
Get-ChildItem $RootFolder obj -Recurse | Remove-Item -Recurse
```