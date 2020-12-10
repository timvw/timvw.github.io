---
title: Select the first 50 words of an article
layout: post
tags:
  - SQL
---
I am cleaning up my code snippets and i found the following little trick in one of them that i have removed. Assuming that different words are separated by spaces we can use [SUBSTRING_INDEX](http://dev.mysql.com/doc/refman/5.0/en/string-functions.html) as following

```sql
SELECT SUBSTRING_INDEX(body,' ',50) AS dn FROM mytable
```
