---
title: Modify a text file with PowerShell
layout: post
guid: http://www.timvw.be/?p=1962
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
