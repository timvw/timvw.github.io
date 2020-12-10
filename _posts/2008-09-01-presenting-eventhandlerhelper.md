---
title: Presenting EventHandlerHelper
layout: post
guid: http://www.timvw.be/?p=467
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
