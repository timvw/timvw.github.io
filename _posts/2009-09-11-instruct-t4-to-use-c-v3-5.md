---
id: 1248
title: 'Instruct T4 to use C# v3.5'
date: 2009-09-11T09:05:33+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1248
permalink: /2009/09/11/instruct-t4-to-use-c-v3-5/
tags:
  - 'C#'
  - Visual Basic
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
