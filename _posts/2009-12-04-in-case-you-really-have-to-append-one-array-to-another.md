---
ID: 1544
post_title: >
  In case you really have to Append one
  array to another
author: timvw
post_date: 2009-12-04 08:46:32
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/12/04/in-case-you-really-have-to-append-one-array-to-another/
published: true
---
<p>Here is another problem i've seen people solve once too many: Append one array to another. STOP. Revisit the problem. Can't you simply use List&lt;T&gt; and move on to solving actual business problems? In case you really can't get rid of the arrays read the following:</p>

[code lang="csharp"]Given()
{
 source = new[] { SourceElement };
 destination = new[] { DestinationElement };
}[/code]

<br/>

[code lang="csharp"]When()
{
 source.AppendTo(ref destination);
}[/code]

<br/>

[code lang="csharp"]ThenTheDestinationShouldStillHaveTheDestinationElement()
{
 Assert.AreEqual(DestinationElement, destination[0]);
}[/code]

<br/>

[code lang="csharp"]ThenTheDestinationShouldHaveBeenExtendedWithTheSourceElement()
{
 Assert.AreEqual(SourceElement, destination[1]);
}[/code]

<p>And here is the code which satisfies the requirements:</p>

[code lang="csharp"]public static class Extensions
{
 public static void AppendTo<t>(this T[] sourceArray, ref T[] destinationArray)
 {
  var sourceLength = sourceArray.Length;
  var destinationLength = destinationArray.Length;
  var extendedLength = destinationLength + sourceLength;
  Array.Resize(ref destinationArray, extendedLength);
  Array.Copy(sourceArray, 0, destinationArray, destinationLength, sourceLength);
 }
}[/code]

<p>Perhaps it's time to start (or does it exist already, cause i can't find it) an open-source project with extension methods.</p>