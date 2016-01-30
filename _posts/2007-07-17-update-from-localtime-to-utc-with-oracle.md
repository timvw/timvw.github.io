---
ID: 180
post_title: >
  Update from localtime to UTC or any
  other timezone with Oracle
author: timvw
post_date: 2007-07-17 22:34:58
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/07/17/update-from-localtime-to-utc-with-oracle/
published: true
---
<p>Imagine that you have a table with a column of the type DATETIME. You've been storing data as localtime and after a while you need to convert these datetimes to UTC. Here's a possible approach:</p>
[code lang="sql"]UPDATE events SET start = SYS_EXTRACT_UTC(FROM_TZ(start, 'Europe/Brussels'));[/code]
<p>You get a more generic variant using the AT TIME ZONE clause:</p>
[code lang="sql"]UPDATE events SET start = FROM_TZ(start, 'Europe/Brussels') AT TIME ZONE 'America/Denver';[/code]