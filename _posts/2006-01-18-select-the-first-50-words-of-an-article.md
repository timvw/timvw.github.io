---
ID: 43
post_title: Select the first 50 words of an article
author: timvw
post_date: 2006-01-18 02:57:59
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/01/18/select-the-first-50-words-of-an-article/
published: true
---
<p>I'm cleaning up my code snippets and i found the following little trick in one of them that i've removed. Assuming that different words are separated by spaces we can use <a href="http://dev.mysql.com/doc/refman/5.0/en/string-functions.html">SUBSTRING_INDEX</a> as following:</p>
[code lang="sql"]
SELECT SUBSTRING_INDEX(body,' ',50) AS dn FROM mytable
[/code]