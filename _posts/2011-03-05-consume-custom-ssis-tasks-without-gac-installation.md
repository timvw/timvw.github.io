---
ID: 2067
post_title: >
  Consume custom SSIS tasks without GAC
  installation
author: timvw
post_date: 2011-03-05 16:30:25
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/03/05/consume-custom-ssis-tasks-without-gac-installation/
published: true
dsq_thread_id:
  - "1923240007"
---
<p>For a while i thought that in order to consume a custom SSIS task you had to install the assembly in the GAC. Now i know better ;)</p>

<p>For the designer (BIDS) you have to copy the files to:<br/>
C:\Program Files\Microsoft SQL Server\100\DTS\Tasks
C:\Program Files\Microsoft SQL Server\100\DTS\PipelineComponents
</p>

<p>For the runtime (BIDS) you have to copy the files to:<br/>
C:\Program Files\Microsoft Visual Studio 9.0\Common7\IDE\PrivateAssemblies
</p>

<p>And for dtexec you have to copy the files to:<br/>
C:\Program Files\Microsoft SQL Server\100\DTS\Binn
<p>

<p>Here is a small powershell script that gives you the paths where you want to copy your assembly to:</p>

[code lang="powershell"]
# Lookup Tasks, PipelineComponents and DtExec paths
$DtsPath = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\100\DTS\Setup').SQLPath;
$DtsTasksPath = (Resolve-Path &quot;$DtsPath\Tasks&quot;);
$DtsPipelineComponentsPath = (Resolve-Path &quot;$DtsPath\Pipelinecomponents&quot;);
$DtExecPath = (Resolve-Path &quot;$DtsPath\Binn&quot;);

# Lookup VS2008/Bids path
$Vs2008Path = (Get-ItemProperty 'HKLM:\Software\Microsoft\VisualStudio\9.0').InstallDir;
$Vs2008PrivateAssembliesPath = (Resolve-Path &quot;$Vs2008Path\PrivateAssemblies&quot;);
[/code]