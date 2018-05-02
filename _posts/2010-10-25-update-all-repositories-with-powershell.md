---
id: 1922
title: Update all repositories with Powershell
date: 2010-10-25T20:48:48+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1922
permalink: /2010/10/25/update-all-repositories-with-powershell/
categories:
  - Uncategorized
tags:
  - PowerShell
  - TortoiseSVN
---
I typically store the repositories i am working on under D:\Code. Each morning i had to right click on each of those folders and select 'SVN Update' using [Tortoise SVN](http://tortoisesvn.tigris.org/). Today i decided there had to be a better way to accomplish this tedious task:

```powershell
dir d:\code | foreach { svn update $_.FullName }
```

And in case you really like tortoise, you can do the following:

```powershell
dir c:\code | foreach { tortoiseproc /command:update /closeonend:1 /path:$($_.FullName) }
```
