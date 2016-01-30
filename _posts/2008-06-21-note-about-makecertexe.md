---
ID: 235
post_title: Note about makecert.exe
author: timvw
post_date: 2008-06-21 12:43:23
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/06/21/note-about-makecertexe/
published: true
---
<p>A couple of days ago i didn't have a binary version of <a href="http://www.openssl.org">OpenSSL</a> around so i decided to use <a href="http://msdn.microsoft.com/en-us/library/bfsktky3(VS.80).aspx">Makecert.exe</a>. I generated a couple of test certificates and started playing around with them.</p>

<p>Whenever i tried to decrypt an instance of <a href="http://msdn.microsoft.com/en-us/library/system.security.cryptography.xml.encryptedxml(VS.80).aspx">EncryptedXml</a> a <a href="http://msdn.microsoft.com/en-us/library/system.security.cryptography.cryptographicexception.aspx">CryptographicException</a> ("Bad Key.") was thrown and when i tried to use a <a href="http://msdn.microsoft.com/en-us/library/aa529579.aspx">mutualCertificate11Security</a> assertion (<a href="http://msdn.microsoft.com/en-us/library/aa139619.aspx">WSE 3.0</a>) the same CryptographicException ("WSE600: Unable to unwrap a symmetric key using the private key of an X.509 certificate. Please check if the account 'ASPNET' has permissions to read the private key of certificate with subject name... ") was thrown.</p>

<p>The problem is that by default, makecert.exe generates a key type that is suited for signature. If you want to use the key for other purposes than signing (eg: SSL authentication) you have to use the -sky exchange option. The following commands made my problems disappear:</p>

[code lang="dos"]
makecert -n "CN=Client" -pe -ss My -sr CurrentUser -sky exchange client.cer
makecert -n "CN=Host" -pe -ss My -sr LocalMachine -sky exchange host.cer
[/code]