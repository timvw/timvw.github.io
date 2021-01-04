---
date: "2006-08-21T00:00:00Z"
tags:
- SQL
title: Experimenting with Oracle and PL/SQL
---
As i already wrote, last couple of days i've been experimenting with PL/SQL. At work we use [Toad for Oracle](http://www.toadsoft.com/toad_oracle.htm) but since [TOADSoft](http://www.toadsoft.com/) only offers a limited freeware version i decided to write my code with [GVim](http://www.vim.org) and use [SQL*Plus](http://orafaq.com/faqplus.htm#WHAT) at home. Here are a couple of lines i added to my login.sql file

```sql
DEFINE _EDITOR='gvim -c "set filetype=sql"'
SET SERVEROUTPUT ON
SET LINESIZE 120
SET AUTOCOMMIT OFF
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
```

In a stored procedure i created and filled an instance of NUMBER\_TABLE (CREATE TYPE NUMBER\_TABLE AS TABLE OF NUMBER) and my stored procedure tried to select all the rows in that table (SELECT * FROM V_NUMBER_TABLE). Apparently the engine didn't know this type @runtime despite the fact that i declared it in my stored procedure (V\_NUMBER TABLE NUMBER\_TABLE := NUMBER_TABLE();) and the engine compiled the package without errors. I got round that problem as following

```sql
SELECT * FROM (CAST(V_NUMBER_TABLE AS NUMBER_TABLE));
```
