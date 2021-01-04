---
date: "2009-11-06T00:00:00Z"
guid: http://www.timvw.be/?p=1512
tags:
- C#
- Silverlight
- WPF
title: Couple of methods missing on ObservableCollection
aliases:
 - /2009/11/06/couple-of-methods-missing-on-observablecollection/
 - /2009/11/06/couple-of-methods-missing-on-observablecollection.html
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
