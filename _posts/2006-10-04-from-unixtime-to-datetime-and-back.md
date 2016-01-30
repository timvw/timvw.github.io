---
ID: 4
post_title: From UnixTime to DateTime and back
author: timvw
post_date: 2006-10-04 16:55:25
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/10/04/from-unixtime-to-datetime-and-back/
published: true
dsq_thread_id:
  - "1921912032"
---
<p>Here are a couple of functions that allow you to convert from <a href="http://en.wikipedia.org/wiki/Unixtime">UnixTime</a> to <a href="http://msdn2.microsoft.com/en-us/library/system.datetime.aspx">DateTime</a> and back:</p>
[code lang="csharp"]
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
  TimeSpan timeSpan = dateTime - UnixTime;
  return timeSpan.TotalSeconds;
 }
}
[/code]