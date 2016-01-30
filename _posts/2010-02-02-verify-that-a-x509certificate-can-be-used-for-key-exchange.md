---
ID: 1663
post_title: >
  Verify that a X509Certificate can be
  used for key exchange
author: timvw
post_date: 2010-02-02 19:39:38
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/02/02/verify-that-a-x509certificate-can-be-used-for-key-exchange/
published: true
---
<p>Here is another method that earned it's place in my ever growing toolbox:</p>

[code lang="csharp"]public static bool CanDoKeyExchange(this X509Certificate2 certificate)
{
 if (!certificate.HasPrivateKey) return false;

 var privateKey = certificate.PrivateKey as RSACryptoServiceProvider;
 if (privateKey == null) return false;

 var canDoKeyExchange = privateKey.CspKeyContainerInfo.KeyNumber == KeyNumber.Exchange;
 return canDoKeyExchange;
}[/code]