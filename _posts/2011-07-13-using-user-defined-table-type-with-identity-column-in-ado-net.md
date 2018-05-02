---
id: 2157
title: Using User-Defined Table Type with Identity column in ADO.NET
date: 2011-07-13T09:33:29+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2157
permalink: /2011/07/13/using-user-defined-table-type-with-identity-column-in-ado-net/
dsq_thread_id:
  - 1925841929
categories:
  - Uncategorized
tags:
  - ado.net
  - C
  - t-sql
---
A while ago i wanted to use a [User-Defined Table Type](http://msdn.microsoft.com/en-us/library/bb522526.aspx) to pass in a set of records. Nothing special about this except that the first column of the UDTT was an Identity column:

```sql
CREATE TYPE [Star].[example] AS TABLE(  
  [Ordinal] [int] IDENTITY(1,1) NOT NULL,  
  [Name] [nvarchar](200) NOT NULL,
)
``` 

After finding a lot of posts saying that this is not supported a colleague of mine, [Stephen Horsfield](http://stevehorsfield.wordpress.com/), found a way to do it as following:

```csharp
var sqlMetaData = new[] 
{  
  new SqlMetaData("Ordinal", SqlDbType.Int, true, false, SortOrder.Unspecified, -1),   
  new SqlMetaData("Name", SqlDbType.NVarChar, 200)
};

sqlRecords = new HashSet<SqlDataRecord>(usersToInclude.Select(user =>
{   
  var record = new SqlDataRecord(sqlMetaData);   
  record.SetString(1, user.Name);   
  return record; 
}));
```
