---
ID: 1594
post_title: >
  Creating graphs with the Silverlight
  Toolkit
author: timvw
post_date: 2010-01-08 21:58:55
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/01/08/creating-graphs-with-the-silverlight-toolkit/
published: true
---
<p>As i wrote already: In a chart the elements on the X-axis are usually numbers or dates, and the elements on the Y-axis are usually doubles. We can define such a combination as following:</p>

[code lang="csharp"]public class Point<t>
{
 public T X { get; set; }
 public double Y { get; set; }
}[/code]

<p>Here is a little helper function for creating line series that are used by the <a href="http://silverlight.codeplex.com/">Silverlight Toolkit</a>:</p>

[code lang="csharp"]public LineSeries Create<t>(string title, Series<t> series, Func<t, double> f) where T : IComparable<t>
{
 var points = series.Select(x => new Point<t> { X = x, Y = f(x) });

 var lineSeries = new LineSeries
 {
  Title = title,
  ItemsSource = points,
  IndependentValuePath = "X",
  DependentValuePath = "Y"
 };

 return lineSeries;
}[/code]

<p>Given all this infrastructure we can easily draw the graph of a function:</p>

[code lang="csharp"]public MainPage()
{
 InitializeComponent();

 var series = 0.To(100);

 Func<int, double> multiplyByTwo = x => 2 * x;
 Chart1.Series.Add(Create("2x", series, multiplyByTwo));

 Func<int, double> multiplyByThree = x => 3 * x;
 Chart1.Series.Add(Create("x/2", series, multiplyByThree));
}[/code]

<p>Here is how the result looks like (too much data on the chart):</p>

<img src="http://www.timvw.be/wp-content/images/silverlightchart.png" alt="screenshot of chart in silverlight toolkit" />