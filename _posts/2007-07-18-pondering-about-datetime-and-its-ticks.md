---
id: 181
title: 'Pondering about DateTime and it&#039;s Ticks...'
date: 2007-07-18T18:29:29+00:00
author: timvw
layout: post
guid: http://www.timvw.be/pondering-about-datetime-and-its-ticks/
permalink: /2007/07/18/pondering-about-datetime-and-its-ticks/
dsq_thread_id:
  - 1933325799
tags:
  - 'C#'
---
Recently someone was able to convince me that there is no problem with using [System.DateTime](http://msdn2.microsoft.com/en-us/library/System.Datetime.aspx) for the storage of localtimes (even if DST is in effect), because it works with [Ticks](http://msdn2.microsoft.com/en-us/library/system.datetime.ticks.aspx) and i bought into his base + offset story.... The following table explains his reasoning

<table width="100%">
  <tr>
    <th style="width: 33%">
      Utc
    </th>
    
    <th style="width: 33%">
      Localtime
    </th>
    
    <th style="width: 33%">
      Ticks (Localtime)
    </th>
  </tr>
  
  <tr>
    <td>
      2007-10-27 23:59:59
    </td>
    
    <td>
      2007-10-28 01:59:59
    </td>
    
    <td>
      63329133<b>599</b>0000000
    </td>
  </tr>
  
  <tr style="background-color: orange">
    <td>
      +1 second
    </td>
    
    <td>
      2007-10-28 02:00:00
    </td>
    
    <td>
      63329133<b>600</b>0000000
    </td>
  </tr>
  
  <tr>
    <td>
      +2 seconds
    </td>
    
    <td>
      2007-10-28 02:00:01
    </td>
    
    <td>
      63329133<b>601</b>0000000
    </td>
  </tr>
  
  <tr>
    <td>
      +60 minutes
    </td>
    
    <td>
      2007-10-28 02:59:59
    </td>
    
    <td>
      63329137<b>199</b>0000000
    </td>
  </tr>
  
  <tr>
    <td>
      +60 minutes and 1 second
    </td>
    
    <td>
      2007-10-28 02:00:00
    </td>
    
    <td>
      63329133<b>200</b>0000000
    </td>
  </tr>
  
  <tr>
    <td>
      +60 minutes and 2 seconds
    </td>
    
    <td>
      2007-10-28 02:00:01
    </td>
    
    <td>
      63329133<b>201</b>0000000
    </td>
  </tr>
</table>

This reasoning gives you the impression that for each second **1**0000000 is added to the ticks.. However, this is faulty and in reality you get the following

<table width="100%">
  <tr>
    <th style="width: 33%">
      Utc
    </th>
    
    <th style="width: 33%">
      Localtime
    </th>
    
    <th style="width: 33%">
      Ticks (Localtime)
    </th>
  </tr>
  
  <tr>
    <td>
      2007-10-27 23:59:59
    </td>
    
    <td>
      2007-10-28 01:59:59
    </td>
    
    <td>
      63329133<b>599</b>0000000
    </td>
  </tr>
  
  <tr style="background-color: orange">
    <td>
      +1 second
    </td>
    
    <td>
      2007-10-28 02:00:00
    </td>
    
    <td>
      63329133<b>600</b>0000000
    </td>
  </tr>
  
  <tr>
    <td>
      +2 seconds
    </td>
    
    <td>
      2007-10-28 02:00:01
    </td>
    
    <td>
      63329133<b>601</b>0000000
    </td>
  </tr>
  
  <tr>
    <td>
      +60 minutes
    </td>
    
    <td>
      2007-10-28 02:59:59
    </td>
    
    <td>
      63329137<b>199</b>0000000
    </td>
  </tr>
  
  <tr style="background-color: orange">
    <td>
      +60 minutes and 1 second
    </td>
    
    <td>
      2007-10-28 02:00:00
    </td>
    
    <td>
      63329133<span style="color: red"><b>600</b></span>0000000
    </td>
  </tr>
  
  <tr>
    <td>
      +60 minutes and 2 seconds
    </td>
    
    <td>
      2007-10-28 02:00:01
    </td>
    
    <td>
      63329133<b>601</b>0000000
    </td>
  </tr>
</table>

As you can see, instead of adding **1**0000000 to the ticks between 2007-10-27 00:59:59 and 01:00:00 in UTC there is a <span style="color:red">reduction of ticks in the localtime</span> instead.... Because of this new DateTime(633291336000000000, DateTimeKind.Local) could represent both 2007-10-27 00:00:00 UTC and 2007-10-27 01:00:00 UTC... So if you want to keep out of trouble you'd better start storing your dates as UTC... If you don't believe me, run the test yourself

```csharp
List<dateTime> localTimes = new List<dateTime>();

// start at 2007-10-27 23:59:59 UTC, which is 2007-28-10 01:59:59 localtime
DateTime utcBase = new DateTime(2007, 10, 27, 23, 59, 59, DateTimeKind.Utc);
localTimes.Add(utcBase.ToLocalTime());

// add 1 second to the base, which is 2007-28-10 02:00:00 localtime (first time)
localTimes.Add(utcBase.AddSeconds(1).ToLocalTime());

// add 2 seconds to the base, which is 2007-28-10 02:00:01 localtime (first time)
localTimes.Add(utcBase.AddSeconds(2).ToLocalTime());

// add 60 minutes to the base, which is 2007-28-10 02:59:59 localtime (first time)
localTimes.Add(utcBase.AddMinutes(60).ToLocalTime());

// add 60 minutes and 1 second to the base, which is 2007-28-10 02:00:00 localtime (second time)
localTimes.Add(utcBase.AddMinutes(60).AddSeconds(1).ToLocalTime());

// add 60 minutes and 2 second to the base, which is 2007-28-10 02:00:01 localtime (second time)
localTimes.Add(utcBase.AddMinutes(60).AddSeconds(2).ToLocalTime());

foreach (DateTime localTime in localTimes)
{
	Console.WriteLine(localTime.ToString("yyyy-MM-dd HH:mm:ss"));
	Console.WriteLine(localTime.Ticks);
	Console.WriteLine();
}
```
