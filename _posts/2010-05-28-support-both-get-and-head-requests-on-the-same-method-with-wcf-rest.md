---
id: 1737
title: Support both GET and HEAD requests on the same method with WCF REST
date: 2010-05-28T20:33:05+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1737
permalink: /2010/05/28/support-both-get-and-head-requests-on-the-same-method-with-wcf-rest/
dsq_thread_id:
  - 1924294222
tags:
  - 'C#'
---
A while ago i had to modify an existing [WCF REST](http://msdn.microsoft.com/en-us/netframework/cc950529.aspx) service which was being consumed by [BITS](http://en.wikipedia.org/wiki/Background_Intelligent_Transfer_Service). Apparently the implementation has changed in Windows7 in such a way that the BITS client first makes a HEAD request to discover the file size.

The following attempts did not work

```csharp
// A method can not have both WebGet and WebInvoke attributes
[OperationContract]
[WebGet]
[WebInvoke(Method="HEAD")]
public Stream Download(string token) { }
```

and

```csharp
// A method can not have multiple WebInvoke attributes
[OperationContract]
[WebInvoke(Method="GET")]
[WebInvoke("HEAD")]
public Stream Download(string token) { }
```

The trick is to use * as Method and handle the method related logic in your code

```csharp
[OperationContract]
[WebInvoke(Method="*")]
public Stream Download(string token)
{
	var method = WebOperationContext.Current.IncomingRequest.Method;
	if (method == "HEAD") return ProcessHead();
	if (method == "GET") return ProcessGet();
	throw new ArgumentException(method + " is not supported.");
}
```
