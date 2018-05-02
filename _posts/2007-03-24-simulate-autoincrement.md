---
id: 157
title: Simulate AutoIncrement
date: 2007-03-24T00:25:01+00:00
author: timvw
layout: post
guid: http://www.timvw.be/simulate-autoincrement/
permalink: /2007/03/24/simulate-autoincrement/
tags:
  - SQL
---
Earlier today someone asked the following

> <div>
>   I'm trying to move selected data from one table to another. The following works apart from the destination table is not incrementing the ID (I'm not using auto increment for that field).<br /> <br /> How can I increase the value of field_1_id for each select > insert? I'm guessing SQL doesn't loop through each SELECT match an insert correspondingly?
> </div>

Here is a possible answer: (Don't forget to wrap these queries in a transaction if your MySQL Engine supports it)

```sql
-- Some demo tables (and data)
-- CREATE TABLE table1 (id INT(10), name VARCHAR(20), PRIMARY KEY(id));
-- CREATE TABLE table2 (id INT(10), name VARCHAR(20), PRIMARY KEY(id));
-- INSERT INTO table1 VALUES (1, "tim"), (2, "mike");

SET @id := (SELECT MAX(id) + 1 FROM table2);
INSERT INTO table2 SELECT @id := @id + 1, table1.name FROM (SELECT @id) AS id, table1 AS table1;
```
