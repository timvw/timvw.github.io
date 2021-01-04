---
date: "2006-01-18T00:00:00Z"
tags:
- SQL
title: Select the first 50 words of an article
aliases:
 - /2006/01/18/select-the-first-50-words-of-an-article/
 - /2006/01/18/select-the-first-50-words-of-an-article.html
---
I am cleaning up my code snippets and i found the following little trick in one of them that i have removed. Assuming that different words are separated by spaces we can use [SUBSTRING_INDEX](http://dev.mysql.com/doc/refman/5.0/en/string-functions.html) as following

```sql
SELECT SUBSTRING_INDEX(body,' ',50) AS dn FROM mytable
```
