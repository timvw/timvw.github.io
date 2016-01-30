---
ID: 145
post_title: Presenting a Generic RemotingHelper
author: timvw
post_date: 2007-01-12 01:29:26
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/01/12/presenting-a-generic-remotinghelper/
published: true
---
<p>Last couple of months i've been experimenting with <a href="http://msdn2.microsoft.com/en-us/library/kwdt6w2k.aspx">Remoting</a>. Here is a class that helps a client to acquire proxies to an endpoint served by the requested well-known object:</p>
[code lang="csharp"]public static class RemotingHelper
{
 static RemotingHelper()
 {
  RemotingConfiguration.Configure(AppDomain.CurrentDomain.SetupInformation.ConfigurationFile, false);
 }

 private static object GetService(string fullName)
 {
  WellKnownClientTypeEntry[] wellKnownClientTypeEntries = RemotingConfiguration.GetRegisteredWellKnownClientTypes();
  foreach (WellKnownClientTypeEntry welknownClientTypeEntry in wellKnownClientTypeEntries)
  {
   if (welknownClientTypeEntry.ObjectType.FullName == fullName)
   {
    return Activator.GetObject(welknownClientTypeEntry.ObjectType, welknownClientTypeEntry.ObjectUrl);
   }
  }

  throw new ArgumentException(fullName + " is not a wellKnownClientType.");
 }

 public static T GetService<t>()
 {
   return (T) RemotingHelper.GetService(typeof(T).FullName);
 }
}[/code]
<p>Getting a proxy is as easy as (Presuming that you've configured the system.runtime.remoting in your App.config):</p>
[code lang="csharp"]
IContract contract = RemotingHelper.GetService<icontract>();
[/code]