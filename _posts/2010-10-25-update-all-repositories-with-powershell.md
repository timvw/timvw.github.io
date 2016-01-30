---
ID: 1922
post_title: Update all repositories with Powershell
author: timvw
post_date: 2010-10-25 20:48:48
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/10/25/update-all-repositories-with-powershell/
published: true
---
<p>I typically store the repositories i am working on under D:\Code. Each morning i had to right click on each of those folders and select 'SVN Update' using <a href="http://tortoisesvn.tigris.org/">Tortoise SVN</a>. Today i decided there had to be a better way to accomplish this tedious task:</p>

[code lang="powershell"]
dir d:\code | foreach { svn update $_.FullName }
[/code]

<p>And in case you really like tortoise, you can do the following:</p>

[code lang="powershell"]
dir c:\code | foreach { tortoiseproc /command:update /closeonend:1 /path:$($_.FullName) }
[/code]