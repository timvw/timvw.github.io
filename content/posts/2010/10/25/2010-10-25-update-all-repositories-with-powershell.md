---
date: "2010-10-25T00:00:00Z"
guid: http://www.timvw.be/?p=1922
tags:
- PowerShell
- TortoiseSVN
title: Update all repositories with Powershell
aliases:
 - /2010/10/25/update-all-repositories-with-powershell/
 - /2010/10/25/update-all-repositories-with-powershell.html
---
I typically store the repositories i am working on under D:\Code. Each morning i had to right click on each of those folders and select 'SVN Update' using [Tortoise SVN](http://tortoisesvn.tigris.org/). Today i decided there had to be a better way to accomplish this tedious task:

```powershell
dir d:\code | foreach { svn update $_.FullName }
```

And in case you really like tortoise, you can do the following:

```powershell
dir c:\code | foreach { tortoiseproc /command:update /closeonend:1 /path:$($_.FullName) }
```
