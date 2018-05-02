---
id: 1962
title: Modify a text file with PowerShell
date: 2010-11-07T20:44:22+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1962
permalink: /2010/11/07/modify-a-text-file-with-powershell/
dsq_thread_id:
  - 1920241104
categories:
  - Uncategorized
tags:
  - PowerShell
---
A while ago i wanted to update a connection string in a configuration file. My first attempt was the following:

```powershell
Get-Content $File
| Foreach { $_ -Replace "Source>(.*?)<", "Source>$New<" }
| Set-Content $File;
```

Running this scripts leads to the following error: "Set-Content : The process cannot access the file because it is being used by another process." In order to avoid this you can complete the read operation before you start writing as following:

```powershell
(Get-Content $File)
| Foreach { $_ -Replace "Source>(.*?)<", "Source>$New<" }
| Set-Content $File;
```
