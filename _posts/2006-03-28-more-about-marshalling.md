---
ID: 53
post_title: More about marshalling
author: timvw
post_date: 2006-03-28 21:16:20
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/03/28/more-about-marshalling/
published: true
---
<p>Last month i've started programming with the <a href="http://msdn.microsoft.com/netframework/">.NET Framework</a> using Visual Basic, C++.NET and C# on a daily basis. The first thing i noticed is that some useful functions that were available in kernel32.dll, user32.dll, etc. have been removed from the <a href="http://msdn2.microsoft.com/en-us/library/ms306608.aspx">API</a>. At <a href="http://www.pinvoke.net">pinvoke.net</a> you find a summary of the functions in these <a href="http://en.wikipedia.org/wiki/Dynamic-link_library">DLL</a>s and the PInvoke signatures.The most common approach is to build classes for the DLLs as following:</p>
[code lang="csharp"]
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

  public  class GDI32 {
    [DllImport("gdi32.dll")]
    public static extern bool DeleteDC(IntPtr hDC);
    [DllImport("gdi32.dll")]
    public static extern bool DeleteObject(IntPtr hObject);
    [DllImport("gdi32.dll")]
    public static extern IntPtr SelectObject(IntPtr hDC, IntPtr hObject);
  }
}
[/code]