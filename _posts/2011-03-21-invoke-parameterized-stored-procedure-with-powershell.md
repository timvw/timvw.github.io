---
id: 2124
title: Invoke parameterized stored procedure with PowerShell
date: 2011-03-21T21:30:08+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2124
permalink: /2011/03/21/invoke-parameterized-stored-procedure-with-powershell/
dsq_thread_id:
  - 1920710468
categories:
  - Uncategorized
tags:
  - PowerShell
  - SQL
---
Here is a quick snippet that demonstrates how you can invoke a parametrized stored procedure with PowerShell:

```powershell
$CreateTraceCommand = $SqlConnection.CreateCommand();
$CreateTraceCommand.CommandType = [System.Data.CommandType] "StoredProcedure";
$CreateTraceCommand.CommandText = "sp_trace_create";
$TraceIdParameter = $CreateTraceCommand.Parameters.Add("@traceid", [System.Data.SqlDbType] "Int");
$TraceIdParameter.Direction = [System.Data.ParameterDirection] "Output";
$OptionParameter = $CreateTraceCommand.Parameters.Add("@options", [System.Data.SqlDbType] "Int");
$OptionParameter.Value = [int] 2;
$TraceFileParameter = $CreateTraceCommand.Parameters.Add("@tracefile", [System.Data.SqlDbType] "NVarChar");
$TraceFileParameter.Value = [string] "c:\temp\test";

[void] $CreateTraceCommand.ExecuteNonQuery();

$TraceId = $TraceIdParameter.Value;
Write-Host "You created a trace with id: $TraceId";
```
