---
date: "2007-06-26T00:00:00Z"
tags:
- CSharp
title: About additional precision and unpredicted behaviour...
---
Earlier today someone posted the following code

```csharp
float a = 0.12f;
float b = a * 100f;
Console.WriteLine((int) b); // prints 12
Console.WriteLine((int)(a * 100f)); // prints 11 !!!!!!!!
```

An (extensive) explanation for this strange behaviour can be found at [CLR and floating point: Some answers to common questions](http://blogs.msdn.com/davidnotario/archive/2005/08/08/449092.aspx)... A possible way to force the compiler and runtime to get rid of the additional precision would be the following

```csharp
Console.WriteLine((int)(float)(a * 100f));
```
