---
ID: 208
post_title: Introducing DeferredExecutionHelper
author: timvw
post_date: 2008-02-23 18:49:49
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/02/23/introducing-deferredexecutionhelper/
published: true
---
<p>Sometimes i don't want a costly function to be performed unless it's really necessary. In Patterns of Enterprise Application Architecture it's described as <a href="http://www.martinfowler.com/eaaCatalog/lazyLoad.html">Lazy Load</a>. Anyway, in order to achieve that i've written a wrapper for <a href="http://msdn2.microsoft.com/en-us/library/system.runtime.remoting.proxies.realproxy.aspx">RealProxy</a>:</p>

[code lang="csharp"]public static class DeferredExecutionHelper
{
 public static IList<tresult> GetListHelper<t, TResult>(Func<t, IList<tresult>> costlyFunction, T t)
 {
  return new Proxy<t, IList<tresult>>(costlyFunction, t).ResultProxy;
 }

 public static TResult GetHelper<t, TResult>(Func<t, TResult> costlyFunction, T t) where TResult : MarshalByRefObject
 {
  return new Proxy<t, TResult>(costlyFunction, t).ResultProxy;
 }
}[/code]

<p>Here are a couple of unittests that demonstrate how the wrapper can be used for MarshalByRefObjects:</p>

[code lang="csharp"][TestMethod]
public void GetHelperTestDeferredExecution()
{
 string expectedParameter = "x";
 Order expectedResult = new Order(1, new List<amount>(new Amount[] { new Amount(1) }));

 // DeferredExecutionHelper.GetHelper<t, TResult> where TResult : MarshalByRefObject
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
}[/code]

<p>I've also added a helper method that allows you to defer execution of methods that return an IList of T. Here are some tests that demonstrate it's usage:</p>

[code lang="csharp"][TestMethod]
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
 for (int i = 0; i < expectedResult.Count; ++i)
 {
  Assert.AreEqual(expectedResult[i], actualResult[i]);
 }
}[/code]

<p>Feel free to download <a href="http://www.timvw.be/wp-content/code/csharp/DeferredExecution.zip">DeferredExecution.zip</a></p>