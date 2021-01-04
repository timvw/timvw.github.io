---
date: "2011-01-24T00:00:00Z"
guid: http://www.timvw.be/?p=2050
tags:
- PowerShell
title: Polling the existence of a file with PowerShell
---
Sometimes you run into a situations where a given task spawns a separate thread and completes it's work on that separate thread. Eg: sending a bit XMLA to SQL Server Analysis Services with Microsoft.AnalysisServices.Deployment.exe and then waiting for the processing to be completed. Anyway, here is a simple function that will wait untill a given file exists:

```powershell  
function WaitForFile($File) {
  while(!(Test-Path $File)) {    
    Start-Sleep -s 10;   
  }  
}  
```
