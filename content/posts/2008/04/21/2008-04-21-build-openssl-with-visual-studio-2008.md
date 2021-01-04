---
date: "2008-04-21T00:00:00Z"
guid: http://www.timvw.be/?p=223
tags:
- Free Software
title: Build OpenSSL with Visual Studio 2008
---
These days building [OpenSSL](http://www.openssl.org) with Visual Studio 2008 has become really easy. I don't like to edit .cnf files so i decided to patch the code a little so that the default configuration file becomes openssl.config

```csharp
string basePath = @"C:\src\openssl-0.9.8g";

string originalConfigfile = "openssl.cnf";
string updatedConfigfile = "openssl.config";
foreach (string filename in Directory.GetFiles(basePath, "\*.\*", SearchOption.AllDirectories))
{
	string contents = File.ReadAllText(filename);
	if (contents.Contains(originalConfigfile))
	{
		Console.WriteLine(filename);
		File.WriteAllText(filename, contents.Replace(originalConfigfile, updatedConfigfile));
	}
}

File.WriteAllText(basePath + @"\apps\" + updatedConfigfile, File.ReadAllText(basePath + @"\apps\" + originalConfigfile));
```

Open a Visual Studio 2008 Command prompt and add references to the [Microsoft SDK](http://blogs.msdn.com/windowssdk) as following

```bash
SET PATH=%PATH%;C:\Program Files\Microsoft SDKs\Windows\v6.0A\bin
SET LIB=%LIB%;C:\Program Files\Microsoft SDKs\Windows\v6.0A\Lib
SET INCLUDE=%INCLUDE%;C:\Program Files\Microsoft SDKs\Windows\v6.0A\Include
```

Now we simply have to follow the tasks listed in INSTALL.W32:

```bash
perl Configure VC-WIN32 --prefix=c:/openssl
ms\do_masm
nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak test
nmake -f ms\ntdll.mak install
```

Happy OpenSSL'ing!
