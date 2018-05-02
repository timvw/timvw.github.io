---
id: 1663
title: Verify that a X509Certificate can be used for key exchange
date: 2010-02-02T19:39:38+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1663
permalink: /2010/02/02/verify-that-a-x509certificate-can-be-used-for-key-exchange/
tags:
  - 'C#'
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
