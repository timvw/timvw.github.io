---
ID: 223
post_title: Build OpenSSL with Visual Studio 2008
author: timvw
post_date: 2008-04-21 18:29:45
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/04/21/build-openssl-with-visual-studio-2008/
published: true
dsq_thread_id:
  - "1925476951"
---
<p>These days building <a href="http://www.openssl.org">OpenSSL</a> with Visual Studio 2008 has become really easy. I don't like to edit .cnf files so i decided to patch the code a little so that the default configuration file becomes openssl.config:</p>

[code lang="csharp"]string basePath = @"C:\src\openssl-0.9.8g";

string originalConfigfile = "openssl.cnf";
string updatedConfigfile = "openssl.config";
foreach (string filename in Directory.GetFiles(basePath, "*.*", SearchOption.AllDirectories))
{
 string contents = File.ReadAllText(filename);
 if (contents.Contains(originalConfigfile))
 {
  Console.WriteLine(filename);
  File.WriteAllText(filename, contents.Replace(originalConfigfile, updatedConfigfile));
 }
}

File.WriteAllText(basePath + @"\apps\" + updatedConfigfile, File.ReadAllText(basePath + @"\apps\" + originalConfigfile));[/code]

<p>Open a Visual Studio 2008 Command prompt and add references to the <a href="http://blogs.msdn.com/windowssdk">Microsoft SDK</a> as following:</p>

[code lang="dos"]SET PATH=%PATH%;C:\Program Files\Microsoft SDKs\Windows\v6.0A\bin
SET LIB=%LIB%;C:\Program Files\Microsoft SDKs\Windows\v6.0A\Lib
SET INCLUDE=%INCLUDE%;C:\Program Files\Microsoft SDKs\Windows\v6.0A\Include[/code]

<p>Now we simply have to follow the tasks listed in INSTALL.W32:</p>
[code lang="dos"]perl Configure VC-WIN32 --prefix=c:/openssl
ms\do_masm
nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak test
nmake -f ms\ntdll.mak install[/code]

<p>Happy OpenSSL'ing!</p>