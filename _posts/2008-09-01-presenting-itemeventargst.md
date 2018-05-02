---
id: 463
title: 'Presenting ItemEventArgs&lt;T&gt;'
date: 2008-09-01T15:22:37+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=463
permalink: /2008/09/01/presenting-itemeventargst/
tags:
  - 'C#'
---
Because i believe in the [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself) principle i decided to add a generic ItemEventArgs class to [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework)

```csharp
public class ItemEventArgs<T> : EventArgs
{
	private T item;

	public ItemEventArgs(T item)
	{
		this.item = item;
	}

	public T Item
	{
		get { return this.item; }
		set { this.item = value; }
	}
}
```
