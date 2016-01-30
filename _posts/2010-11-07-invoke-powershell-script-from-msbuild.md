---
ID: 1955
post_title: Invoke PowerShell script from MSBuild
author: timvw
post_date: 2010-11-07 20:30:17
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/11/07/invoke-powershell-script-from-msbuild/
published: true
---
<p>Here is a small MSBuild target that allows you to invoke a PowerShell script, eg: powershell.exe & 'script.ps1' -SomeParam 'x'</p>

[code lang="xml"]
&lt;Target Name=&quot;InvokePowerShell&quot;&gt;
 &lt;PropertyGroup&gt;
  &lt;PowerShellCommand&gt;&quot;$(PowerShellTool)&quot; &quot;&amp;amp; '$(ScriptFile)' -SomeParam '$(SomeParam)' &quot;&lt;/PowerShellCommand&gt;
 &lt;/PropertyGroup&gt;
 &lt;Exec Command=&quot;$(PowerShellCommand)&quot; /&gt;
&lt;/Target&gt;
[/code]