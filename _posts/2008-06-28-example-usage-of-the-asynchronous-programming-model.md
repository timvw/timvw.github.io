---
ID: 239
post_title: >
  Example implementation of a callback
  method for use in the Asynchronous
  Programming Model
author: timvw
post_date: 2008-06-28 14:00:01
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/06/28/example-usage-of-the-asynchronous-programming-model/
published: true
---
<p>I always seem to forget about the mechanics of implementing a Callback method that can be used in the <a href="http://msdn.microsoft.com/en-us/library/ms228963(VS.80).aspx">Asynchronous Programming Model (APM)</a>. So here is a simple example in C# 3.0 using the <a href="http://msdn.microsoft.com/en-us/library/bb549151.aspx">Func&lt;T, TResult&gt;</a> delegate:</p>
[code lang="csharp"]
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
}[/code]