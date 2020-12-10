---
title: Update from localtime to UTC or any other timezone with Oracle
layout: post
tags:
  - SQL
---
Imagine that you have a table with a column of the type DATETIME. You've been storing data as localtime and after a while you need to convert these datetimes to UTC. Here's a possible approach

```sql
UPDATE events SET start = SYS_EXTRACT_UTC(FROM_TZ(start, 'Europe/Brussels'));
```

You get a more generic variant using the AT TIME ZONE clause

```sql
UPDATE events SET start = FROM_TZ(start, 'Europe/Brussels') AT TIME ZONE 'America/Denver';
```
