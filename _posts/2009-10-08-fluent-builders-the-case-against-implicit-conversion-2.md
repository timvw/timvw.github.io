---
ID: 1334
post_title: 'Fluent Builders: The case against implicit conversion (2)'
author: timvw
post_date: 2009-10-08 08:56:56
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/10/08/fluent-builders-the-case-against-implicit-conversion-2/
published: true
---
<p>Here is another example that demonstrates how implicit conversion in a Fluent Builder can lead to surprises (<a href="http://elegantcode.com/2009/03/21/be-careful-with-the-var-keyword-and-expression-builders/">Jan Van Ryswyck noticed this too</a>). Originally the code in my <a href="http://www.timvw.be/fluent-builders-the-case-against-implicit-conversion/">previous example</a> was the following:</p>

[code lang="csharp"]var order = new OrderBuilder();[/code]

<p>Wich would make the c# compiler conclude that order is an OrderBuilder instead of an Order.</p>