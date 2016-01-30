---
ID: 888
post_title: Comparing Moq to Rhino Mocks
author: timvw
post_date: 2009-03-23 17:51:31
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/03/23/comparing-moq-to-rhino-mocks/
published: true
dsq_thread_id:
  - "1922218487"
---
<p>So which mocking framework should we use? Do we fall back on good old <a href="http://ayende.com/projects/rhino-mocks.aspx">Rhino Mocks</a> or do we choose for the new kid on the block <a href="http://code.google.com/p/moq/">Moq</a>?</p>

<p>From a technical point of view i would dare to say that they will be able to support the same set of features because they're both based on Castle's <a href="http://www.castleproject.org/dynamicproxy/index.html">DynamicProxy</a>. Rhino Mocks has the advantages that it, unlike Moq, supports the mocking of Delegates and can be used in a .Net 2.0 only environment. Whether or not we should care about these differences is a question i will leave unanswered.</p>

<p>From a user point of view i find the Moq API a bit cleaner because <strike>it frees me from thinking about the record-replay model</strike> and Rhino Mocks wants me to make assertions on a stub. Apart from that the differences are rather small given for the use-cases i presented in <a href="http://www.timvw.be/getting-started-with-moq/">Getting started with Moq</a>.</p>

<ul>

<li>Creating instances:

[code lang="csharp"]// Rhino
var productDetailView = MockRepository.GenerateStub<iproductDetailView>();[/code]

<br/>

[code lang="csharp"]// Moq
var productDetailViewMock = new Mock<iproductDetailView>();[/code]

</li>

<li>Setting up results:

[code lang="csharp"]// Rhino Mocks
productRepository
  .Stub(repository => repository.GetCategory(0)).IgnoreArguments()
  .Do((Delegates.Function<icategory, int>)(categoryId => return category;));[/code]

<br/>

[code lang="csharp"]// Moq
productRepositoryMock
  .Setup(repository => repository.GetCategory(It.IsAny<int>()))
  .Returns<int>(categoryId => return category.Object;});[/code]

</li>

<li>Consuming the mocked objects:

[code lang="csharp"]// Rhino Mocks
// Nothing to do[/code]

<br/>

[code lang="csharp"]// Moq
// Nothing to do[/code]

</li>

<li>Raising events:

[code lang="csharp"]// Rhino Mocks
productDetailView.Raise(view => view.EditClick += null).Raise(sender, EventArgs.Empty);[/code]

<br/>

[code lang="csharp"]// Moq
productDetailViewMock.Raise(view => view.EditClick += null, sender, EventArgs.Empty);[/code]

</li>

<li>Verifying that a method was invoked:

[code lang="csharp"]// Rhino Mocks - Odd that i'm asserting on a Stub.
productRepository.AssertWasCalled(
  repository => repository.FindCategories(
    Arg<ispecification<icategory>>.Matches(Is.TypeOf(typeof(All<icategory>)))));[/code]

<br/>

[code lang="csharp"]// Moq
productRepositoryMock.Verify(
  repository => repository.FindCategories(
    It.Is<ispecification<icategory>>(specification => specification.GetType() == typeof(All<icategory>))));[/code]

</li>

<li>Override a result

[code lang="csharp"]// Rhino Mocks
productDetailView.BackToRecord();

productDetailView
  .Stub(view => view.CategoryId)
  .Returns(2);[/code]

<br/>

[code lang="csharp"]// Moq
productDetailViewMock
  .Setup(view => view.CategoryId).Returns(2);[/code]

</li>

</ul>

<p><b>Editted code to take advantage of the new AAA syntax that comes with Rhino Mocks 3.5 If only someone could show me how i can override a Stubbed result...</b></p>