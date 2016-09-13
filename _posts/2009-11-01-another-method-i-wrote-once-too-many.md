---
ID: 1496
post_title: Another method i wrote once too many
author: timvw
post_date: 2009-11-01 16:57:59
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/11/01/another-method-i-wrote-once-too-many/
published: true
dsq_thread_id:
  - "1933325143"
---
<p>Virtually every Silverlight application will fetch resources at one point or another. In case you're using the <a href="http://msdn.microsoft.com/en-us/library/system.net.webclient(VS.95).aspx">WebClient</a> you have probably written the following in your xxxCompletedEventHandler:</p>

[code lang="csharp"]if (e.Error != null && !e.Cancelled)
{
 // do something with the result
}[/code]

<p>Anyway, i don't like repetition so i captured the conditions in a method:</p>

[code lang="csharp"]public static class ExtensionMethods
{
 public static bool HasResult(this AsyncCompletedEventArgs e)
 {
  if (e.Error != null) return false;
  if (e.Cancelled) return false;
  return true;
 }
}[/code]

<p>And now we can write our code as:</p>

[code lang="csharp"]if (e.HasResult())
{
 // do something with the result
}[/code]

<p>Apart from saving a couple of keystrokes this also allows us to easily add another condition to determine the success of the operation.</p>