---
date: "2006-05-30T00:00:00Z"
tags:
- C#
title: Building a chain of responsibility with delegates
aliases:
 - /2006/05/30/building-a-chain-of-responsibility-with-delegates/
 - /2006/05/30/building-a-chain-of-responsibility-with-delegates.html
---
Imagine that you have to write a function that verifies if there is a license available for a given clientID. Suppose that there are a couple of possibilities to find an available license. Your code would probably look like the following

```csharp
// This code verifies if the client with the given clientID is licensed
// returns the licenseID or 0 if no license is available
public Int32 IsLicensed(Int32 clientID) 
{
	int result = 0;

	// verify if there is already a license 'assigned' to the client
	result = IsAssigned(clientID);

	if (result == 0) 
	{
		// find a dedicated license (license that is bound to the given client)
		result = IsDedicated(clientID);

		if (result == 0) 
		{
			// find a nondedicated license (license that can be used by any client)
			result = IsNonDedicated(clientID);
		}
	}

	return result;
}
```

It's obvious that this structures becomes more complex as the number of possible ways to get a license grows. If you look a while at the structure you'll notice a pattern: each function (IsAssigned, IsDedicated, IsNonDedicted) verifies if there is a license availble. If the function didn't find a license the next function is performed. If you translate this to OO you would end up with something similar to the following

```csharp
// this methods tries to find an available license for the given clientID
// returns the licenseID or 0 if no license was found
delegate Int32 FindLicenseMethod(Int32 clientID);

public class LicenseFinder 
{
	private FindLicenseMethod method;
	private LicenseFinder next;

	public LicenseFinder(FindLicenseMethod, method, LicenseFinder next) 
	{
		this.method = method;
		this.next = next;
	}

	// property for the next licensefinder in the chain
	public Next 
	{
		get { return next; }
		set { next = val; }
	}

	public Int32 GetLicense(Int32 clientID) 
	{
		Int32 result = method(clientID);

		if (result == 0 && Next != null) 
		{
			result = Next.GetLicense(clientID);
		}

		return result;
	}

	public Int32 IsLicensed(Int32 clientID) 
	{
		LicenseFinder f = new LicenseFinder(
		new FindLicenseMethod(IsAssigned), new LicenseFinder(
		new FindLicenseMethod(IsDedicated), new LicenseFinder(
		new FindLicenseMethod(IsNonDedicated), null))));

		return f.GetLicense(clientID);
	}
}
```
