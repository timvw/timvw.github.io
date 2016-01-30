---
ID: 2301
post_title: >
  Sample query to demonstrate influence of
  collation in Sql Server
author: timvw
post_date: 2012-10-18 09:22:25
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2012/10/18/sample-query-to-demonstrate-influence-of-collation-in-sql-server/
published: true
dsq_thread_id:
  - "1922156371"
---
<p>Lately I had the pleasure to investigate <a href="http://technet.microsoft.com/en-us/library/aa174903(v=sql.80).aspx">collations</a> and here is a sample query that demonstrates how a collation impacts the behaviour of a query:</p>

[code language="sql"]
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
[/code]