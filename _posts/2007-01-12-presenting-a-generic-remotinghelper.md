---
title: Presenting a Generic RemotingHelper
layout: post
tags:
  - 'C#'
---
Last couple of months i've been experimenting with [Remoting](http://msdn2.microsoft.com/en-us/library/kwdt6w2k.aspx). Here is a class that helps a client to acquire proxies to an endpoint served by the requested well-known object

```csharp
public static class RemotingHelper
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
}
```

Getting a proxy is as easy as (Presuming that you've configured the system.runtime.remoting in your App.config)

```csharp
IContract contract = RemotingHelper.GetService<icontract>();
```
