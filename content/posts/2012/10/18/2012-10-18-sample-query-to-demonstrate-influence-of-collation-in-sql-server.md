---
date: "2012-10-18T00:00:00Z"
guid: http://www.timvw.be/?p=2301
tags:
- collation
- SQL
title: Sample query to demonstrate influence of collation in Sql Server
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