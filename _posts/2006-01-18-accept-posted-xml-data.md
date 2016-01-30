---
ID: 42
post_title: Accept posted XML data
author: timvw
post_date: 2006-01-18 02:57:07
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/01/18/accept-posted-xml-data/
published: true
---
<p>I remember that i've spent a lot of time finding something that allowed me to accept the posted XML data. The solution was very simple:</p>
[code lang="php"]
$data = file_get_contents('php://input');
[/code]