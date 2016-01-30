---
ID: 418
post_title: Presenting TimeSpanHelper
author: timvw
post_date: 2008-08-20 19:19:56
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/08/20/presenting-timespanhelper/
published: true
---
<p>A <a href="http://msdn.microsoft.com/en-us/library/system.timespan.aspx">TimeSpan</a> is a structure that represents a time interval or a duration. To make the everything as clear as possible, a well designed system should not only know the quantity, but also the unit of that quantity. In order to create a TimeSpan that represents the right value, you will probably use one of the <a href="http://msdn.microsoft.com/en-us/library/system.timespan_methods.aspx">FromXXX (Hours, Days, Minutes, Seconds) methods</a> as following:</p>

[code lang="csharp"]double value = 1;
string unit = "Day";

TimeSpan actual;
if (unit == "Day")
{
 actual = TimeSpan.FromDays(value);
}
else if (unit == "Hour")
{
 actual = TimeSpan.FromHours(value);
}
// more else if statements...[/code]

<p>After a while you get bored of writing that same if-else (or switch) construct and you end up wishing for something like:</p>
[code lang="csharp"]double value = 1;
string unit = "Day";

TimeUnit timeUnit = EnumHelper.Parse<timeUnit>(unit);
TimeSpan actual = TimeSpanHelper.Create(value, timeUnit);[/code]

<p>Well, from now on you can find it in <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a> ;)</p>