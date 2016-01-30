---
ID: 36
post_title: 'More marshalling&#8230;'
author: timvw
post_date: 2006-03-01 02:49:22
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/03/01/more-marshalling/
published: true
---
<p>This snippet uses <a href="http://windowssdk.msdn.microsoft.com/library/default.asp?url=/library/en-us/sysinfo/base/getprivateprofilestring.asp">GetPrivateProfileString</a>  that is available in kernel32.dll. Apparently microsoft has decided to remove this useful function from the dotnet api.</p>

[code lang="cpp"]
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

std::string _log_file = new string(
  (char*) Marshal::StringToHGlobalAnsi(logf).ToPointer()
);
[/code]