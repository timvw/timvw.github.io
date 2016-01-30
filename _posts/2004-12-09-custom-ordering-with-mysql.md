---
ID: 88
post_title: Custom ordering with MySQL
author: timvw
post_date: 2004-12-09 01:10:34
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2004/12/09/custom-ordering-with-mysql/
published: true
---
<p>As a follow up to <a href="http://www.timvw.be/custom-ordering">Custom Ordering</a> I discovered the nice <a href="http://dev.mysql.com/doc/mysql/en/String_functions.html">Field</a>  function in <a href="http://www.mysql.com">MySQL.</a> after it was mentionned on my favorite <a href="http://forums.devnetwork.net">PHP Forum</a> by <a href="http://forums.devnetwork.net/profile.php?mode=viewprofile&amp;u=7815">Weirdan</a>. It allows one to order a column on a custom order relation.</p>
[code lang="sql"]
SELECT *
FROM foo
ORDER BY FIELD(column, 'Z', 'B', 'C')
[/code]