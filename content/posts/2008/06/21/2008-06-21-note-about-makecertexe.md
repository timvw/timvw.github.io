---
date: "2008-06-21T00:00:00Z"
guid: http://www.timvw.be/?p=235
tags:
- Information Technology
title: "Note about makecert.exe"
---
A couple of days ago i didn't have a binary version of [OpenSSL](http://www.openssl.org) around so i decided to use [Makecert.exe](http://msdn.microsoft.com/en-us/library/bfsktky3(VS.80).aspx). I generated a couple of test certificates and started playing around with them.

Whenever i tried to decrypt an instance of [EncryptedXml](http://msdn.microsoft.com/en-us/library/system.security.cryptography.xml.encryptedxml(VS.80).aspx) a [CryptographicException](http://msdn.microsoft.com/en-us/library/system.security.cryptography.cryptographicexception.aspx) ("Bad Key.") was thrown and when i tried to use a [mutualCertificate11Security](http://msdn.microsoft.com/en-us/library/aa529579.aspx) assertion ([WSE 3.0](http://msdn.microsoft.com/en-us/library/aa139619.aspx)) the same CryptographicException ("WSE600: Unable to unwrap a symmetric key using the private key of an X.509 certificate. Please check if the account 'ASPNET' has permissions to read the private key of certificate with subject name... ") was thrown.

The problem is that by default, makecert.exe generates a key type that is suited for signature. If you want to use the key for other purposes than signing (eg: SSL authentication) you have to use the -sky exchange option. The following commands made my problems disappear:

```bash
makecert -n "CN=Client" -pe -ss My -sr CurrentUser -sky exchange client.cer
makecert -n "CN=Host" -pe -ss My -sr LocalMachine -sky exchange host.cer
```
