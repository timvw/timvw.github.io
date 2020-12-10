---
title: Say no to primitives in your API.. and make your software more explicit
layout: post
guid: http://www.timvw.be/?p=2245
categories:
  - Uncategorized
---
A while ago I wrote some code like this:

```csharp
public interface ICanBroadcast
{ 
  public void Broadcast(string message) { ... }  
  public void Broadcast(string message, string author) { ... }
}
```
A bit later the requirements changed and from now on it was required to specify the topic:

```csharp
public interface ICanBroadcast  
{
  public void Broadcast(string message, string topic) { ... }  
  public void Broadcast(string message, string author, string topic) { ... } 
}
```

In case you were using Broadcast(string message) the compiler would rightfully inform you that no such method exists. In case you were using Broadcast(string message, string author) the compiler does not catch the error and incorrectly uses the author as topic. I can only hope that you have a suite of tests that makes you notice that something is wrong when you upgrade to my latest release. 

Let's make the difference between an Author and a Topic more explicit (to our API consumers and the compiler) by creating explicit types to represent the concepts:

```csharp 
public interface ICanBroadcast 
{  
  public void Broadcast(Message message, Topic topic) { ... } 
  public void Broadcast(Message message, Author author, Topic topic) { ... }  
} 
```

The joy of using a typed language 😉
