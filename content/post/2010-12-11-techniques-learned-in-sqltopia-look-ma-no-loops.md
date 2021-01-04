---
date: "2010-12-11T00:00:00Z"
guid: http://www.timvw.be/?p=2012
tags:
- SQL
title: 'Techniques learned in SQLtopia: Look Ma, no loops!'
aliases:
 - /2010/12/11/techniques-learned-in-sqltopia-look-ma-no-loops/
 - /2010/12/11/techniques-learned-in-sqltopia-look-ma-no-loops.html
---
I have been programming in c-based languages for more than 10 years now. Lately i have spent quite a bit of time in SQLtopia and learned a couple of techniques that are quite different from what i was used to.

Let me explain with an example: The boss comes in and asks for a report that contains all the days on which i have worked this year. As a typical c# programmer i come up with the following solution: Iterate over all the days in the year and skip the days i was out on holidays:

```csharp
IEnumerable<DateTime> FindWorkingDays()
{
  var begin = new DateTime(2010, 01, 01);
  var end = new DateTime(2010, 12, 31);

  var holidays = new[]   
  {    
    new Holiday { Begin = new DateTime(2010, 07, 01), End = new DateTime(2010, 07, 31) },    
    new Holiday { Begin = new DateTime(2010, 09, 01), End = new DateTime(2010, 09, 15) }   
  };

  for (var date = begin; date <= end; date = date.AddDays(1))   
  {    
    if(holidays.Any(holiday => holiday.Begin <= date && date <= holiday.End)) continue;    
    yield return date;   
  }  
}  
```

In SQLtopia it is recommended to use set-based solutions instead of loops so we need a radically different solution.

Here is how we generate rows:

```sql
WITH    
  [Nums1] AS ( SELECT 1 AS [Value] UNION SELECT 2 AS [Value] )  
, [Nums2] AS ( SELECT A.* FROM [Nums1] AS A, [Nums1] AS B, [Nums1] AS C)  
, [Nums3] AS ( SELECT A.* FROM [Nums2] AS A, [Nums2] AS B, [Nums2] AS C)  
, [Nums4] AS ( SELECT A.* FROM [Nums3] AS A, [Nums3] AS B )
SELECT * FROM [Nums4];
```

With rows we can generate numbers:

```sql  
DECLARE @count INT = 1000;

WITH    
  [Nums1] AS ( SELECT 1 AS [Value] UNION SELECT 2 AS [Value] )  
, [Nums2] AS ( SELECT A.* FROM [Nums1] AS A, [Nums1] AS B, [Nums1] AS C)
, [Nums3] AS ( SELECT A.* FROM [Nums2] AS A, [Nums2] AS B, [Nums2] AS C)
, [Nums4] AS ( SELECT A.* FROM [Nums3] AS A, [Nums3] AS B )
, [Numbers] AS ( SELECT TOP(@count) -1 + ROW_NUMBER() OVER(ORDER BY [Value]) AS [Value] FROM[Nums4] )
SELECT * FROM [Numbers];
```

And with numbers we can generate dates:

```sql
DECLARE @begin DATETIME = '2010-01-01';
DECLARE @end DATETIME = '2010-12-31';
DECLARE @count INT = DATEDIFF(DAY, @begin, @end) + 1;

WITH    
  [Nums1] AS ( SELECT 1 AS [Value] UNION SELECT 2 AS [Value] )
, [Nums2] AS ( SELECT A.* FROM [Nums1] AS A, [Nums1] AS B, [Nums1] AS C)  
, [Nums3] AS ( SELECT A.* FROM [Nums2] AS A, [Nums2] AS B, [Nums2] AS C)  
, [Nums4] AS ( SELECT A.* FROM [Nums3] AS A, [Nums3] AS B )  
, [Numbers] AS ( SELECT TOP(@count) -1 + ROW_NUMBER() OVER(ORDER BY [Value]) AS [Value] FROM[Nums4] )  
, [Dates] AS ( SELECT DATEADD(DAY, [Value], @begin) AS [Date] FROM [Numbers] )
SELECT * FROM [Dates];
```

With dates we can build the dates on which we were out on holidays:

```sql

DECLARE @begin DATETIME = '2010-01-01';
DECLARE @end DATETIME = '2010-12-31';
DECLARE @count INT = DATEDIFF(DAY, @begin, @end) + 1;

WITH    
  [Nums1] AS ( SELECT 1 AS [Value] UNION SELECT 2 AS [Value] )  
, [Nums2] AS ( SELECT A.* FROM [Nums1] AS A, [Nums1] AS B, [Nums1] AS C)
, [Nums3] AS ( SELECT A.* FROM [Nums2] AS A, [Nums2] AS B, [Nums2] AS C)    
, [Nums4] AS ( SELECT A.* FROM [Nums3] AS A, [Nums3] AS B )    
, [Numbers] AS ( SELECT TOP(@count) -1 + ROW_NUMBER() OVER(ORDER BY [Value]) AS [Value] FROM[Nums4] )    
, [Dates] AS ( SELECT DATEADD(DAY, [Value], @begin) AS [Date] FROM [Numbers] )    
, [Holidays] AS ( SELECT '2010-07-01' AS [Begin], '2010-07-31' AS [End]                      
UNION                    
  SELECT '2010-09-01' AS [Begin], '2010-09-15' AS [End]                  
)
SELECT [Date] FROM [Holidays],[Dates] WHERE [Date] BETWEEN [Begin] AND [End] ORDER BY [Date];  
```

And now we can easily select the dates that are not holiday dates:

```sql
DECLARE @begin DATETIME = '2010-01-01';
DECLARE @end DATETIME = '2010-12-31';
DECLARE @count INT = DATEDIFF(DAY, @begin, @end) + 1;

WITH  
  [Nums1] AS ( SELECT 1 AS [Value] UNION SELECT 2 AS [Value] )    
, [Nums2] AS ( SELECT A.* FROM [Nums1] AS A, [Nums1] AS B, [Nums1] AS C)  
, [Nums3] AS ( SELECT A.* FROM [Nums2] AS A, [Nums2] AS B, [Nums2] AS C)    
, [Nums4] AS ( SELECT A.* FROM [Nums3] AS A, [Nums3] AS B )    
, [Numbers] AS ( SELECT TOP(@count) -1 + ROW_NUMBER() OVER(ORDER BY [Value]) AS [Value] FROM[Nums4] )    
, [Dates] AS ( SELECT DATEADD(DAY, [Value], @begin) AS [Date] FROM [Numbers] WHERE [Value] <= DATEDIFF(DAY, @begin, @end))    
, [Holidays] AS ( SELECT '2010-07-01' AS [Begin], '2010-07-31' AS [End]                      
UNION                      
  SELECT '2010-09-01' AS [Begin], '2010-09-15' AS [End]                  
)
, [HolidayDates] AS (SELECT [Date] FROM [Holidays],[Dates] WHERE [Date] BETWEEN [Begin] AND [End] )
SELECT [Dates].[Date] FROM [Dates]					  
LEFT OUTER JOIN [HolidayDates] ON [Dates].[Date] = [HolidayDates].[Date]				    
WHERE [HolidayDates].[Date] IS NULL;
```

Look Ma, no loops!
