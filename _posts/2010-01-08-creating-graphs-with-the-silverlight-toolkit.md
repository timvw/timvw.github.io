---
id: 1594
title: Creating graphs with the Silverlight Toolkit
date: 2010-01-08T21:58:55+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1594
permalink: /2010/01/08/creating-graphs-with-the-silverlight-toolkit/
tags:
  - 'C#'
  - Silverlight
---
As i wrote already: In a chart the elements on the X-axis are usually numbers or dates, and the elements on the Y-axis are usually doubles. We can define such a combination as following

```csharp
public class Point<T>
{
	public T X { get; set; }
	public double Y { get; set; }
}
```

Here is a little helper function for creating line series that are used by the [Silverlight Toolkit](http://silverlight.codeplex.com/):

```csharp
public LineSeries Create<T>(string title, Series<T> series, Func<t, double> f) where T : IComparable<T>
{
	var points = series.Select(x => new Point<T> { X = x, Y = f(x) });

	var lineSeries = new LineSeries
	{
		Title = title,
		ItemsSource = points,
		IndependentValuePath = "X",
		DependentValuePath = "Y"
	};

	return lineSeries;
}
```

Given all this infrastructure we can easily draw the graph of a function:

```csharp
public MainPage()
{
	InitializeComponent();

	var series = 0.To(100);

	Func<int, double> multiplyByTwo = x => 2 * x;
	Chart1.Series.Add(Create("2x", series, multiplyByTwo));

	Func<int, double> multiplyByThree = x => 3 * x;
	Chart1.Series.Add(Create("x/2", series, multiplyByThree));
}
```

Here is how the result looks like (too much data on the chart)

![screenshot of chart in silverlight toolkit](http://www.timvw.be/wp-content/images/silverlightchart.png)