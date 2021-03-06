---
date: "2009-10-08T00:00:00Z"
guid: http://www.timvw.be/?p=1321
tags:
- CSharp
title: 'Fluent Builders: The case against implicit conversion'
---
Most people add an implicit conversion to their builder API which gives them the advantage that they don't have to call Build explicitely. I have decided that i do not want to have this implicit conversion for a couple of reasons:

  * C# does not allow to define implicit conversions to or from an interface
  * Implicit conversions are not very discoverable
  * Implicit conversions can break the API

Here is an example to clarify that last reason: Consider an OrderBuilder which requires the user to provide a product and then a quantity:

```csharp
interface ITakeProduct { ITakeQuantity WithProduct(int productId); }
interface ITakeQuantity { IBuildProduct WithQuantity(int quantity); }
interface IBuildProduct { Product Build(); }
```

With the existence of an implicit conversion operator a developer can create an invalid order as following:

```csharp
Order order = new OrderBuilder();
```

Conclusion: I am not convinced that Fluent Builders should support implicit conversion.
