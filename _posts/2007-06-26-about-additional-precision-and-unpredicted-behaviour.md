---
ID: 177
post_title: 'About additional precision and unpredicted behaviour&#8230;'
author: timvw
post_date: 2007-06-26 19:27:22
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/06/26/about-additional-precision-and-unpredicted-behaviour/
published: true
---
<p>Earlier today someone posted the following code:</p>
[code lang="csharp"]
float a = 0.12f;
float b = a * 100f;
Console.WriteLine((int) b);  // prints 12
Console.WriteLine((int)(a * 100f)); // prints 11 !!!!!!!!
[/code]
<p>An (extensive) explanation for this strange behaviour can be found at <a href="http://blogs.msdn.com/davidnotario/archive/2005/08/08/449092.aspx">CLR and floating point: Some answers to common questions</a>... A possible way to force the compiler and runtime to get rid of the additional precision would be the following:</p>
[code lang="csharp"]
Console.WriteLine((int)(float)(a * 100f));
[/code]