---
date: "2008-08-06T00:00:00Z"
guid: http://www.timvw.be/?p=350
tags:
- CSharp
title: Presenting EnumerableHelper
aliases:
 - /2008/08/06/presenting-enumerablehelper/
 - /2008/08/06/presenting-enumerablehelper.html
---
I noticed (eg: [here](http://derek-says.blogspot.com/2008/08/generic-collections-and-inheritance.html)) that i'm not the only one that has experienced some annoyances when working with generics. Here are a couple of methods that i find extremely helpful when i'm working with [IEnumerable<T>](http://msdn.microsoft.com/en-us/library/9eekhta0.aspx):

```csharp
IEnumerable<tbase> Convert<tderived, TBase>(IEnumerable<tderived> enumerable) where TDerived : TBase;
IEnumerable<t> Convert<t>(IEnumerable enumerable);
bool HaveSameElements<t>(IEnumerable<t> enumerable1, IEnumerable<t> enumerable2, Func<bool, T, T> areEqual);
bool HaveSameElements(IEnumerable enumerable1, IEnumerable enumerable2, Func<bool, object, object> areEqual);
bool HaveSameElements(IEnumerable enumerable1, IEnumerable enumerable2);
```

You can download the actual implementation of this Be.Timvw.Framework.Collections.Generic.EnumerableHelper class in [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework).
