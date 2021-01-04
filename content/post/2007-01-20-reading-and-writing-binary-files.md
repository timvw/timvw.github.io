---
date: "2007-01-20T00:00:00Z"
tags:
- C#
title: Reading and writing unmanged structs from binary files
aliases:
 - /2007/01/20/reading-and-writing-binary-files/
 - /2007/01/20/reading-and-writing-binary-files.html
---
I still remember one of the first tasks during my internship (At a software shop that still used Visual Studio 6 as development environment) last year: Develop a GUI application using .Net that allows the user to manipulate data stored in a binary file which was generated by c/c++ program. As a newcomer to C# programming i just couldn't find the right attributes to [Marshal](http://msdn2.microsoft.com/en-us/library/04fy9ya1.aspx) the following structs

```cpp
struct test1 {
	char name[9];
	int score;
};

struct test2 {
	test1 items[10];
}
```

After a couple of days they wanted me to deliver a product, so i decided to stop experimenting and wrote the application in C++ ([Example](http://www.timvw.be/reading-unmanaged-structs-with-net/)). Since i don't like unanswered questions, i decided to give it another try this afternoon... It didn't take long to come up with the following

```csharp
[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Ansi, Pack=4)]
struct Test1
{
	[MarshalAs(UnmanagedType.ByValTStr, SizeConst=9)]
	public string Name;
	public int Score;
}

[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Ansi, Pack=4)]
struct Test2
{
	[MarshalAs(UnmanagedType.ByValArray, SizeConst=10)]
	public Test1[] Items;
}

static object Read(Stream stream, Type t)
{
	byte[] buffer = new byte[Marshal.SizeOf(t)];
	for (int read = 0; read < buffer.Length; read += stream.Read(buffer, read, buffer.Length)) ; 
	GCHandle gcHandle = GCHandle.Alloc(buffer, GCHandleType.Pinned); 
	object o = Marshal.PtrToStructure(gcHandle.AddrOfPinnedObject(), t); 
	gcHandle.Free(); return o; 
} 
	
static void Write(Stream stream, object o) 
{ 
	byte[] buffer = new byte[Marshal.SizeOf(o.GetType())]; 
	GCHandle gcHandle = GCHandle.Alloc(buffer, GCHandleType.Pinned); 
	Marshal.StructureToPtr(o, gcHandle.AddrOfPinnedObject(), true); 
	stream.Write(buffer, 0, buffer.Length); 
	gcHandle.Free(); 
} 

static void Main(string[] args) 
{ 
	Test1 test1 = new Test1(); 
	test1.Name = "timvw"; 
	test1.Score = 100; 
	using (FileStream fileStream = new FileStream(@"c:\test.dat", FileMode.OpenOrCreate)) 
	{ 
		Write(fileStream, test1); 
		fileStream.Seek(0, SeekOrigin.Begin); 
		Test1 test2 = (Test1) 
		Read(fileStream, typeof(Test1)); 
		Console.WriteLine("Name: {0} Score: {1}", test2.Name, test2.Score); 
	} 
	Console.Write("{0}Press any key to continue...", Environment.NewLine); 
	Console.ReadKey(); 
}
```