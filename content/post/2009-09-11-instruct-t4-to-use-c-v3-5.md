---
date: "2009-09-11T00:00:00Z"
guid: http://www.timvw.be/?p=1248
tags:
- C#
- Visual Basic
title: Instruct T4 to use C# v3.5
aliases:
 - /2009/09/11/instruct-t4-to-use-c-v3-5/
 - /2009/09/11/instruct-t4-to-use-c-v3-5.html
---
Consider this simple T4 template:

```xml
<# for (var i = 0; i < 10; ++i) { WriteLine("hello"); } #>
```

Trying to build the project results in a compilation error because 'var' is an unknown type. A bit of research learned me that i should instruct the processor to use a specific c# version like this:

```xml
<#@ template language="C#v3.5" inherits="Microsoft.VisualStudio.TextTemplating.VSHost.ModelingTextTransformation" #>
<# for (var i = 0; i < 10; ++i) { WriteLine("hello"); } #>
```

Problem solved 🙂
