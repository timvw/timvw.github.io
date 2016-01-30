---
ID: 2071
post_title: >
  Get/SetVariable value from SSIS
  VariableDispenser
author: timvw
post_date: 2011-03-08 20:37:57
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/03/08/getsetvariable-value-from-ssis-variabledispenser/
published: true
dsq_thread_id:
  - "1923237271"
---
<p>Here is some code that allows you to Get/Set a variable (object) value from/on the <a href="http://msdn.microsoft.com/en-us/library/microsoft.sqlserver.dts.runtime.variabledispenser.aspx">VariableDispenser</a> in an SSIS package:</p>

[code lang="csharp"]
public static T GetVariable&lt;T&gt;(this VariableDispenser variableDispenser, string scopedVariableName)
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

public static void SetVariable&lt;T&gt;(this VariableDispenser variableDispenser, string scopedVariableName, T value)
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
[/code]