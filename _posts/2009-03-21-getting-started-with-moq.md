---
ID: 872
post_title: Getting started with Moq
author: timvw
post_date: 2009-03-21 15:04:18
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/03/21/getting-started-with-moq/
published: true
---
<p>In this article I will demonstrate the Moq API by means of a simple application that allows the user to manage a quote.</p>

<img src="http://www.timvw.be/wp-content/images/QuoteOfTheDay-01.jpg" alt="screenshot of quote manager displaying opening screen."/>
<br/>
<img src="http://www.timvw.be/wp-content/images/QuoteOfTheDay-02.jpg" alt="screenshot of quote manager displaying edit screen."/>

<p>In order to prevent that we have to rewrite our application when we move to a different graphical environment such as Web Forms, Silverlight or WPF I have decided to apply the <a href="http://xunitpatterns.com/Humble Object.html">Humble Object</a> pattern in the design. The implementation of the application has been based on the <a href="http://martinfowler.com/eaaDev/PassiveScreen.html">Passive View pattern</a>.</p>

<p>First we describe what should happen when the user launches the application:</p>
<ul>
<li>The quote should be displayed</li>
<li>The Edit button should be visible</li>
<li>The OK button should be invisible</li>
<li>The Cancel button should be invisible</li>
<li>It should not be possible to edit the quote</li>
</ul>

<p>Now we translate these requirements in <a href="http://www.timvw.be/wp-content/code/csharp/Code-01.txt">code</a>. Because it is too expensive to test with actual Windows resources I have decided to use a mock object that mimics the actual resource. This is done in the Given method which arranges the context in which we want to verify the behavior:</p>

[code lang="csharp"]this.quoteFormViewMock = new Mock<iquoteFormView>();
// The mimicked view object is available via the Object property
this.sut = new QuoteFormPresenter(this.quoteFormViewMock.Object);[/code]

<p>The When method is used to invoke the behavior that we want to verify. In the situation where the user launches the application this means raising the Load event:</p>

[code lang="csharp"]this.quoteFormViewMock.Raise(view => view.Load += null, null, EventArgs.Empty);[/code]

<p>We can verify that a certain method has been called as following:</p>

[code lang="csharp"]this.quoteFormViewMock.Verify(view => view.MakeEditButtonVisible(true));[/code]

<p>In situations where we don’t have the exact parameters for the method that should be invoked we can use the <a href="http://api.moq.me/html/FBE0FFA5.htm">It</a> class to describe those parameters:</p>

[code lang="csharp"]this.quoteFormViewMock.Verify(view => view.DisplayQuote(It.IsAny<string>()));[/code]

<p>We repeat this process of defining and implementing the requirements for the other interactions we want to describe. We end up with a set of requirements that looks like this:</p>

<br/><img src="http://www.timvw.be/wp-content/images/QuoteOfTheDay-03.jpg" alt="screenshot of test manager" />

<p>In case the user clicked the Cancel button we want to verify that the updated quote is not displayed:</p>

[code lang="csharp"]this.quoteFormViewMock.Verify(view => view.DisplayQuote(It.IsAny<string>()), Times.Never());[/code]

<p>In case the user clicked the OK button we have to ensure a context where an updated quote is available. This is achieved by adding the following in our Given method:</p>

[code lang="csharp"]this.quoteFormViewMock
  .Setup(view => view.UpdatedQuote)
  .Returns(this.updatedQuote);[/code]

<p>Now we can verify that the updated quote is displayed:</p>

[code lang="csharp"]this.quoteFormViewMock.Verify(view => view.DisplayQuote(this.updatedQuote));[/code]

<p>Virtually every application interacts with a database and the same is true for our application. Just like we abstracted our view, we decide to abstract our quote resource too. In case the user clicked the OK button we want to verify that the resource was instructed to update the quote.</p>

[code lang="csharp"]var quote = this.quoteFormViewMock.Object.UpdatedQuote;
this.quoteResourceMock.Verify(resource => resource.Update(quote));[/code]

<p>In case the quote resource fails we would like to display an error message. To achieve this we create a new test that establishes a context where the quote resource throws an exception when it is asked to update a quote as following:</p>

[code lang="csharp"]base.Given();
base.quoteResourceMock
  .Setup(resource => resource.Update(It.IsAny<string>()))
  .Throws(new ApplicationException("Resource is unavailable."));[/code]

<p>Sometimes we want to determine what should happen based on the parameters that are provided. In that case we can provide the Returns function a delegate:</p>

[code lang="csharp"]base.quoteResourceMock
  .Setup(resource => resource.Update(It.IsAny<string>()))
  .Returns<string>(quote =>
  {
    if (string.IsNullOrEmpty(quote)) throw new ApplicationException();
    return quote.Replace("a", "b");
  });[/code]

<p>I think that this covers most typical usage scenarios. Feel free to download the code: <a href="http://www.timvw.be/wp-content/code/csharp/QuoteManager.zip">QuoteManager.zip</a>.</p>