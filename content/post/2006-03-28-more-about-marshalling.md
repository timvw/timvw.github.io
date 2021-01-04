---
date: "2006-03-28T00:00:00Z"
tags:
- CSharp
title: More about marshalling
aliases:
 - /2006/03/28/more-about-marshalling/
 - /2006/03/28/more-about-marshalling.html
---
Last month i've started programming with the [.NET Framework](http://msdn.microsoft.com/netframework/) using Visual Basic, C++.NET and C# on a daily basis. The first thing i noticed is that some useful functions that were available in kernel32.dll, user32.dll, etc. have been removed from the [API](http://msdn2.microsoft.com/en-us/library/ms306608.aspx). At [pinvoke.net](http://www.pinvoke.net) you find a summary of the functions in these [DLL](http://en.wikipedia.org/wiki/Dynamic-link_library)s and the PInvoke signatures.The most common approach is to build classes for the DLLs as following

```csharp
namespace InterOp {
	public class User32 {
		[DllImport("user32.dll")]
		public static extern IntPtr GetDesktopWindow();
		[DllImport("user32.dll")]
		public static extern IntPtr GetWindowDC(IntPtr hWnd);
		[DllImport("user32.dll")]
		public static extern IntPtr ReleaseDC(IntPtr hWnd, IntPtr hDC);
		[DllImport("user32.dll")]
		public static extern IntPtr GetWindowRect(IntPtr hWnd, RECT rect);
	}

	public class GDI32 {
		[DllImport("gdi32.dll")]
		public static extern bool DeleteDC(IntPtr hDC);
		[DllImport("gdi32.dll")]
		public static extern bool DeleteObject(IntPtr hObject);
		[DllImport("gdi32.dll")]
		public static extern IntPtr SelectObject(IntPtr hDC, IntPtr hObject);
	}
}
```
