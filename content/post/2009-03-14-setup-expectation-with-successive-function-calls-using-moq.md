---
date: "2009-03-14T00:00:00Z"
guid: http://www.timvw.be/?p=864
tags:
- CSharp
title: Setup expectation with successive function calls using Moq
aliases:
 - /2009/03/14/setup-expectation-with-successive-function-calls-using-moq/
 - /2009/03/14/setup-expectation-with-successive-function-calls-using-moq.html
---
In the [Quickstart](http://code.google.com/p/moq/wiki/QuickStart) guide we find an example that shows us how to setup a different return value for each invocation as following

```csharp
// returning different values on each invocation
var mock = new Mock<ifoo>();
var calls = 0;
mock.Setup(foo => foo.Execute("ping"))
	.Returns(() => calls)
	.Callback(() => calls++);
// returns 0 on first invocation, 1 on the next, and so on
Console.WriteLine(mock.Object.Execute("ping"));
```

In [Moq Triqs -- Successive Expectations](http://www.madprops.org/blog/moq-triqs-successive-expectations/) i found inspiration to implement an extension method that allows me to define an expectation that calls a set of successive functions

```csharp
public static class MoqExtensions
{
	public static IReturnsResult<tmock> ReturnsInOrder<tmock, TResult>(this ISetup<tmock, TResult> setup, params Func<tresult>[] valueFunctions) where TMock : class
	{
		var functionQueue = new Queue<func<tresult>>(valueFunctions);
		return setup.Returns(() => functionQueue.Dequeue()());
	}
}
```

This allows me to define a set of functions that i want to be called for each successive call

```csharp
public class WhenSettingUpOrderedExpectationFunctions
{
	interface ICategory { int Id { get; } }

	[Fact]
	public void ShouldReturnTheSequenceOfIds()
	{
		var category = new Mock<icategory>();

		category.Setup(c => c.Id).ReturnsInOrder(
			() => 1,
			() => 2,
			() => 3,
			() => 4);

		var expectedIds = new List<int> { 1, 2, 3, 4 };
		foreach (var expectedId in expectedIds) Assert.Equal(expectedId, category.Object.Id);
	}
}
```
