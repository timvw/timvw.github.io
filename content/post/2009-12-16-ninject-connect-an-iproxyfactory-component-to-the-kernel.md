---
date: "2009-12-16T00:00:00Z"
guid: http://www.timvw.be/?p=1572
tags:
- CSharp
- Free Software
title: 'Ninject: connect an IProxyFactory component to the kernel'
aliases:
 - /2009/12/16/ninject-connect-an-iproxyfactory-component-to-the-kernel/
 - /2009/12/16/ninject-connect-an-iproxyfactory-component-to-the-kernel.html
---
Because it's the second time that i run into this i will post the solution here so that i (and all the other people that run into the same issue) can easily solve it next time. Anyway, i was playing with [Ninject](http://ninject.org/) and ran into the following exception:

> Error activating XXX: the implementation type YYY requests static interceptors, or dynamic interceptors have been defined.
  
> In order to provide interception, you must connect an IProxyFactory component to the kernel.

If you search for implementations of IProxyFactory you will find the DynamicProxy2ProxyFactory and the LinFuProxyFactory classes. But how can you tell your kernel to use them? This is pretty simple (but hard to find on the web):

```csharp
Kernel.Components.Connect<iproxyFactory>(new DynamicProxy2ProxyFactory());
```

Instead of writing this code to connect the ProxyFactory implementation you can also use the XXX module (which does it for you) as following:

```csharp
var kernel = new StandardKernel(new DynamicProxy2Module(), new BusinessModule());
```
