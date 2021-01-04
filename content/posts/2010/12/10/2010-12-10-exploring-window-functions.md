---
date: "2010-12-10T00:00:00Z"
guid: http://www.timvw.be/?p=2005
tags:
- SQL
title: Exploring window functions
aliases:
 - /2010/12/10/exploring-window-functions/
 - /2010/12/10/exploring-window-functions.html
---
Here is a sample query that allows you to explore the behavior of various [aggregate window functions](http://msdn.microsoft.com/en-us/library/ms189461.aspx):

```sql
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
```
