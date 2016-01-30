---
ID: 2186
post_title: TryGetResult
author: timvw
post_date: 2011-08-01 11:55:18
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/08/01/trygetresult/
published: true
---
<p>I think this entry has been in the pipeline for a couple of years now and today i have decided to finally post it ;) I got frustrated with the annoying out parameter in TryGet methods so i decided to use a different signature using TryGetResult:</p>

[code lang="csharp"]
public class TryGetResult&lt;T&gt;
{
 public TryGetResult()
 {
  Success = false;
 }

 public TryGetResult(T result)
 {
  Success = true;
  Result = result;
 }

 public bool Success { get; private set; }
 public T Result { get; private set; }
}
[/code]

<p>And now your TryGet methods can have the following signature:</p>

[code lang="csharp"]
public TryGetResult&lt;Person&gt; TryGetPersonByName(string name)
{
 // person is not available
 if(name.IsInvalidPersonName()) return new TryGetResult(); 
 // return the person
 return new TryGetResult(new Person(name)); 
}
[/code]