---
title: Calculate EndpointAddress for Silverlight client
layout: post
guid: http://www.timvw.be/?p=1691
dsq_thread_id:
  - 1921749542
tags:
  - 'C#'
  - Silverlight
---
Because Silverlight checks the origin it considers http://localhost and http://127.0.0.1 as different locations. In case you want your visitors to be able to use both addresses you can recalculate the address as following:

```csharp
EndpointAddress GetEndpointAddress(EndpointAddress endpointAddress)
{
	var scheme = Application.Current.Host.Source.GetComponents(UriComponents.Scheme, UriFormat.Unescaped);
	var serverAndPort = Application.Current.Host.Source.GetComponents(UriComponents.HostAndPort, UriFormat.Unescaped);
	var pathAndQuery = endpointAddress.Uri.GetComponents(UriComponents.PathAndQuery, UriFormat.Unescaped);
	return new EndpointAddress(scheme + "://" + serverAndPort + pathAndQuery);
}
```

And you can use this method as following:

```csharp
var client = new DirectoryServiceClient();
client.Endpoint.Address = GetEndpointAddress(client.Endpoint.Address);
client.GetMessageCompleted += ClientGetMessageCompleted;
client.GetMessageAsync();
```
