---
id: 2071
title: Get/SetVariable value from SSIS VariableDispenser
date: 2011-03-08T20:37:57+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2071
permalink: /2011/03/08/getsetvariable-value-from-ssis-variabledispenser/
dsq_thread_id:
  - 1923237271
categories:
  - Uncategorized
tags:
  - C
  - SSIS
---
Here is some code that allows you to Get/Set a variable (object) value from/on the [VariableDispenser](http://msdn.microsoft.com/en-us/library/microsoft.sqlserver.dts.runtime.variabledispenser.aspx) in an SSIS package:

```csharp
public static T GetVariable<T>(this VariableDispenser variableDispenser, string scopedVariableName)
{
  Variables variables = null;

  try
  {
    variableDispenser.LockForRead(scopedVariableName);
    variableDispenser.GetVariables(ref variables);
    return (T)variables[0].Value;
  }
  finally
  {
    if (variables != null) variables.Unlock();
  }
}

public static void SetVariable<T>(this VariableDispenser variableDispenser, string scopedVariableName, T value)
{
  Variables variables = null;

  try   
  {  
    variableDispenser.LockForWrite(scopedVariableName);  
    variableDispenser.GetVariables(ref variables);  
    variables[0].Value = value;  
  }  
  finally  
  {   
    if (variables != null) variables.Unlock();  
  }
}
```
