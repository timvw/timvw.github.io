---
ID: 214
post_title: >
  Using
  System.DirectoryServices.AccountManagement
  to find the members of an AD group
author: timvw
post_date: 2008-03-08 21:14:48
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/03/08/using-systemdirectoryservicesaccountmanagement-to-find-the-members-of-an-ad-group/
published: true
dsq_thread_id:
  - "1922118654"
---
<p>A while ago i posted some code that demonstrated how to <a href="http://www.timvw.be/find-the-members-of-an-ad-group/">find the members of an AD group</a>. If you're using the brandnew .Net 3.5 framework you can take advantage of the <a href="http://msdn2.microsoft.com/en-us/library/system.directoryservices.accountmanagement.aspx">System.DirectoryServices.AccountManagement</a> library which is an abstraction for AD (DS, LDS) and SAM accounts. Using this new library my method can be simplified:</p>
[code lang="csharp"]private static IEnumerable<string> FindUsernames(string groupname)
{
 PrincipalContext principalContext = new PrincipalContext(ContextType.Domain, "mydomain");
 GroupPrincipal groupPrincipal = GroupPrincipal.FindByIdentity(principalContext, groupname);

 foreach (Principal principal in groupPrincipal.Members)
 {
  yield return principal.DistinguishedName;
 }
}[/code]
<p>If you're looking for more information i would recommend that you read <a href="http://msdn2.microsoft.com/en-us/magazine/cc135979.aspx">Managing Directory Security Principals in the .NET Framework 3.5</a>.</p>