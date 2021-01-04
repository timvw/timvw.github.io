---
date: "2009-10-08T00:00:00Z"
guid: http://www.timvw.be/?p=1334
tags:
- CSharp
title: 'Fluent Builders: The case against implicit conversion (2)'
aliases:
 - /2009/10/08/fluent-builders-the-case-against-implicit-conversion-2/
 - /2009/10/08/fluent-builders-the-case-against-implicit-conversion-2.html
---
Here is another example that demonstrates how implicit conversion in a Fluent Builder can lead to surprises ([Jan Van Ryswyck noticed this too](http://elegantcode.com/2009/03/21/be-careful-with-the-var-keyword-and-expression-builders/)). Originally the code in my [previous example](http://www.timvw.be/fluent-builders-the-case-against-implicit-conversion/) was the following:

```csharp
var order = new OrderBuilder();
```

Wich would make the c# compiler conclude that order is an OrderBuilder instead of an Order.
