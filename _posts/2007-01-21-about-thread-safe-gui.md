---
ID: 150
post_title: 'About Thread-Safe GUI&#8230;'
author: timvw
post_date: 2007-01-21 15:57:25
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/01/21/about-thread-safe-gui/
published: true
---
<p>If you're writing windows applications you'll most certainly recognize the following piece of code:</p>
[code lang="csharp"]private delegate void UpdateIntResultDelegate(int result);

private void UpdateIntResult(int result)
{
 if (this.labelIntResult.InvokeRequired)
  this.labelIntResult.Invoke(new UpdateIntResultDelegate(this.UpdateIntResult), result);
 else
  this.myDataSource.IntResult = result;
}

private delegate void UpdateStringResultDelegate(string result);

private void UpdateStringResult(string result)
{
 if (this.labelStringResult.InvokeRequired)
  this.labelStringResult.Invoke(new UpdateStringResultDelegate(this.UpdateStringResult), result);
 else
  this.myDataSource.StringResult = result;
}[/code]
<p>Today i was fed up with defining all these Delegates.. So i decided to define a generic delegate instead:</p>
[code lang="csharp"]delegate void Delegate<t>(T t);
[/code]
<p>And now i can reuse this Delegate for my two update methods:</p>
[code lang="csharp"]private void UpdateIntResult(int result)
{
 if (this.labelIntResult.InvokeRequired)
  this.labelIntResult.Invoke(new Delegate<int>(this.UpdateIntResult), result);
 else
  this.myDataSource.IntResult = result;
}

private void UpdateStringResult(string result)
{
 if (this.labelStringResult.InvokeRequired)
  this.labelStringResult.Invoke(new Delegate<string>(this.UpdateStringResult), result);
 else
  this.myDataSource.StringResult = result;
}[/code]
<p>Apparently (and not surprisingly) i'm not the first to come up with this idea, a little websearch for 'Generic Delegate' learned me that <a href="http://weblogs.asp.net/rosherove/default.aspx">Roy Osherove</a> blogged about it in: <a href="http://weblogs.asp.net/rosherove/archive/2006/03/01/439309.aspx">The 3 ways to create a Thread-Safe GUI with .NET 2.0, with one clear winner</a>. After reading the article i decided to take the following approach (The call to UpdateIntResult is type-safe, it only calls Invoke when it's required and no duplication):</p>
[code lang="csharp"]void UpdateIntResult(int result)
{
 if (this.labelIntResult.InvokeRequired)
 {
  this.labelIntResult.Invoke(new MethodInvoker(delegate { this.UpdateIntResult(result); }));
 }
 else
 {
  this.myDataSource.IntResult = result;
 }
}[/code]