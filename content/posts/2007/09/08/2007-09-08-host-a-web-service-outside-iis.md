---
date: "2007-09-08T00:00:00Z"
tags:
- CSharp
title: Query a Web Service hosted outside IIS with it's DNS name
---
Yesterday someone asked the following:

> <div>
>   I am developing a Web Service inside a Windows Service via the soap.tcp protocol. This all works, and I have created the webservice at soap.tcp://localhost:9090/BookService.</p> 
>   
>   <p>
>     However, when I set the Url to soap.tcp://example.com:9090/BookService on my local machine, I get an exception that the computer actively refused the connection.
>   </p>
> </div>

My first attempt was to simulate the problem. I added an entry in my hosts file so that example.com resolves to 192.168.10.1 (My machine's IP address) and wrote the following code

```csharp
EndpointReference epr = new EndpointReference(new Uri("soap.tcp://example.com:9090/BookService"));
SoapReceivers.Add(epr, typeof(BookService));
```

When i tried to run this code i received an ArgumentException: "WSE813: The following transport address could not be mapped to a local network interface: soap.tcp://example.com:9090/BookService". My intuition said that i should help the infrastructure a little

```csharp
EndpointReference epr = new EndpointReference(new Uri("soap.tcp://192.168.10.1:9090/BookService"));
```

The application started fine this time, but when i used wsewsdl3.exe to generate the proxy i received the following error: Destination Unreachable. Anyway, after a lot of experimenting i found that the following method allows me to generate a proxy using the DNS name

```csharp
static EndpointReference GetEndpointReference(string host, int port, string path)
{
	// we happy:
	// for the Address part we use the DNS name
	//
	// infrastructure happy:
	// for the Via par we use the first IP that maps to the provided DNS name

	Uri address = new Uri(string.Format("soap.tcp://{0}:{1}/{2}", host, port, path));
	Uri via = new Uri(string.Format("soap.tcp://{0}:{1}/{2}", Dns.GetHostEntry(host).AddressList[0], port, path));
	return new EndpointReference(address, via);
}

static void Main(string[] args)
{
	EndpointReference epr = GetEndpointReference("example.com", 9090, "BookService");
	SoapReceivers.Add(epr, typeof(BookService));

	Console.Write("{0}Press any key to continue...", Environment.NewLine);
	Console.ReadKey();

	SoapReceivers.Remove(epr);
}
```

As always, you can download a sample solution with a windows service that hosts the webservice, and a console application that consumes the webservice: [MsdnSoapExample.zip](http://www.timvw.be/wp-content/code/csharp/MsdnSoapExample.zip)
