---
id: 43
title: Select the first 50 words of an article
date: 2006-01-18T02:57:59+00:00
author: timvw
layout: post
guid: http://www.timvw.be/select-the-first-50-words-of-an-article/
permalink: /2006/01/18/select-the-first-50-words-of-an-article/
tags:
  - SQL
---
I am cleaning up my code snippets and i found the following little trick in one of them that i have removed. Assuming that different words are separated by spaces we can use [SUBSTRING_INDEX](http://dev.mysql.com/doc/refman/5.0/en/string-functions.html) as following

```sql
SELECT SUBSTRING_INDEX(body,' ',50) AS dn FROM mytable
```
