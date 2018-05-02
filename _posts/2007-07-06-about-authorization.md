---
id: 178
title: About Authorization
date: 2007-07-06T15:30:14+00:00
author: timvw
layout: post
guid: http://www.timvw.be/about-iidentity-and-iprincipal/
permalink: /2007/07/06/about-authorization/
tags:
  - 'C#'
---
Yesterday i visited an evening session about authentication and authorization at [Compuware](http://www.compuware.be) (Yes, i've got interesting collegues that are willing to share their knowledige). Anyway, i left the meeting with a couple of questions

**How does System.Security.Principal.PrincipalPolicy work under [Mono](http://www.mono-project.com/Main_Page)?**
  
  
Well, NoPrincipal and UnauthenticatedPrincipal behave exactly the same way as they do in the Microsoft implementation. For the WindowsPrincipal the unix groups are used to determine the result of IsInRole. eg

```csharp
//lists the groups the user timvw is part of:
//timvw@debian:~$ groups
//timvw dialout cdrom floppy audio video plugdev

AppDomain.CurrentDomain.SetPrincipalPolicy(PrincipalPolicy.WindowsPrincipal);
IPrincipal principal = Thread.CurrentPrincipal;

string[] roles = new string[] { "floppy", "wheel" };
foreach(string role in roles)
{
	Console.WriteLine("{0} is in the {1} role: {2}.", principal.Identity.Name, role, principal.IsInRole(role));
}

// the output:
//timvw@debian:~$ ./Main.exe
//timvw is in the floppy role: True.
//timvw is in the wheel role: False.
```

**How are instances of IPrincipal propgated into other threads?**
  
  
A bit of research learned me that BeginInvoke and Thread.Start copy the Thread.CurrentPrincipal into the new thread and that ThreadPool.QueueUserWorkItem and System.Threading.Timer don't copy the Thread.CurrentPrincipal.

**How can i use the [Authorization Manager](http://blogs.msdn.com/azman/) without Windows Identity?**
  
  
A possible solution would be the following

```csharp
static string GetSid()
{
	// modify this so that it contains an application and user id
	return "S-1-9-1-1";
}

// By passing in 1 as the second parameter, no verification of the SID against the AD is performed
IAzClientContext cctx = app.InitializeClientContextFromStringSid(GetSid(), 1, null);

// Because the MMC does not allow you to add custom SIDs you'll have to edit to add these manually (eg: by using the API)
IAzApplicationGroup group = app.OpenApplicationGroup("DemoApplicationUsers", null);
group.AddMember(GetSid(), null);
group.Submit(0, null);

// And now you can verify is the custom SID has access to a given operation:
Console.WriteLine(HasAccess(cctx, null, new int[] { 1 }));

static bool HasAccess(IAzClientContext context, string[] scopeNames, int[] operationIds)
{
	string subject = "audit";

	object scopes;
	if (scopeNames == null || scopeNames.Length == 0)
	{
		scopes = new object[] { "" };
	}
	else
	{
		scopes = Array.ConvertAll<string, object>(scopeNames, delegate(string scopeName) { return scopeName; });
	}

	object[] operations = Array.ConvertAll<int, object>(operationIds, delegate(int operationId) { return operationId; });
	object[] results = (object[])context.AccessCheck(subject, scopes, operations, null, null, null, null, null);
	foreach (object result in results)
	{
		if ((int)result != 0)
		{
			return false;
		}
	}

	return true;
}
```
