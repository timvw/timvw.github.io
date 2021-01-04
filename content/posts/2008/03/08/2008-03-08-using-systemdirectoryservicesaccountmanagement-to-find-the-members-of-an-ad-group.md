---
date: "2008-03-08T00:00:00Z"
tags:
- CSharp
title: Using System.DirectoryServices.AccountManagement to find the members of an AD group
---
A while ago i posted some code that demonstrated how to [find the members of an AD group](http://www.timvw.be/find-the-members-of-an-ad-group/). If you're using the brandnew .Net 3.5 framework you can take advantage of the [System.DirectoryServices.AccountManagement](http://msdn2.microsoft.com/en-us/library/system.directoryservices.accountmanagement.aspx) library which is an abstraction for AD (DS, LDS) and SAM accounts. Using this new library my method can be simplified

```csharp
private static IEnumerable<string> FindUsernames(string groupname)
{
	PrincipalContext principalContext = new PrincipalContext(ContextType.Domain, "mydomain");
	GroupPrincipal groupPrincipal = GroupPrincipal.FindByIdentity(principalContext, groupname);

	foreach (Principal principal in groupPrincipal.Members)
	{
		yield return principal.DistinguishedName;
	}
}
```

If you're looking for more information i would recommend that you read [Managing Directory Security Principals in the .NET Framework 3.5](http://msdn2.microsoft.com/en-us/magazine/cc135979.aspx).
