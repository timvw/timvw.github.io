---
id: 2186
title: TryGetResult
date: 2011-08-01T11:55:18+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2186
permalink: /2011/08/01/trygetresult/
categories:
  - Uncategorized
tags:
  - C
---
I think this entry has been in the pipeline for a couple of years now and today i have decided to finally post it 😉 I got frustrated with the annoying out parameter in TryGet methods so i decided to use a different signature using TryGetResult:

```csharp
public class TryGetResult<T> 
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
```

And now your TryGet methods can have the following signature:

```csharp
public TryGetResult<Person> TryGetPersonByName(string name) 
{   
  // person is not available  
  if(name.IsInvalidPersonName()) return new TryGetResult();

  // return the person
  return new TryGetResult(new Person(name));
}
```
