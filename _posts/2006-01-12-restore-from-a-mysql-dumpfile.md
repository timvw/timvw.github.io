---
ID: 111
post_title: Restore from a MySQL dumpfile
author: timvw
post_date: 2006-01-12 02:16:52
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/01/12/restore-from-a-mysql-dumpfile/
published: true
---
<p>If you are a longtime user of <a href="http://dev.mysql.com/doc/refman/5.0/en/mysqldump.html">mysqldump</a> you may have experienced that restoring with mysql &lt; dumpfile doesn't always work because of referential problems. Here is a little script that takes care of it: <a href="http://www.timvw.be/wp-content/code/bash/mysql-restore.txt">mysql-restore.txt</a>.</p>