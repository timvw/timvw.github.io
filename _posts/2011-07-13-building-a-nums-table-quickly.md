---
ID: 2159
post_title: Building a Nums table (quickly)
author: timvw
post_date: 2011-07-13 09:45:14
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/07/13/building-a-nums-table-quickly/
published: true
---
<p>A while ago i presented my approach to generate a nums table <a href="http://www.timvw.be/2010/12/11/techniques-learned-in-sqltopia-look-ma-no-loops/">here</a>. 

[code lang="sql"]
DECLARE @count INT = 1000;
 
WITH
    [Nums1] AS ( SELECT 1 AS [Value] UNION SELECT 2 AS [Value] )
  , [Nums2] AS ( SELECT A.* FROM [Nums1] AS A, [Nums1] AS B, [Nums1] AS C)
  , [Nums3] AS ( SELECT A.* FROM [Nums2] AS A, [Nums2] AS B, [Nums2] AS C)
  , [Nums4] AS ( SELECT A.* FROM [Nums3] AS A, [Nums3] AS B )
  , [Numbers] AS ( SELECT TOP(@count) -1 + ROW_NUMBER() OVER(ORDER BY [Value]) AS [Value] FROM[Nums4] )
SELECT * FROM [Numbers];
[/code]

<p>Because we only use this code once to fill the table we don't really care that it is not very fast. Today i discovered there is a way to speed it up in this wonderful book: <a href="http://oreilly.com/catalog/9780735626034/">Inside Microsoft® SQL Server® 2008: T-SQL Querying</a>:

[code lang="sql"]
WITH
    [Nums1] AS ( SELECT 1 AS [Value] UNION SELECT 2 AS [Value] )
  , [Nums2] AS ( SELECT A.* FROM [Nums1] AS A, [Nums1] AS B, [Nums1] AS C)
  , [Nums3] AS ( SELECT A.* FROM [Nums2] AS A, [Nums2] AS B, [Nums2] AS C)
  , [Nums4] AS ( SELECT A.* FROM [Nums3] AS A, [Nums3] AS B )
  , [Numbers] AS ( SELECT TOP(@count) -1 + ROW_NUMBER() OVER(ORDER BY (SELECT 0)) AS [Value] FROM[Nums4] )
SELECT * FROM [Numbers];
[/code]

<p>Yay for features like ORDER BY (SELECT &lt;Constant&gt;).</p>