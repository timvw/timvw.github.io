---
title: Restore from a MySQL dumpfile
layout: post
tags:
  - Bash
---
If you are a longtime user of [mysqldump](http://dev.mysql.com/doc/refman/5.0/en/mysqldump.html) you may have experienced that restoring with mysql < dumpfile doesn't always work because of referential problems. Here is a little script that takes care of it: [mysql-restore.txt](http://www.timvw.be/wp-content/code/bash/mysql-restore.txt).
