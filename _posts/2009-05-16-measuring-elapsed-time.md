---
id: 1045
title: Measuring elapsed time
date: 2009-05-16T13:02:49+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1045
permalink: /2009/05/16/measuring-elapsed-time/
tags:
  - 'C#'
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
