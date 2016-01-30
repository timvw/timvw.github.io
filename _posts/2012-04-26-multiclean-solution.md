---
ID: 2267
post_title: Multiclean solution
author: timvw
post_date: 2012-04-26 15:08:07
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2012/04/26/multiclean-solution/
published: true
---
One of my favorite powershell commands when cleaning up:

[code lang="powershell"]
$RootFolder = 'C:\tfs'
Get-ChildItem $RootFolder bin -Recurse | Remove-Item -Recurse
Get-ChildItem $RootFolder obj -Recurse | Remove-Item -Recurse
[/code]