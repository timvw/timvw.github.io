---
id: 1496
title: Another method i wrote once too many
date: 2009-11-01T16:57:59+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1496
permalink: /2009/11/01/another-method-i-wrote-once-too-many/
dsq_thread_id:
  - 1933325143
tags:
  - 'C#'
---
Virtually every Silverlight application will fetch resources at one point or another. In case you're using the [WebClient](http://msdn.microsoft.com/en-us/library/system.net.webclient(VS.95).aspx) you have probably written the following in your xxxCompletedEventHandler

```csharp
if (e.Error != null && !e.Cancelled)
{
	// do something with the result
}
```

Anyway, i don't like repetition so i captured the conditions in a method:

```csharp
public static class ExtensionMethods
{
	public static bool HasResult(this AsyncCompletedEventArgs e)
	{
		if (e.Error != null) return false;
		if (e.Cancelled) return false;
		return true;
	}
}
```

And now we can write our code as:

```csharp
if (e.HasResult())
{
	// do something with the result
}
```

Apart from saving a couple of keystrokes this also allows us to easily add another condition to determine the success of the operation.
