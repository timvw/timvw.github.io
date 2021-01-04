---
date: "2008-09-01T00:00:00Z"
guid: http://www.timvw.be/?p=467
tags:
- CSharp
title: Presenting EventHandlerHelper
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
