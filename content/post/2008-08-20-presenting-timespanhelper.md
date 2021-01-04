---
date: "2008-08-20T00:00:00Z"
guid: http://www.timvw.be/?p=418
tags:
- CSharp
title: Presenting TimeSpanHelper
aliases:
 - /2008/08/20/presenting-timespanhelper/
 - /2008/08/20/presenting-timespanhelper.html
---
A [TimeSpan](http://msdn.microsoft.com/en-us/library/system.timespan.aspx) is a structure that represents a time interval or a duration. To make the everything as clear as possible, a well designed system should not only know the quantity, but also the unit of that quantity. In order to create a TimeSpan that represents the right value, you will probably use one of the [FromXXX (Hours, Days, Minutes, Seconds) methods](http://msdn.microsoft.com/en-us/library/system.timespan_methods.aspx) as following

```csharp
double value = 1;
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
// more else if statements...
```

After a while you get bored of writing that same if-else (or switch) construct and you end up wishing for something like

```csharp
double value = 1;
string unit = "Day";

TimeUnit timeUnit = EnumHelper.Parse<timeUnit>(unit);
TimeSpan actual = TimeSpanHelper.Create(value, timeUnit);
```

Well, from now on you can find it in [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework)
