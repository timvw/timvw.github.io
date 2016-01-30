---
ID: 1962
post_title: Modify a text file with PowerShell
author: timvw
post_date: 2010-11-07 20:44:22
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/11/07/modify-a-text-file-with-powershell/
published: true
dsq_thread_id:
  - "1920241104"
---
<p>A while ago i wanted to update a connection string in a configuration file. My first attempt was the following:</p>

[code lang="powershell"]
Get-Content $File 
| Foreach { $_ -Replace &quot;Source&gt;(.*?)&lt;&quot;, &quot;Source&gt;$New&lt;&quot; } 
| Set-Content $File;
[/code]

<p>Running this scripts leads to the following error: "Set-Content : The process cannot access the file because it is being used by another process." In order to avoid this you can complete the read operation before you start writing as following:</p>

[code lang="powershell"]
(Get-Content $File) 
| Foreach { $_ -Replace &quot;Source&gt;(.*?)&lt;&quot;, &quot;Source&gt;$New&lt;&quot; } 
| Set-Content $File;
[/code]