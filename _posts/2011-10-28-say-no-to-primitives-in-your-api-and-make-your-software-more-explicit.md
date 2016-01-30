---
ID: 2245
post_title: >
  Say no to primitives in your API.. and
  make your software more explicit
author: timvw
post_date: 2011-10-28 10:51:52
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/10/28/say-no-to-primitives-in-your-api-and-make-your-software-more-explicit/
published: true
dsq_thread_id:
  - "1933324692"
---
<p>A while ago I wrote some code like this:</p>

[code lang="csharp"]
public interface ICanBroadcast
{
 public void Broadcast(string message) { ... }
 public void Broadcast(string message, string author) { ... }
}
[/code]

<p>A bit later the requirements changed and from now on it was required to specify the topic:</p>

[code lang="csharp"]
public interface ICanBroadcast
{
 public void Broadcast(string message, string topic) { ... }
 public void Broadcast(string message, string author, string topic) { ... }
}
[/code]

<p>In case you were using Broadcast(string message) the compiler would rightfully inform you that no such method exists. In case you were using Broadcast(string message, string author) the compiler does not catch the error and incorrectly uses the author as topic. I can only hope that you have a suite of tests that makes you notice that something is wrong when you upgrade to my latest release.<p/>

<p>Let's make the difference between an Author and a Topic more explicit (to our API consumers and the compiler) by creating explicit types to represent the concepts:</p>

[code lang="csharp"]
public interface ICanBroadcast
{
 public void Broadcast(Message message, Topic topic) { ... }
 public void Broadcast(Message message, Author author, Topic topic) { ... }
}
[/code]

<p>The joy of using a typed language ;)</p>