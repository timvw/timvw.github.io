---
ID: 1054
post_title: >
  Using the Do handler for a method with
  out parameters
author: timvw
post_date: 2009-05-25 07:48:10
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/05/25/using-the-do-handler-for-a-method-with-out-parameters/
published: true
---
<p>As you can read in <a href="http://ayende.com/Wiki/(S(mc1hst55a1303emfc34dkmyr))/Rhino+Mocks+The+Do()+Handler.ashx">the documentation</a> for Rhino Mocks:</p>

<blockquote>There are times when the returning a static value is not good enough for the scenario that you are testing, so for those cases, you can use the Do() handler to add custom behavior when the method is called. In general, the Do() handler simply replaces the method call. Its return value will be returned from the mocked call (as well as any exception thrown). The handler's signature must match the method signature, since it gets the same parameters as the call.</blockquote>

<p>There are quite a lot of delegates defined in Rhino.Mocks.Delegates but none of them has an output parameter so we got stuck when we tried to mock a method with the following signature:</p>

[code lang="csharp"]bool TryGet(int id, out Entity entity);[/code]

<p>Luckily enough it didn't take too long before i realised we could simply define our own delegate:</p>

[code lang="csharp"]delegate bool TryGetMethod<keyType, ValueType>(KeyType key, out ValueType value);[/code]

<p>And now we can easily setup a result for our method:</p>

[code lang="csharp"]myEntityRepository
  .Stub(repository => repository.TryGet(0, out myEntity);)
  .IgnoreArguments()
  .Do((TryGetMethod<int, MyEntity>)delegate(int id, out MyEntity entity)
  {
    entity = new MyEntity();
    return id == 1;
  });
[/code]