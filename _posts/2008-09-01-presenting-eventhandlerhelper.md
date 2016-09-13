---
ID: 467
post_title: Presenting EventHandlerHelper
author: timvw
post_date: 2008-09-01 15:22:30
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/09/01/presenting-eventhandlerhelper/
published: true
dsq_thread_id:
  - "1933325926"
---
<p>Being bored of writing code to raise an event, i have added an EventHandlerHelper to <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a>.</p>
[code lang="csharp"]public static class EventHandlerHelper
{
 [MethodImpl(MethodImplOptions.NoInlining)]
 public static void Raise<t>(EventHandler<t> handler, object sender, T e)
  where T : EventArgs
 {
  if (handler != null)
  {
   handler(sender, e);
  }
 }
}[/code]