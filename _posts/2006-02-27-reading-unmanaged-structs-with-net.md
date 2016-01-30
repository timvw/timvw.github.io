---
ID: 37
post_title: Reading unmanaged structs with .NET
author: timvw
post_date: 2006-02-27 02:50:41
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/02/27/reading-unmanaged-structs-with-net/
published: true
dsq_thread_id:
  - "1920134231"
---
<p>Last week i've spend a lot of time studying <a href="http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpref/html/frlrfSystemRuntimeInteropServices.asp">System::Runtime::InteropServices</a>. It took me a while to figure out how i could read unmanaged structs with .NET <a href="http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpref/html/frlrfsystemio.asp">System::IO</a>. Here is a bit of sample code (Should be obvious enough to write a template or generic class for all sorts of structs, just like i did at the office)</p>
[code lang="cpp"]
typedef struct {
  char name[9];
  int name;
  double sterr;
} TEST;

FileStream ^f = gcnew FileStream("C:\\TEST.DAT", FileMode::Open, FileAccess::ReadWrite);
BinaryReader ^r = gcnew BinaryReader(f);
array<byte> ^buf = r->ReadBytes(sizeof(TEST));
TEST test;
Marshal::Copy(buf, 0, (IntPtr) &test, sizeof(TEST));
[/code]