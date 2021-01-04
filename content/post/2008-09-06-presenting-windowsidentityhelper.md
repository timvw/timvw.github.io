---
date: "2008-09-06T00:00:00Z"
tags:
- CSharp
title: Presenting WindowsIdentityHelper
aliases:
 - /2008/09/06/presenting-windowsidentityhelper/
 - /2008/09/06/presenting-windowsidentityhelper.html
---
One of the difficulties of using the [WindowsIdentity](http://msdn.microsoft.com/en-us/library/system.security.principal.windowsidentity.aspx) class is the fact that it requires a handle ([IntPtr](http://msdn.microsoft.com/en-us/library/system.intptr.aspx)) to a Windows Security Token. Using the [LogonUser](http://msdn.microsoft.com/en-us/library/aa378184(VS.85).aspx) functionality we can get a hold of such a handle

```csharp
[DllImport(Advapi32File, CharSet = DefaultCharSet, SetLastError = DefaultSetLastError)]
public static extern bool LogonUser( /* other parameters */, out IntPtr userTokenHandle);
```

The easiest way to avoid memory leaks is to implement a custom [SafeHandle](http://msdn.microsoft.com/en-us/library/system.runtime.interopservices.safehandle.aspx)

```csharp
public class SafeTokenHandle : SafeHandleZeroOrMinusOneIsInvalid
{
	protected internal SafeTokenHandle()
	: base(true)
	{
	}

	protected override bool ReleaseHandle()
	{
		if(!this.IsInvalid)
		{
			return NativeMethods.CloseHandle(this.handle);
		}

		return true;
	}
}
```

With that SafeHandle in place we can change the signature to

```csharp
[DllImport(Advapi32File, CharSet = DefaultCharSet, SetLastError = DefaultSetLastError)]
public static extern bool LogonUser( /* other parameters */, out SafeTokenHandle userTokenHandle);
```

With the Be.Timvw.Framework.Security.Principal.WindowsIdentityHelper we can now easily obtain a WindowsIdentity and use it to do some impersonation

```csharp
using(WindowsIdentityHelper windowsIdentityHelper = new WindowsIdentityHelper(username, domain, password))
using(windowsIdentityHelper.GetWindowsIdentity().Impersonate())
{
	File.WriteAllText(@"c:\temp\blah.txt", "hello there");
}
```
