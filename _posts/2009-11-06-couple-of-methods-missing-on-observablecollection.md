---
id: 1512
title: Couple of methods missing on ObservableCollection
date: 2009-11-06T16:42:40+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1512
permalink: /2009/11/06/couple-of-methods-missing-on-observablecollection/
tags:
  - 'C#'
  - Silverlight
  - WPF
---
Here are a couple of methods that are missing on [ObservableCollection<T>](http://msdn.microsoft.com/en-us/library/ms668604.aspx)

```csharp
public static class ObservableCollectionExtensions
{
	public static void AddRange<T>(this ObservableCollection<T> observableCollection, IEnumerable<T> elements)
	{
		foreach (var element in elements) observableCollection.Add(element);
	}

	public static ObservableCollection<T> Create<T>(IEnumerable<T> elements)
	{
		var observableCollection = new ObservableCollection<T>();
		observableCollection.AddRange(elements);
		return observableCollection;
	}
}
```
