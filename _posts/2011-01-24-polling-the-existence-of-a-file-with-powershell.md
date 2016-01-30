---
ID: 2050
post_title: >
  Polling the existence of a file with
  PowerShell
author: timvw
post_date: 2011-01-24 21:14:04
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/01/24/polling-the-existence-of-a-file-with-powershell/
published: true
dsq_thread_id:
  - "1920264831"
---
<p>Sometimes you run into a situations where a given task spawns a separate thread and completes it's work on that separate thread. Eg: sending a bit XMLA to SQL Server Analysis Services with Microsoft.AnalysisServices.Deployment.exe and then waiting for the processing to be completed. Anyway, here is a simple function that will wait untill a given file exists:</p>

[code lang="powershell"]
function WaitForFile($File) {
 while(!(Test-Path $File)) {
  Start-Sleep -s 10;
 }
}
[/code]