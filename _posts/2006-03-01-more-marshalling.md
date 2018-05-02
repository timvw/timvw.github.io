---
id: 36
title: 'More marshalling...'
date: 2006-03-01T02:49:22+00:00
author: timvw
layout: post
guid: http://www.timvw.be/more-marshalling/
permalink: /2006/03/01/more-marshalling/
tags:
  - C++
---
This snippet uses [GetPrivateProfileString](http://windowssdk.msdn.microsoft.com/library/default.asp?url=/library/en-us/sysinfo/base/getprivateprofilestring.asp) that is available in kernel32.dll. Apparently microsoft has decided to remove this useful function from the dotnet api.

```cpp
[DllImport("kernel32", SetLastError=true)]
extern int GetPrivateProfileString(
String ^pSection,
String ^pKey,
String ^pDefault,
StringBuilder ^pValue,
int pBufferLen,
String ^pFile
);

StringBuilder ^buf = gcnew StringBuilder(256);
GetPrivateProfileString(
"logsection",
"file",
"default",
buf,
buf->Capacity,
"example.ini"
);

std::string \_log\_file = new string(
(char*) Marshal::StringToHGlobalAnsi(logf).ToPointer()
);
```
