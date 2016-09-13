---
ID: 1579
post_title: Creating series of elements
author: timvw
post_date: 2010-01-08 21:02:23
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/01/08/creating-series-of-elements/
published: true
---
<p>Lately i have done quite a bit of charting. Very often the X-axis is populated with a series of numbers or dates. This can be as simple as: (My very little DSL in <a href="http://codebetter.com/blogs/jeremy.miller/archive/2010/01/06/writing-internal-dsl-s-in-msdn.aspx">Jeremy D. Miller Style</a>)</p>

[code lang="csharp"][Test] public void ShouldBeAbleToGetSeriesOfNumbers()
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
}[/code]

<p>And here is the code that makes these tests pass:</p>

[code lang="csharp"]public static class Series
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
}[/code]

<br/>
[code lang="csharp"]public class Series<t> : IEnumerable<t> where T : IComparable
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

 public IEnumerable<t> Elements
 {
  get
  {
   var current = From;
   while (current.CompareTo(To) <= 0)
   {
    yield return current;
    current = Step(current);
   }
  }
 }

 public IEnumerator<t> GetEnumerator()
 {
  return Elements.GetEnumerator();
 }

 IEnumerator IEnumerable.GetEnumerator()
 {
  return GetEnumerator();
 }
}[/code]