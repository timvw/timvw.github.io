---
ID: 1321
post_title: 'Fluent Builders: The case against implicit conversion'
author: timvw
post_date: 2009-10-08 08:45:59
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/10/08/fluent-builders-the-case-against-implicit-conversion/
published: true
---
<p>Most people add an implicit conversion to their builder API which gives them the advantage that they don't have to call Build explicitely. I have decided that i do not want to have this implicit conversion for a couple of reasons:</p>

<ul>
<li>C# does not allow to define implicit conversions to or from an interface</li>
<li>Implicit conversions are not very discoverable</li>
<li>Implicit conversions can break the API</li>
</ul>

<p>Here is an example to clarify that last reason: Consider an OrderBuilder which requires the user to provide a product and then a quantity:</p>

[code lang="csharp"]interface ITakeProduct { ITakeQuantity WithProduct(int productId); }
interface ITakeQuantity { IBuildProduct WithQuantity(int quantity); }
interface IBuildProduct { Product Build(); }[/code]

<p>With the existence of an implicit conversion operator a developer can create an invalid order as following:</p>

[code lang="csharp"]Order order = new OrderBuilder();[/code]

<p>Conclusion: I am not convinced that Fluent Builders should support implicit conversion.</p>