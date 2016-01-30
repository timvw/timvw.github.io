---
ID: 2005
post_title: Exploring window functions
author: timvw
post_date: 2010-12-10 21:52:01
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/12/10/exploring-window-functions/
published: true
---
<p>Here is a sample query that allows you to explore the behavior of various <a href="http://msdn.microsoft.com/en-us/library/ms189461.aspx">aggregate window functions</a>:</p>

[code lang="sql"]
WITH 
    [Nums1] AS ( SELECT 1 AS [Value] UNION SELECT 2 AS [Value] )
  , [Nums2] AS ( SELECT A.* FROM [Nums1] AS A, [Nums1] AS B, [Nums1] AS C)
  , [Nums3] AS ( SELECT A.* FROM [Nums2] AS A, [Nums2] AS B, [Nums2] AS C)
  , [Nums4] AS ( SELECT A.* FROM [Nums3] AS A, [Nums3] AS B )
  -- Build numbers from 1 to 1000
  , [Numbers] AS ( SELECT TOP(1000) ROW_NUMBER() OVER(ORDER BY [Value]) AS [Value] FROM[Nums4] )
SELECT 
    [Value]
  , ROW_NUMBER() OVER(PARTITION BY [Value] / 100 ORDER BY [Value] % 10) AS [RowNumber]
  , RANK() OVER(PARTITION BY [Value] / 100 ORDER BY [Value] % 10) AS [Rank]
  , DENSE_RANK() OVER (PARTITION BY [Value] / 100 ORDER BY [Value] % 10) AS [DenseRank]
  , NTILE(4) OVER (PARTITION BY [Value] / 100 ORDER BY [Value] % 10) AS [Tile100]
FROM	
    [Numbers]
ORDER BY 
    [Value];
[/code]