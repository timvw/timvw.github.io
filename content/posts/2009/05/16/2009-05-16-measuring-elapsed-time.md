---
date: "2009-05-16T00:00:00Z"
guid: http://www.timvw.be/?p=1045
tags:
- CSharp
title: Measuring elapsed time
---
As the documentation for [System.Diagnostics.Stopwatch](http://msdn.microsoft.com/en-us/library/system.diagnostics.stopwatch.aspx) says

> In a typical Stopwatch scenario, you call the Start method, then eventually call the Stop method, and then you check elapsed time using the Elapsed property.

I find it a shame that they didn't provide a method that covers this particular scenario so i did it myself

```csharp
public static class Stopwatch
{
	public static TimeSpan Measure(this Action action)
	{
		var stopwatch = new System.Diagnostics.Stopwatch();
		stopwatch.Start();
		action.Invoke();
		stopwatch.Stop();
		return stopwatch.Elapsed;
	}
}
```

Consuming this method is as simple as

```csharp
var duration = Stopwatch.Measure(() => FindElement(10000));
Console.WriteLine("It took {0:0} seconds.", duration.TotalSeconds);
```
