---
ID: 1986
post_title: >
  Load all script files at PowerShell
  startup
author: timvw
post_date: 2010-11-17 21:28:25
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/11/17/load-all-script-files-at-powershell-startup/
published: true
---
<p>These days i have quite some scripts files that i want to be loaded each time i launch PowerShell. <a href="http://msdn.microsoft.com/en-us/library/bb613488%28VS.85%29.aspx">Windows PowerShell Profiles</a> teaches me where i should store my $profile. Here is what it looks like:</p>

[code lang="powershell"]
# Lookup powershell scripts location
$UserProfile = (Get-ChildItem Env:UserProfile).Value;
$ScriptFolder = &quot;$UserProfile\My documents\WindowsPowerShell&quot;;

# Source all .ps1 files in PowerShell profile folder
Get-ChildItem $ScriptFolder -name -include '*.ps1' -exclude 'profile.ps1' 
 | foreach {  (. &quot;$ScriptFolder\$_&quot;) };

# Configure environment for VS2010
SetVS2010;
[/code]