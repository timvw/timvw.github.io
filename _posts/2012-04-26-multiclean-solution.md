---
id: 2267
title: Multiclean solution
date: 2012-04-26T15:08:07+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2267
permalink: /2012/04/26/multiclean-solution/
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