---
ID: 1572
post_title: 'Ninject: connect an IProxyFactory component to the kernel'
author: timvw
post_date: 2009-12-16 18:54:30
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/12/16/ninject-connect-an-iproxyfactory-component-to-the-kernel/
published: true
---
<p>Because it's the second time that i run into this i will post the solution here so that i (and all the other people that run into the same issue) can easily solve it next time. Anyway, i was playing with <a href="http://ninject.org/">Ninject</a> and ran into the following exception:</p>

<blockquote>Error activating XXX: the implementation type YYY requests static interceptors, or dynamic interceptors have been defined.
In order to provide interception, you must connect an IProxyFactory component to the kernel.</blockquote>

<p>If you search for implementations of IProxyFactory you will find the DynamicProxy2ProxyFactory and the LinFuProxyFactory classes. But how can you tell your kernel to use them? This is pretty simple (but hard to find on the web):</p>

[code lang="csharp"]Kernel.Components.Connect<iproxyFactory>(new DynamicProxy2ProxyFactory());[/code]

<p>Instead of writing this code to connect the ProxyFactory implementation you can also use the XXX module (which does it for you) as following:</p>

[code lang="csharp"]var kernel = new StandardKernel(new DynamicProxy2Module(), new BusinessModule());[/code]