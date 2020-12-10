---
title: Multiclean solution
layout: post
guid: http://www.timvw.be/?p=2267
categories:
  - Uncategorized
tags:
  - PowerShell
---
One of my favorite powershell commands when cleaning up:

```powershell
$RootFolder = 'C:\tfs'
Get-ChildItem $RootFolder bin -Recurse | Remove-Item -Recurse
Get-ChildItem $RootFolder obj -Recurse | Remove-Item -Recurse
```