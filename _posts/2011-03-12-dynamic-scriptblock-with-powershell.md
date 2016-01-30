---
ID: 2090
post_title: Dynamic scriptblock with PowerShell
author: timvw
post_date: 2011-03-12 14:00:29
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/03/12/dynamic-scriptblock-with-powershell/
published: true
dsq_thread_id:
  - "1933156152"
---
<p>Earlier this week i tried to run a command on a remote computer but it did not seem to work:</p>

[code lang="powershell"]
$name = 'tim';
$computer = 'localhost';
Invoke-Command -ComputerName $computer -ScriptBlock { Write-Host &quot;Hello $name&quot; }
[/code]

<p>Because powershell serialises the { Write-Host "Hello $name" } as a string this ends up at the remote computer as { Write-Host "Hello $null" }. In order to send our 'dynamic' command string over the wire we have to make sure it is serialised correctly:</p>

[code lang="powershell"]
$scriptBlock = $executioncontext.InvokeCommand.NewScriptBlock(&quot;Write-Host `&quot;Hello $name`&quot;&quot;);
Invoke-Command -ComputerName $computer -ScriptBlock $scriptBlock;
[/code]