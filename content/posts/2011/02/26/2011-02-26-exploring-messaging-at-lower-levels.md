---
date: "2011-02-26T00:00:00Z"
guid: http://www.timvw.be/?p=2056
tags:
- C
title: Exploring messaging at lower levels...
aliases:
 - /2011/02/26/exploring-messaging-at-lower-levels/
 - /2011/02/26/exploring-messaging-at-lower-levels.html
---
Yesterday a colleague of mine, [Neil Robbins](http://neildoesdotnet.blogspot.com/), asked me how a piece of code would look like if I apply the Hollywood principle on it (Don't call us, we'll cal you).

Let me start with setting the scene: The purpose of the code is to provide items via provider and to consume those items via a consumer.

Here is how my oldskool function signatures would look like:

```csharp
class ItemProviderFactory {
  public ItemProvider Create() { .. } 
}

class ItemProvider {   
  public IEnumerable<Item> Provide() { .. } 
}

class ItemConsumerFactory { 
  public ItemConsumer Create() { .. }
}

class ItemConsumer { 
  public void Consume(IEnumerable<Item> items) { .. }
} 
```

My Hollywood style function signatures look like the following:

```csharp
class ItemProviderFactory { 
  public void WithItemProvider(Action<ItemProvider> action) { .. } 
}

class ItemProvider {
  public void Provide(Action<IEnumerable<Item>> action) { .. }
}

class ItemConsumerFactory { 
  public void WithItemConsumer(Action<ItemConsumer> action) { .. }
}

class ItemConsumer {
  public void Consume(IEnumerable<Item> items) { .. }
}
```

And now I am able compare the code that glues everything together:

```csharp
void OldStyle(OldStyle.ItemProviderFactory itemProviderFactory, OldStyle.ItemConsumerFactory itemConsumerFactory) {
  var provider = itemProviderFactory.Create();
  var items = provider.Provide();
  var consumer = itemConsumerFactory.Create(); 
  consumer.Consume(items); 
}
```

```csharp
  
void HollywoodStyle(HollywoodStyle.ItemProviderFactory itemProviderFactory, HollywoodStyle.ItemConsumerFactory itemConsumerFactory) {  
  itemProviderFactory.With(provider => 
    provider.Provide(items => itemConsumerFactory.With(consumer => 
      consumer.Consume(items))));
}
```

Let me refactor this Hollywood code a bit:

```csharp
// An itemconsumer consumes items as following:
Action<HollywoodStyle.ItemConsumer, IEnumerable<Item>> consumerAction = (consumer, items) => consumer.Consume(items);

// As soon as I have items, I want a consumer to consume them:
Action<IEnumerable<Item>> itemsAction = (items) => itemConsumerFactory.With(consumer => consumerAction(consumer, items));

// I can get items as following:
Action<HollywoodStyle.ItemProvider> providerAction = (provider) => provider.Provide(itemsAction);

// I can get an ItemProvider as following:
itemProviderFactory.With(providerAction);
```

I think that most colleagues are quite thankful that i am not a Hollywood star 😉
