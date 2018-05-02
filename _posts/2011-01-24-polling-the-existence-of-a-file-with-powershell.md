---
id: 2050
title: Polling the existence of a file with PowerShell
date: 2011-01-24T21:14:04+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2050
permalink: /2011/01/24/polling-the-existence-of-a-file-with-powershell/
dsq_thread_id:
  - 1920264831
categories:
  - Uncategorized
tags:
  - PowerShell
---
Sometimes you run into a situations where a given task spawns a separate thread and completes it's work on that separate thread. Eg: sending a bit XMLA to SQL Server Analysis Services with Microsoft.AnalysisServices.Deployment.exe and then waiting for the processing to be completed. Anyway, here is a simple function that will wait untill a given file exists:

```powershell  
function WaitForFile($File) {
  while(!(Test-Path $File)) {    
    Start-Sleep -s 10;   
  }  
}  
```
