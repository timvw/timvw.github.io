---
id: 88
title: Custom ordering with MySQL
date: 2004-12-09T01:10:34+00:00
author: timvw
layout: post
guid: http://www.timvw.be/custom-ordering-with-mysql/
permalink: /2004/12/09/custom-ordering-with-mysql/
tags:
  - SQL
---
As a follow up to [Custom Ordering](http://www.timvw.be/custom-ordering) I discovered the nice [Field](http://dev.mysql.com/doc/mysql/en/String_functions.html) function in [MySQL.](http://www.mysql.com) after it was mentionned on my favorite [PHP Forum](http://forums.devnetwork.net) by [Weirdan](http://forums.devnetwork.net/profile.php?mode=viewprofile&u=7815). It allows one to order a column on a custom order relation.

```sql
SELECT * 
FROM foo
ORDER BY FIELD(column, 'Z', 'B', 'C') 
```
