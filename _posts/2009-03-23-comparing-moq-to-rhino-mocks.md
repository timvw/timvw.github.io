---
title: Comparing Moq to Rhino Mocks
layout: post
guid: http://www.timvw.be/?p=888
dsq_thread_id:
  - 1922218487
tags:
  - 'C#'
---
So which mocking framework should we use? Do we fall back on good old [Rhino Mocks](http://ayende.com/projects/rhino-mocks.aspx) or do we choose for the new kid on the block [Moq](http://code.google.com/p/moq/)?

From a technical point of view i would dare to say that they will be able to support the same set of features because they're both based on Castle's [DynamicProxy](http://www.castleproject.org/dynamicproxy/index.html). Rhino Mocks has the advantages that it, unlike Moq, supports the mocking of Delegates and can be used in a .Net 2.0 only environment. Whether or not we should care about these differences is a question i will leave unanswered.

From a user point of view i find the Moq API a bit cleaner because <strike>it frees me from thinking about the record-replay model</strike> and Rhino Mocks wants me to make assertions on a stub. Apart from that the differences are rather small given for the use-cases i presented in [Getting started with Moq](http://www.timvw.be/getting-started-with-moq/).

* Creating instances
  
```csharp
// Rhino  
var productDetailView = MockRepository.GenerateStub<iproductDetailView>();
```
   
vs
   
```csharp
// Moq
var productDetailViewMock = new Mock<iproductDetailView>();
```

* Setting up results

```csharp
// Rhino Mocks
productRepository
    .Stub(repository => repository.GetCategory(0)).IgnoreArguments()
    .Do((Delegates.Function<icategory, int>)(categoryId => return category;));
```
 
vs
 
```csharp
// Moq
productRepositoryMock    
    .Setup(repository => repository.GetCategory(It.IsAny<int>())) 
    .Returns<int>(categoryId => return category.Object;});
```

* Consuming the mocked objects
```csharp
// Rhino Mocks
// Nothing to do
```
  
vs
  
```csharp
// Moq  
// Nothing to do
```

* Raising events

```csharp
// Rhino Mocks
productDetailView.Raise(view => view.EditClick += null).Raise(sender, EventArgs.Empty);
```

vs

```csharp
// Moq  
productDetailViewMock.Raise(view => view.EditClick += null, sender, EventArgs.Empty);
```

* Verifying that a method was invoked

```csharp
// Rhino Mocks -- Odd that i'm asserting on a Stub.
productRepository.AssertWasCalled(    
    repository => repository.FindCategories(
    Arg<ispecification<icategory>>.Matches(Is.TypeOf(typeof(All<icategory>)))));
```
   
vs   
   
```csharp
// Moq
productRepositoryMock.Verify(    
    repository => repository.FindCategories(
		It.Is<ispecification<icategory>>(specification => specification.GetType() == typeof(All<icategory>))));
```

* Override a result 

```csharp
// Rhino Mocks  
productDetailView.BackToRecord();
    
productDetailView    
    .Stub(view => view.CategoryId)
    .Returns(2);
```
 
vs
 
```csharp
// Moq  
productDetailViewMock
    .Setup(view => view.CategoryId).Returns(2);
```

**Editted code to take advantage of the new AAA syntax that comes with Rhino Mocks 3.5 If only someone could show me how i can override a Stubbed result...**
