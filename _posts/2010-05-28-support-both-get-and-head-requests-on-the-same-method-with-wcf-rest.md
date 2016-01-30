---
ID: 1737
post_title: >
  Support both GET and HEAD requests on
  the same method with WCF REST
author: timvw
post_date: 2010-05-28 20:33:05
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/05/28/support-both-get-and-head-requests-on-the-same-method-with-wcf-rest/
published: true
dsq_thread_id:
  - "1924294222"
---
<p>A while ago i had to modify an existing <a href="http://msdn.microsoft.com/en-us/netframework/cc950529.aspx">WCF REST</a> service which was being consumed by <a href="http://en.wikipedia.org/wiki/Background_Intelligent_Transfer_Service">BITS</a>. Apparently the implementation has changed in Windows7 in such a way that the BITS client first makes a HEAD request to discover the file size.</p>

<p>The following attempts did not work:</p>

[code lang="csharp"]// A method can not have both WebGet and WebInvoke attributes
[OperationContract]
[WebGet]
[WebInvoke(Method="HEAD")]
public Stream Download(string token) { }[/code]

<br/>

[code lang="csharp"]// A method can not have multiple WebInvoke attributes
[OperationContract]
[WebInvoke(Method="GET")]
[WebInvoke("HEAD")]
public Stream Download(string token) { }[/code]

<p>The trick is to use * as Method and handle the method related logic in your code:</p>

[code lang="csharp"][OperationContract]
[WebInvoke(Method="*")]
public Stream Download(string token)
{
 var method = WebOperationContext.Current.IncomingRequest.Method;
 if (method == "HEAD") return ProcessHead();
 if (method == "GET") return ProcessGet();
 throw new ArgumentException(method + " is not supported.");
}[/code]