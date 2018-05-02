---
id: 239
title: Example implementation of a callback method for use in the Asynchronous Programming Model
date: 2008-06-28T14:00:01+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=239
permalink: /2008/06/28/example-usage-of-the-asynchronous-programming-model/
tags:
  - 'C#'
---
I always seem to forget about the mechanics of implementing a Callback method that can be used in the [Asynchronous Programming Model (APM)](http://msdn.microsoft.com/en-us/library/ms228963(VS.80).aspx). So here is a simple example in C# 3.0 using the [Func<T, TResult>](http://msdn.microsoft.com/en-us/library/bb549151.aspx) delegate

```csharp
class Program
{
	static void Main(string[] args)
	{
		Func<string, string> echoDelegate = Echo;
		IAsyncResult asyncResult = echoDelegate.BeginInvoke("some input", EchoCallback, "x");

		WaitHandle.WaitAll(new WaitHandle[] {asyncResult.AsyncWaitHandle});

		Console.Write("{0}Press any key to continue...", Environment.NewLine);
		Console.ReadKey();
	}

	static string Echo(string input)
	{
		return string.Format("Echoing {0}", input);
	}

	static void EchoCallback(object state)
	{
		IAsyncResult r = (IAsyncResult)state;
		Debug.Assert(r.AsyncState == "x");

		AsyncResult asyncResult = (AsyncResult)state;
		Func<string, string> echoDelegate = (Func<string, string>)asyncResult.AsyncDelegate;
		string echoResult = echoDelegate.EndInvoke(asyncResult);
		Debug.Assert(echoResult == "Echoing some input");

		Console.WriteLine("EchoCallback completed.");
	}
}
```
