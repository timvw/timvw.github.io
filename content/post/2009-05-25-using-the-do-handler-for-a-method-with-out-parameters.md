---
date: "2009-05-25T00:00:00Z"
guid: http://www.timvw.be/?p=1054
tags:
- CSharp
title: Using the Do handler for a method with out parameters
aliases:
 - /2009/05/25/using-the-do-handler-for-a-method-with-out-parameters/
 - /2009/05/25/using-the-do-handler-for-a-method-with-out-parameters.html
---
As you can read in [the documentation](http://ayende.com/Wiki/(S(mc1hst55a1303emfc34dkmyr))/Rhino+Mocks+The+Do()+Handler.ashx) for Rhino Mocks:

> There are times when the returning a static value is not good enough for the scenario that you are testing, so for those cases, you can use the Do() handler to add custom behavior when the method is called. In general, the Do() handler simply replaces the method call. Its return value will be returned from the mocked call (as well as any exception thrown). The handler's signature must match the method signature, since it gets the same parameters as the call.

There are quite a lot of delegates defined in Rhino.Mocks.Delegates but none of them has an output parameter so we got stuck when we tried to mock a method with the following signature:

```csharp
bool TryGet(int id, out Entity entity);
```

Luckily enough it didn't take too long before i realised we could simply define our own delegate:

```csharp
delegate bool TryGetMethod<keyType, ValueType>(KeyType key, out ValueType value);
```

And now we can easily setup a result for our method:

```csharp
myEntityRepository
.Stub(repository => repository.TryGet(0, out myEntity);)
.IgnoreArguments()
.Do((TryGetMethod<int, MyEntity>)delegate(int id, out MyEntity entity)
{
entity = new MyEntity();
return id == 1;
});
```
