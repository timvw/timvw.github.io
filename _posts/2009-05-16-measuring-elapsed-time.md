---
ID: 1045
post_title: Measuring elapsed time
author: timvw
post_date: 2009-05-16 13:02:49
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/05/16/measuring-elapsed-time/
published: true
---
<p>As the documentation for <a href="http://msdn.microsoft.com/en-us/library/system.diagnostics.stopwatch.aspx">System.Diagnostics.Stopwatch</a> says:</p>

<blockquote>In a typical Stopwatch scenario, you call the Start method, then eventually call the Stop method, and then you check elapsed time using the Elapsed property.</blockquote>

<p>I find it a shame that they didn't provide a method that covers this particular scenario so i did it myself:</p>

[code lang="csharp"]public static class Stopwatch
{
 public static TimeSpan Measure(this Action action)
 {
  var stopwatch = new System.Diagnostics.Stopwatch();
  stopwatch.Start();
  action.Invoke();
  stopwatch.Stop();
  return stopwatch.Elapsed;
 }
}[/code]

<p>Consuming this method is as simple as:</p>

[code lang="csharp"]var duration = Stopwatch.Measure(() => FindElement(10000));
Console.WriteLine("It took {0:0} seconds.", duration.TotalSeconds);[/code]