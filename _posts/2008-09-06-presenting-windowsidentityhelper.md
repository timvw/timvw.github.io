---
ID: 525
post_title: Presenting WindowsIdentityHelper
author: timvw
post_date: 2008-09-06 16:56:14
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/09/06/presenting-windowsidentityhelper/
published: true
---
<p>One of the difficulties of using the <a href="http://msdn.microsoft.com/en-us/library/system.security.principal.windowsidentity.aspx">WindowsIdentity</a> class is the fact that it requires a handle (<a href="http://msdn.microsoft.com/en-us/library/system.intptr.aspx">IntPtr</a>) to a Windows Security Token. Using the <a href="http://msdn.microsoft.com/en-us/library/aa378184(VS.85).aspx">LogonUser</a> functionality we can get a hold of such a handle:</p>

[code lang="csharp"][DllImport(Advapi32File, CharSet = DefaultCharSet, SetLastError = DefaultSetLastError)]
public static extern bool LogonUser( /* other parameters */, out IntPtr userTokenHandle);[/code]

<p>The easiest way to avoid memory leaks is to implement a custom <a href="http://msdn.microsoft.com/en-us/library/system.runtime.interopservices.safehandle.aspx">SafeHandle</a>:</p>
[code lang="csharp"]public class SafeTokenHandle : SafeHandleZeroOrMinusOneIsInvalid
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
}[/code]

<p>With that SafeHandle in place we can change the signature to:</p>

[code lang="csharp"][DllImport(Advapi32File, CharSet = DefaultCharSet, SetLastError = DefaultSetLastError)]
public static extern bool LogonUser( /* other parameters */, out SafeTokenHandle userTokenHandle);[/code]

<p>With the Be.Timvw.Framework.Security.Principal.WindowsIdentityHelper we can now easily obtain a WindowsIdentity and use it to do some impersonation:</p>

[code lang="csharp"]using(WindowsIdentityHelper windowsIdentityHelper = new WindowsIdentityHelper(username, domain, password))
using(windowsIdentityHelper.GetWindowsIdentity().Impersonate())
{
 File.WriteAllText(@"c:\temp\blah.txt", "hello there");
}[/code]