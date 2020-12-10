---
title: Set variables in SSIS package at runtime
layout: post
guid: http://www.timvw.be/?p=2147
categories:
  - Uncategorized
tags:
  - PowerShell
  - SSIS
---
The documentation on [dtexec Utility (SSIS Tool)](http://msdn.microsoft.com/en-us/library/ms162810.aspx) says the following:

> /Set propertyPath;value
> 
> (Optional). Overrides the configuration of a variable, property, container, log provider, Foreach enumerator, or connection within a package. When this option is used, /Set changes the propertyPath argument to the value specified. Multiple /Set options can be specified. 

At first sight this works like a charm but as soon as your value has a space dtexec seems to get confused 🙁 It took me a couple of websearches to find a [post that suggests the following](http://www.sqldev.org/sql-server-integration-services/escape-character-for-set-option-of-dtexec-34546.shtml):

> dtexec /SET \Package.Variables[User::TheVariable].Properties[Value];\''; space'\'; 

It seems that this works like a charm 🙂 Because i am lazy i wrapped this in a powershell function:

```powershell
function PackageOption()
{	  
	param($name, $value);
	"$name;\`"\`"$value\`"\`"";
}  
```

And now you can use it as following in your deployment script:

```powershell
$TheVariableOption = PackageOption -Name "\Package.Variables[User::TheVariable].Properties[Value]" -Value "some thing";
&dtexec /File "$package" /Set $TheVariableOption;
```
