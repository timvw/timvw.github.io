---
date: "2010-02-02T00:00:00Z"
guid: http://www.timvw.be/?p=1663
tags:
- CSharp
title: Verify that a X509Certificate can be used for key exchange
aliases:
 - /2010/02/02/verify-that-a-x509certificate-can-be-used-for-key-exchange/
 - /2010/02/02/verify-that-a-x509certificate-can-be-used-for-key-exchange.html
---
Here is another method that earned it's place in my ever growing toolbox:

```csharp
public static bool CanDoKeyExchange(this X509Certificate2 certificate)
{
	if (!certificate.HasPrivateKey) return false;

	var privateKey = certificate.PrivateKey as RSACryptoServiceProvider;
	if (privateKey == null) return false;

	var canDoKeyExchange = privateKey.CspKeyContainerInfo.KeyNumber == KeyNumber.Exchange;
	return canDoKeyExchange;
}
```
