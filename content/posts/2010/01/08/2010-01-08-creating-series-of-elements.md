---
date: "2010-01-08T00:00:00Z"
guid: http://www.timvw.be/?p=1579
tags:
- CSharp
- Patterns
title: Creating series of elements
aliases:
 - /2010/01/08/creating-series-of-elements/
 - /2010/01/08/creating-series-of-elements.html
---
Lately i have done quite a bit of charting. Very often the X-axis is populated with a series of numbers or dates. This can be as simple as: (My very little DSL in [Jeremy D. Miller Style](http://codebetter.com/blogs/jeremy.miller/archive/2010/01/06/writing-internal-dsl-s-in-msdn.aspx))

```csharp
[Test] public void ShouldBeAbleToGetSeriesOfNumbers()
{
	// Arrange
	var series = 3.To(5);

	// Act
	var elements = series.Elements;

	// Assert
	var expected = new[] { 3, 4, 5 };
	CollectionAssert.AreEqual(expected, elements);
}

[Test] public void ShouldBeAbleToGetSeriesOfDays()
{
	// Arrange
	var now = DateTime.Now.Date;
	var twoDaysLater = now.AddDays(2);
	var series = now.To(twoDaysLater);

	// Act
	var elements = series.Elements;

	// Assert
	var expectedDays = new[] { now, now.AddDays(1), now.AddDays(2) };
	CollectionAssert.AreEqual(expectedDays, elements);
}
```

And here is the code that makes these tests pass

```csharp
public static class Series
{
	public static Series<int> To(this int from, int to)
	{
		return Create(from, to);
	}

	public static Series<dateTime> To(this DateTime from, DateTime to)
	{
		return Create(from, to);
	}

	public static Series<dateTime> Create(DateTime from, DateTime to)
	{
		return new Series<dateTime>(from.Date, to.Date, d => d.AddDays(1));
	}

	public static Series<dateTime> Create(DateTime from, int numberOfDays)
	{
		return Create(from.Date, from.Date.AddDays(numberOfDays));
	}

	public static Series<int> Create(int from, int to)
	{
		return new Series<int>(from, to, n => n + 1);
	}

	public static Series<int> Create(int from, int to, int stepSize)
	{
		return new Series<int>(from, to, n => n + stepSize);
	}
}
```

```csharp
public class Series<T> : IEnumerable<T> where T : IComparable
{
	public T From { get; private set; }
	public T To { get; private set; }
	public Func<t, T> Step { get; private set; }

	public Series(T from, T to, Func<t, T> step)
	{
		From = from;
		To = to;
		Step = step;
	}

	public IEnumerable<T> Elements
	{
		get
		{
			var current = From;
			while (current.CompareTo(To) <= 0) 
			{ 
				yield return current; current = Step(current); 
			} 
		} 
	} 
	
	public IEnumerator<T> GetEnumerator()
	{
		return Elements.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
```
