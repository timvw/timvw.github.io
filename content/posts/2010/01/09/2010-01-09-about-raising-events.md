---
date: "2010-01-09T00:00:00Z"
guid: http://www.timvw.be/?p=1605
tags:
- CSharp
title: About raising events
aliases:
 - /2010/01/09/about-raising-events/
 - /2010/01/09/about-raising-events.html
---
Very often i see people write the following to 'safely' raise a method

```csharp
public event EventHandler Stopped;

void RaiseStoppedEvent()
{
	if (Stopped != null) Stopped(this, EventArgs.Empty);
}
```

Some developers think that they should program defensively and avoid the potential concurrency problem

```csharp
public event EventHandler Stopped;

void RaiseStoppedEvent()
{
	var handler = Stopped;
	if (handler!= null) handler(this, EventArgs.Empty);
}
```

And then there is Tim's way to raise an event: (If i'm not mistaken it was [Ayende](http://www.ayende.com) who once blogged about this) 

```csharp
public event EventHandler Stopped = delegate { };

void RaiseStoppedEvent()
{
	Stopped(this, EventArgs.Empty);
}
```
