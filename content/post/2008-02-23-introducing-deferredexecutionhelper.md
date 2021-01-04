---
date: "2008-02-23T00:00:00Z"
tags:
- CSharp
title: Introducing DeferredExecutionHelper
aliases:
 - /2008/02/23/introducing-deferredexecutionhelper/
 - /2008/02/23/introducing-deferredexecutionhelper.html
---
Sometimes i don't want a costly function to be performed unless it's really necessary. In Patterns of Enterprise Application Architecture it's described as [Lazy Load](http://www.martinfowler.com/eaaCatalog/lazyLoad.html). Anyway, in order to achieve that i've written a wrapper for [RealProxy](http://msdn2.microsoft.com/en-us/library/system.runtime.remoting.proxies.realproxy.aspx)

```csharp
public static class DeferredExecutionHelper
{
	public static IList<Tresult> GetListHelper<T, TResult>(Func<T, IList<Tresult>> costlyFunction, T t)
	{
		return new Proxy<T, IList<Tresult>>(costlyFunction, t).ResultProxy;
	}

	public static TResult GetHelper<T, TResult>(Func<T, TResult> costlyFunction, T t) where TResult : MarshalByRefObject
	{
		return new Proxy<T, TResult>(costlyFunction, t).ResultProxy;
	}
}
```

Here are a couple of unittests that demonstrate how the wrapper can be used for MarshalByRefObjects

```csharp
[TestMethod]
public void GetHelperTestDeferredExecution()
{
	string expectedParameter = "x";
	Order expectedResult = new Order(1, new List<amount>(new Amount[] { new Amount(1) }));

	// DeferredExecutionHelper.GetHelper<T, TResult> where TResult : MarshalByRefObject
	Order actualResult = DeferredExecutionHelper.GetHelper<string, Order>(delegate(string actualParameter)
	{
		Assert.AreEqual(expectedParameter, actualParameter);
		Assert.Fail("Should not perform this method.");
		return expectedResult;
	}, expectedParameter);
}

[TestMethod]
public void GetHelperTestDeferredExecutionResult()
{
	string expectedParameter = "x";
	Order expectedResult = new Order(1, new List<amount>(new Amount[] { new Amount(1) }));

	Order actualResult = DeferredExecutionHelper.GetHelper<string, Order>(delegate(string actualParameter)
	{
		Assert.AreEqual(expectedParameter, actualParameter);
		return expectedResult;
	}, expectedParameter);

	Assert.AreEqual(expectedResult.Id, actualResult.Id);
	Assert.AreEqual(expectedResult.Amounts, actualResult.Amounts);
}
```

I've also added a helper method that allows you to defer execution of methods that return an IList of T. Here are some tests that demonstrate it's usage

```csharp
[TestMethod]
public void GetListHelperTestDeferredExecution()
{
	double expectedParameter = 1;
	IList<int> expectedResult = new List<int>(new int[] { 1, 2, 3 });

	IList<int> actualResult = DeferredExecutionHelper.GetListHelper<double, int>(delegate(double actualParameter)
	{
		Assert.AreEqual(expectedParameter, actualParameter);
		Assert.Fail("Should not perform this method.");
		return expectedResult;
	}, expectedParameter);
}

[TestMethod]
public void GetListHelperTestDeferredExecutionResult()
{
	double expectedParameter = 1;
	IList<int> expectedResult = new List<int>(new int[] { 1, 2, 3 });

	IList<int> actualResult = DeferredExecutionHelper.GetListHelper<double, int>(delegate(double actualParameter)
	{
		Assert.AreEqual(expectedParameter, actualParameter);
		return expectedResult;
	}, expectedParameter);

	Assert.AreEqual(expectedResult.Count, actualResult.Count);
	for (int i = 0; i < expectedResult.Count; ++i) { Assert.AreEqual(expectedResult[i], actualResult[i]); } 
}
``` 

Feel free to download [DeferredExecution.zip](http://www.timvw.be/wp-content/code/csharp/DeferredExecution.zip)
