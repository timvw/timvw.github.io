---
ID: 1691
post_title: >
  Calculate EndpointAddress for
  Silverlight client
author: timvw
post_date: 2010-02-15 21:44:18
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/02/15/calculate-endpointaddress-for-silverlight-client/
published: true
dsq_thread_id:
  - "1921749542"
---
<p>Because Silverlight checks the origin it considers http://localhost and http://127.0.0.1 as different locations. In case you want your visitors to be able to use both addresses you can recalculate the address as following:</p>

[code lang="csharp"]EndpointAddress GetEndpointAddress(EndpointAddress endpointAddress)
{
 var scheme = Application.Current.Host.Source.GetComponents(UriComponents.Scheme, UriFormat.Unescaped);
 var serverAndPort = Application.Current.Host.Source.GetComponents(UriComponents.HostAndPort, UriFormat.Unescaped);
 var pathAndQuery = endpointAddress.Uri.GetComponents(UriComponents.PathAndQuery, UriFormat.Unescaped);
 return new EndpointAddress(scheme + "://" + serverAndPort + pathAndQuery);
}[/code]

<p>And you can use this method as following:</p>

[code lang="csharp"]var client = new DirectoryServiceClient();
client.Endpoint.Address = GetEndpointAddress(client.Endpoint.Address);
client.GetMessageCompleted += ClientGetMessageCompleted;
client.GetMessageAsync();[/code]