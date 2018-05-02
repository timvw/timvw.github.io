---
id: 2301
title: Sample query to demonstrate influence of collation in Sql Server
date: 2012-10-18T09:22:25+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2301
permalink: /2012/10/18/sample-query-to-demonstrate-influence-of-collation-in-sql-server/
dsq_thread_id:
  - 1922156371
categories:
  - Uncategorized
tags:
  - collation
  - SQL
---
Lately I had the pleasure to investigate [collations](http://technet.microsoft.com/en-us/library/aa174903(v=sql.80).aspx) and here is a sample query that demonstrates how a collation impacts the behaviour of a query:

```sql
WITH [Words] AS (
	SELECT N'Een' AS [word]  
	UNION ALL  
	SELECT N'Eèn'	  
	UNION ALL
	SELECT N'EEN'
)
SELECT [word]	  
FROM [Words]  
WHERE [word]	  
--COLLATE Latin1_General_CS_AS -- returns Een
--COLLATE Latin1_General_CI_AI -- returns Een, Eèn and EEN
--COLLATE LAtin1_General_CI_AS -- returns Een and EEN
COLLATE Latin1_General_CS_AI -- returns Een and Eèn
= N'Een';
```