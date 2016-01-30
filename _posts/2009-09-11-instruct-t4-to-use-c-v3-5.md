---
ID: 1248
post_title: 'Instruct T4 to use C# v3.5'
author: timvw
post_date: 2009-09-11 09:05:33
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/09/11/instruct-t4-to-use-c-v3-5/
published: true
---
<p>Consider this simple T4 template:</p>

[code lang="xml"]<# for (var i = 0; i < 10; ++i) { WriteLine("hello"); } #>[/code]

<p>Trying to build the project results in a compilation error because 'var' is an unknown type. A bit of research learned me that i should instruct the processor to use a specific c# version like this:</p>

[code lang="xml"]<#@ template language="C#v3.5" inherits="Microsoft.VisualStudio.TextTemplating.VSHost.ModelingTextTransformation"  #>
<# for (var i = 0; i < 10; ++i) { WriteLine("hello"); } #>[/code]

<p>Problem solved :)</p>