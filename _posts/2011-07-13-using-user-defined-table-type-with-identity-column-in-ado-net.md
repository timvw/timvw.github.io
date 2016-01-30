---
ID: 2157
post_title: >
  Using User-Defined Table Type with
  Identity column in ADO.NET
author: timvw
post_date: 2011-07-13 09:33:29
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/07/13/using-user-defined-table-type-with-identity-column-in-ado-net/
published: true
dsq_thread_id:
  - "1925841929"
---
<p>A while ago i wanted to use a <a href="http://msdn.microsoft.com/en-us/library/bb522526.aspx">User-Defined Table Type</a> to pass in a set of records. Nothing special about this except that the first column of the UDTT was an Identity column:</p>

[code lang="sql"]
CREATE TYPE [Star].[example] AS TABLE(
  [Ordinal] [int] IDENTITY(1,1) NOT NULL,
  [Name] [nvarchar](200) NOT NULL,
)
[/code]         

<p>After finding a lot of posts saying that this is not supported a colleague of mine, <a href="http://stevehorsfield.wordpress.com/">Stephen Horsfield</a>, found a way to do it as following:

[code lang="csharp"]
var sqlMetaData = new[] 
{
  new SqlMetaData(&quot;Ordinal&quot;, SqlDbType.Int, true, false, SortOrder.Unspecified, -1),
  new SqlMetaData(&quot;Name&quot;, SqlDbType.NVarChar, 200)
};

sqlRecords = new HashSet&lt;SqlDataRecord&gt;(usersToInclude.Select(user =&gt;
{
  var record = new SqlDataRecord(sqlMetaData);
  record.SetString(1, user.Name);
  return record;
}));
[/code]