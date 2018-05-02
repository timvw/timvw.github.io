---
id: 467
title: Presenting EventHandlerHelper
date: 2008-09-01T15:22:30+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=467
permalink: /2008/09/01/presenting-eventhandlerhelper/
dsq_thread_id:
  - 1933325926
tags:
  - 'C#'
---
Being bored of writing code to raise an event, i have added an EventHandlerHelper to [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework).

```csharp
public static class EventHandlerHelper
{
	[MethodImpl(MethodImplOptions.NoInlining)]
	public static void Raise<T>(EventHandler<T> handler, object sender, T e) where T : EventArgs
	{
		if (handler != null)
		{
			handler(sender, e);
		}
	}
}
```
