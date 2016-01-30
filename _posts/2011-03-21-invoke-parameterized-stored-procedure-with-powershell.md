---
ID: 2124
post_title: >
  Invoke parameterized stored procedure
  with PowerShell
author: timvw
post_date: 2011-03-21 21:30:08
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/03/21/invoke-parameterized-stored-procedure-with-powershell/
published: true
dsq_thread_id:
  - "1920710468"
---
<p>Here is a quick snippet that demonstrates how you can invoke a parametrized stored procedure with PowerShell:</p>

[code lang="powershell"]
$CreateTraceCommand = $SqlConnection.CreateCommand();
$CreateTraceCommand.CommandType = [System.Data.CommandType] &quot;StoredProcedure&quot;;
$CreateTraceCommand.CommandText = &quot;sp_trace_create&quot;;
$TraceIdParameter = $CreateTraceCommand.Parameters.Add(&quot;@traceid&quot;, [System.Data.SqlDbType] &quot;Int&quot;);
$TraceIdParameter.Direction = [System.Data.ParameterDirection] &quot;Output&quot;;
$OptionParameter = $CreateTraceCommand.Parameters.Add(&quot;@options&quot;, [System.Data.SqlDbType] &quot;Int&quot;);
$OptionParameter.Value = [int] 2;
$TraceFileParameter = $CreateTraceCommand.Parameters.Add(&quot;@tracefile&quot;, [System.Data.SqlDbType] &quot;NVarChar&quot;);
$TraceFileParameter.Value = [string] &quot;c:\temp\test&quot;;
[void] $CreateTraceCommand.ExecuteNonQuery();
$TraceId = $TraceIdParameter.Value;
Write-Host &quot;You created a trace with id: $TraceId&quot;;
[/code]