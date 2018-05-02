---
id: 150
title: 'About Thread-Safe GUI...'
date: 2007-01-21T15:57:25+00:00
author: timvw
layout: post
guid: http://www.timvw.be/about-thread-safe-gui/
permalink: /2007/01/21/about-thread-safe-gui/
tags:
  - 'C#'
  - Windows Forms
---
If you're writing windows applications you'll most certainly recognize the following piece of code

```csharp
private delegate void UpdateIntResultDelegate(int result);

private void UpdateIntResult(int result)
{
	if (this.labelIntResult.InvokeRequired)
		this.labelIntResult.Invoke(new UpdateIntResultDelegate(this.UpdateIntResult), result);
	else
		this.myDataSource.IntResult = result;
}

private delegate void UpdateStringResultDelegate(string result);

private void UpdateStringResult(string result)
{
	if (this.labelStringResult.InvokeRequired)
		this.labelStringResult.Invoke(new UpdateStringResultDelegate(this.UpdateStringResult), result);
	else
		this.myDataSource.StringResult = result;
}
```

Today i was fed up with defining all these Delegates.. So i decided to define a generic delegate instead

```csharp
delegate void Delegate<t>(T t);
```

And now i can reuse this Delegate for my two update methods

```csharp
private void UpdateIntResult(int result)
{
	if (this.labelIntResult.InvokeRequired)
		this.labelIntResult.Invoke(new Delegate<int>(this.UpdateIntResult), result);
	else
		this.myDataSource.IntResult = result;
}

private void UpdateStringResult(string result)
{
	if (this.labelStringResult.InvokeRequired)
		this.labelStringResult.Invoke(new Delegate<string>(this.UpdateStringResult), result);
	else
		this.myDataSource.StringResult = result;
}
```

Apparently (and not surprisingly) i'm not the first to come up with this idea, a little websearch for 'Generic Delegate' learned me that [Roy Osherove](http://weblogs.asp.net/rosherove/default.aspx) blogged about it in: [The 3 ways to create a Thread-Safe GUI with .NET 2.0, with one clear winner](http://weblogs.asp.net/rosherove/archive/2006/03/01/439309.aspx). After reading the article i decided to take the following approach (The call to UpdateIntResult is type-safe, it only calls Invoke when it's required and no duplication)

```csharp
void UpdateIntResult(int result)
{
	if (this.labelIntResult.InvokeRequired)
	{
		this.labelIntResult.Invoke(new MethodInvoker(delegate { this.UpdateIntResult(result); }));
	}
	else
	{
		this.myDataSource.IntResult = result;
	}
}
```
