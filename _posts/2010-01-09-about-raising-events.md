---
ID: 1605
post_title: About raising events
author: timvw
post_date: 2010-01-09 18:42:48
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/01/09/about-raising-events/
published: true
---
<p>Very often i see people write the following to 'safely' raise a method:</p>

[code lang="csharp"]public event EventHandler Stopped;

void RaiseStoppedEvent()
{
 if (Stopped != null) Stopped(this, EventArgs.Empty);
}[/code]

<p>Some developers think that they should program defensively and avoid the potential concurrency problem:</p>

[code lang="csharp"]public event EventHandler Stopped;

void RaiseStoppedEvent()
{
 var handler = Stopped;
 if (handler!= null) handler(this, EventArgs.Empty);
}[/code]

<p>And then there is Tim's way to raise an event:  (If i'm not mistaken it was <a href="http://www.ayende.com">Ayende</a> who once blogged about this) </p>

[code lang="csharp"]public event EventHandler Stopped = delegate { };

void RaiseStoppedEvent()
{
 Stopped(this, EventArgs.Empty);
}[/code]