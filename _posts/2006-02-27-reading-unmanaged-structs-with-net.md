---
title: Reading unmanaged structs with .NET
layout: post
tags:
  - C++
---
Last week i've spend a lot of time studying [System::Runtime::InteropServices](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpref/html/frlrfSystemRuntimeInteropServices.asp). It took me a while to figure out how i could read unmanaged structs with .NET [System::IO](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpref/html/frlrfsystemio.asp). Here is a bit of sample code (Should be obvious enough to write a template or generic class for all sorts of structs, just like i did at the office)

```cpp
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
```
