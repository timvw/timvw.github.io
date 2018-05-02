---
id: 1334
title: 'Fluent Builders: The case against implicit conversion (2)'
date: 2009-10-08T08:56:56+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1334
permalink: /2009/10/08/fluent-builders-the-case-against-implicit-conversion-2/
tags:
  - 'C#'
---
Here is another example that demonstrates how implicit conversion in a Fluent Builder can lead to surprises ([Jan Van Ryswyck noticed this too](http://elegantcode.com/2009/03/21/be-careful-with-the-var-keyword-and-expression-builders/)). Originally the code in my [previous example](http://www.timvw.be/fluent-builders-the-case-against-implicit-conversion/) was the following:

```csharp
var order = new OrderBuilder();
```

Wich would make the c# compiler conclude that order is an OrderBuilder instead of an Order.
