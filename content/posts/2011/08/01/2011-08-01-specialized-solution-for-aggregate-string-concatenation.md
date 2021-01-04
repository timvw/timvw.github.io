---
date: "2011-08-01T00:00:00Z"
guid: http://www.timvw.be/?p=2189
tags:
- t-sql
title: Specialized solution for aggregate string concatenation
aliases:
 - /2011/08/01/specialized-solution-for-aggregate-string-concatenation/
 - /2011/08/01/specialized-solution-for-aggregate-string-concatenation.html
---
I have noticed that most people come up with the following solution to build a string in T-SQL:

```sql
WITH [Numbers] AS (	  
	SELECT TOP(10) [n]	  
	FROM [Nums] 
)	  
SELECT @message = COALESCE(@message, '') + '' + CAST([n] AS nvarchar(2))	  
FROM [Numbers];

SELECT @message = STUFF(@message, 1, 2, '');
SELECT @message;
```

> Important! Microsoft has no official documentation describing this aggregate concatenation
> technique that is based on the assignment SELECT syntax. The behavior described here is
> based on observation alone. The current implementation of the ConcatOrders function doesn’t
> incorporate 
> an ORDER BY clause and does not guarantee the order of concatenation. According
> to a blog entry by Microsoft’s Conor Cunningham, it seems that SQL Server will respect an
> ORDER BY clause if specified (http://blogs.msdn.com/sqltips/archive/2005/07/20/441053.aspx).
> Conor is a very credible source, but I should stress that besides
> this blog entry I haven’t found
> any official documentation describing how a multi-row assignment
> SELECT should behave—with
> or without an ORDER BY clause.

With the aid of FOR XML PATH (as mentionned in [Inside Microsoft SQL Server 2008: T-SQL Programming](http://www.sql.co.il/books/insidetsql2008/) we can solve this problem using a documented approach:

```sql
WITH [Numbers] AS (	  
	SELECT TOP(10) [n]	  
	FROM [Nums] 
)	  
SELECT @message = (SELECT '' + CAST([n] AS nvarchar(2)) AS [text()]  
FROM [Numbers]	  
FOR XML PATH(''));

SELECT @message = STUFF(@message, 1, 2, '');
SELECT @message;
```
