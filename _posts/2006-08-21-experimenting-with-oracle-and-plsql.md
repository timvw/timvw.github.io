---
ID: 48
post_title: Experimenting with Oracle and PL/SQL
author: timvw
post_date: 2006-08-21 20:12:05
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/08/21/experimenting-with-oracle-and-plsql/
published: true
---
<p>As i already wrote, last couple of days i've been experimenting with PL/SQL. At work we use <a href="http://www.toadsoft.com/toad_oracle.htm">Toad for Oracle</a> but since <a href="http://www.toadsoft.com/">TOADSoft</a> only offers a limited freeware version i decided to write my code with <a href="http://www.vim.org">GVim</a> and use <a href="http://orafaq.com/faqplus.htm#WHAT">SQL*Plus</a> at home. Here are a couple of lines i added to my login.sql file:</p>

[code lang="sql"]DEFINE _EDITOR='gvim -c "set filetype=sql"'
SET SERVEROUTPUT ON
SET LINESIZE 120
SET AUTOCOMMIT OFF
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';[/code]

<p>In a stored procedure i created and filled an instance of NUMBER_TABLE (CREATE TYPE NUMBER_TABLE AS TABLE OF NUMBER) and my stored procedure tried to select all the rows in that table (SELECT * FROM V_NUMBER_TABLE). Apparently the engine didn't know this type @runtime despite the fact that i declared it in my stored procedure (V_NUMBER TABLE NUMBER_TABLE := NUMBER_TABLE();) and the engine compiled the package without errors. I got round that problem as following:</p>

[code lang="sql"]SELECT * FROM (CAST(V_NUMBER_TABLE AS NUMBER_TABLE));[/code]