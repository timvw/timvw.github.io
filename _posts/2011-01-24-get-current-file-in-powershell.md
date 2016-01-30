---
ID: 2044
post_title: Get current file in PowerShell
author: timvw
post_date: 2011-01-24 20:23:58
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/01/24/get-current-file-in-powershell/
published: true
dsq_thread_id:
  - "1924327119"
---
<p>A while ago i wrote a small script to take care of deployment. Configuring the source folders went as following:</p>
[code lang="powershell"]
param(
	$BaseDir = (Get-Location).Path,
	$WebDir = (Resolve-Path &quot;$BaseDir\web&quot;),
	$DatabaseDir = (Resolve-Path &quot;$BaseDir\database&quot;)
)
[/code]

<p>The problem with this code is that it only works when your current working directory is set to the location of this script. An administrator (or build system) invokes the script as following:</p>

[code lang="powershell"]
PS C:\Users\Admin&gt;&amp; 'D:\Deployments\20110124\Deploy.ps1';
[/code]

<p>Because we don't want to annoy the consumer of our script with the burden of making sure he is in the correct directory we modified our code as following:</p>

[code lang="powershell"]
param(
	$BaseDir = (Split-Path $MyInvocation.MyCommand.Definition),
	$WebDir = (Resolve-Path &quot;$BaseDir\web&quot;),
	$DatabaseDir = (Resolve-Path &quot;$BaseDir\database&quot;)
)
[/code]

<p>A quick win :)</p>