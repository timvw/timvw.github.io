---
ID: 1972
post_title: >
  Get variable value from variable with
  PowerShell
author: timvw
post_date: 2010-11-11 13:37:45
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/11/11/get-variable-value-from-variable-with-powershell/
published: true
dsq_thread_id:
  - "1923497345"
---
<p>Sometimes you only know at runtime in which variable a certain value is stored. Let me clarify with an example:</p>

[code lang="powershell"]
$tim = 30;
$evy = 24;
$name = Read-Host &quot;Enter your name&quot;;
[/code]

<p>In essence, if $name equals tim we want to use $tim and if $name equals evy we want to use $evy. This can be achieved with Get-Variable:</p>

[code lang="powershell"]
$age = Get-Variable $name -valueOnly;
Write-Host &quot;Your age is $age&quot;;
[/code]