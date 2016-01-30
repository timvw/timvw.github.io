---
ID: 49
post_title: >
  Updating the Internet Options / Lan
  Settings
author: timvw
post_date: 2006-10-12 20:43:48
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/10/12/updating-the-internet-options-lan-settings/
published: true
dsq_thread_id:
  - "1920134401"
---
<p>A while ago i wrote that i had created two .reg files to update my Internet Options / Lan Settings (<a href="http://www.timvw.be/automating-the-configuration-of-internet-options-and-lan-settings/">Automating the configuration of Internet Options / Lan Settings</a>). Yesterday i build a little Windows Service that automates this completely. With <a href="http://windowssdk.msdn.microsoft.com/en-gb/library/aa366329.aspx">NotifyAddrChange</a> i am notified whenever a change occurs in the table that maps IPv4 addresses to interfaces:</p>
[code lang="csharp"]
[DllImport("iphlpapi.dll", CharSet = CharSet.Ansi)]
private static extern int NotifyAddrChange(ref IntPtr handle, IntPtr overlapped);
[/code]
<p>The main loop of the service looks like this:</p>
[code lang="csharp"]
while (this.isRunning)
{
 IntPtr handle = IntPtr.Zero;
 NotifyAddrChange(ref handle, IntPtr.Zero);
 UpdateRegistry();
}
[/code]
<p>Whenever i'm connected to the LAN at work i want to use a proxy. Here's the code that takes care of this:</p>
[code lang="csharp"]
private static void UpdateRegistry()
{
 RegistryKey registryKey = Registry.CurrentUser.OpenSubKey(@"Software\Microsoft\Windows\CurrentVersion\Internet Settings", true);
 if (IsInWorkLan())
 {
  registryKey.SetValue("AutoConfigURL", "http://123.456.789.0");
 }
 else
 {
  registryKey.DeleteValue("AutoConfigURL", false);
 }
}
[/code]
<p>Figuring out whether i'm connected to the LAN at work is pretty simple. As soon as i have an IPAddress that looks like 192.168.X.Y i'm connected. Here's how i translated this into code:</p>
[code lang="csharp"]
private static bool IsInWorkLan()
{
 foreach (IPAddress ipAddress in Dns.GetHostAddresses(Dns.GetHostName()))
 {
  if (IsInWorkLan(ipAddress))
  {
   return true;
  }
 }

 return false;
}

private static bool IsInWorkLan(IPAddress ipAddress)
{
 byte[] bytes = ipAddress.GetAddressBytes();
 if ((int)bytes[0] == 192 && (int)bytes[1] == 168)
 {
  return true;
 }

 return false;
}
[/code]