---
date: "2006-10-04T00:00:00Z"
guid: http://www.timvw.be/?p=4
tags:
- CSharp
title: From UnixTime to DateTime and back
aliases:
 - /2006/10/04/from-unixtime-to-datetime-and-back/
 - /2006/10/04/from-unixtime-to-datetime-and-back.html
---
Here are a couple of functions that allow you to convert from [UnixTime](http://en.wikipedia.org/wiki/Unixtime) to [DateTime](http://msdn2.microsoft.com/en-us/library/system.datetime.aspx) and back

```csharp
public class Util {
	private static DateTime UnixTime
	{
		get { return new DateTime(1970, 1, 1); }
	}

	public static DateTime FromUnixTime( double unixTime )
	{
		return UnixTime.AddSeconds( unixTime );
	}

	public static double ToUnixTime( DateTime dateTime )
	{
		TimeSpan timeSpan = dateTime -- UnixTime;
		return timeSpan.TotalSeconds;
	}
}
```
