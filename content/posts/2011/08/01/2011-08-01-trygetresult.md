---
date: "2011-08-01T00:00:00Z"
guid: http://www.timvw.be/?p=2186
tags:
- C
title: TryGetResult
aliases:
 - /2011/08/01/trygetresult/
 - /2011/08/01/trygetresult.html
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
