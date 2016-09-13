---
ID: 2056
post_title: 'Exploring messaging at lower levels&#8230;'
author: timvw
post_date: 2011-02-26 15:48:38
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/02/26/exploring-messaging-at-lower-levels/
published: true
dsq_thread_id:
  - "1933325321"
---
<p>Yesterday a colleague of mine, <a href="http://neildoesdotnet.blogspot.com/">Neil Robbins</a>, asked me how a piece of code would look like if I apply the Hollywood principle on it (Don't call us, we'll cal you).</p>

<p>Let me start with setting the scene: The purpose of the code is to provide items via provider and to consume those items via a consumer.</p>

<p>Here is how my oldskool function signatures would look like:</p>

[code lang="csharp"]
class ItemProviderFactory {
 public ItemProvider Create() { .. }
}

class ItemProvider {
 public IEnumerable&lt;Item&gt; Provide() { .. }
}

class ItemConsumerFactory {
 public ItemConsumer Create() { .. }
}

class ItemConsumer {
 public void Consume(IEnumerable&lt;Item&gt; items) { .. }
}
[/code]

<p>My Hollywood style function signatures look like the following:</p>

[code lang="csharp"]
class ItemProviderFactory {
 public void WithItemProvider(Action&lt;ItemProvider&gt; action) { .. }
}

class ItemProvider {
 public void Provide(Action&lt;IEnumerable&lt;Item&gt;&gt; action) { .. }
}

class ItemConsumerFactory {
 public void WithItemConsumer(Action&lt;ItemConsumer&gt; action) { .. }
}

class ItemConsumer {
 public void Consume(IEnumerable&lt;Item&gt; items) { .. }
}
[/code]

<p>And now I am able compare the code that glues everything together:</p>

[code lang="csharp"]
void OldStyle(OldStyle.ItemProviderFactory itemProviderFactory, OldStyle.ItemConsumerFactory itemConsumerFactory) {
 var provider = itemProviderFactory.Create();
 var items = provider.Provide();
 var consumer = itemConsumerFactory.Create();
 consumer.Consume(items);
}
[/code]

[code lang="csharp"]
void HollywoodStyle(HollywoodStyle.ItemProviderFactory itemProviderFactory, HollywoodStyle.ItemConsumerFactory itemConsumerFactory) {
 itemProviderFactory.With(provider =&gt; 
  provider.Provide(items =&gt; 
    itemConsumerFactory.With(consumer 
      =&gt; consumer.Consume(items))));
}
[/code]

<p>Let me refactor this Hollywood code a bit:</p>

[code lang="csharp"]
// An itemconsumer consumes items as following:
Action&lt;HollywoodStyle.ItemConsumer, IEnumerable&lt;Item&gt;&gt; consumerAction = (consumer, items) =&gt; consumer.Consume(items);

// As soon as I have items, I want a consumer to consume them:
Action&lt;IEnumerable&lt;Item&gt;&gt; itemsAction = (items) =&gt; itemConsumerFactory.With(consumer =&gt; consumerAction(consumer, items));

// I can get items as following:
Action&lt;HollywoodStyle.ItemProvider&gt; providerAction = (provider) =&gt; provider.Provide(itemsAction);

// I can get an ItemProvider as following: 
itemProviderFactory.With(providerAction);
[/code]

<p>I think that most colleagues are quite thankful that i'm not a Hollywood star ;)</p>