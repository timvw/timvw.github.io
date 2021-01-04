---
date: "2009-03-21T00:00:00Z"
guid: http://www.timvw.be/?p=872
tags:
- CSharp
title: Getting started with Moq
---
In this article I will demonstrate the Moq API by means of a simple application that allows the user to manage a quote.

![screenshot of quote manager displaying opening screen.](http://www.timvw.be/wp-content/images/QuoteOfTheDay-01.jpg)
  

  
![screenshot of quote manager displaying edit screen.](http://www.timvw.be/wp-content/images/QuoteOfTheDay-02.jpg)

In order to prevent that we have to rewrite our application when we move to a different graphical environment such as Web Forms, Silverlight or WPF I have decided to apply the [Humble Object](http://xunitpatterns.com/Humble Object.html) pattern in the design. The implementation of the application has been based on the [Passive View pattern](http://martinfowler.com/eaaDev/PassiveScreen.html).

First we describe what should happen when the user launches the application:

  * The quote should be displayed
  * The Edit button should be visible
  * The OK button should be invisible
  * The Cancel button should be invisible
  * It should not be possible to edit the quote

Now we translate these requirements in [code](http://www.timvw.be/wp-content/code/csharp/Code-01.txt). Because it is too expensive to test with actual Windows resources I have decided to use a mock object that mimics the actual resource. This is done in the Given method which arranges the context in which we want to verify the behavior:

```csharp
this.quoteFormViewMock = new Mock<iquoteFormView>();
// The mimicked view object is available via the Object property
this.sut = new QuoteFormPresenter(this.quoteFormViewMock.Object);
```

The When method is used to invoke the behavior that we want to verify. In the situation where the user launches the application this means raising the Load event:

```csharp
this.quoteFormViewMock.Raise(view => view.Load += null, null, EventArgs.Empty);
```

We can verify that a certain method has been called as following:

```csharp
this.quoteFormViewMock.Verify(view => view.MakeEditButtonVisible(true));
```

In situations where we don’t have the exact parameters for the method that should be invoked we can use the [It](http://api.moq.me/html/FBE0FFA5.htm) class to describe those parameters:

```csharp
this.quoteFormViewMock.Verify(view => view.DisplayQuote(It.IsAny<string>()));
```

We repeat this process of defining and implementing the requirements for the other interactions we want to describe. We end up with a set of requirements that looks like this:

![screenshot of test manager](http://www.timvw.be/wp-content/images/QuoteOfTheDay-03.jpg)

In case the user clicked the Cancel button we want to verify that the updated quote is not displayed:

```csharp
this.quoteFormViewMock.Verify(view => view.DisplayQuote(It.IsAny<string>()), Times.Never());
```

In case the user clicked the OK button we have to ensure a context where an updated quote is available. This is achieved by adding the following in our Given method:

```csharp
this.quoteFormViewMock
.Setup(view => view.UpdatedQuote)
.Returns(this.updatedQuote);
```

Now we can verify that the updated quote is displayed:

```csharp
this.quoteFormViewMock.Verify(view => view.DisplayQuote(this.updatedQuote));
```

Virtually every application interacts with a database and the same is true for our application. Just like we abstracted our view, we decide to abstract our quote resource too. In case the user clicked the OK button we want to verify that the resource was instructed to update the quote.

```csharp
var quote = this.quoteFormViewMock.Object.UpdatedQuote;
this.quoteResourceMock.Verify(resource => resource.Update(quote));
```

In case the quote resource fails we would like to display an error message. To achieve this we create a new test that establishes a context where the quote resource throws an exception when it is asked to update a quote as following:

```csharp
base.Given();
base.quoteResourceMock
.Setup(resource => resource.Update(It.IsAny<string>()))
.Throws(new ApplicationException("Resource is unavailable."));
```

Sometimes we want to determine what should happen based on the parameters that are provided. In that case we can provide the Returns function a delegate:

```csharp
base.quoteResourceMock
.Setup(resource => resource.Update(It.IsAny<string>()))
.Returns<string>(quote =>
{
if (string.IsNullOrEmpty(quote)) throw new ApplicationException();
return quote.Replace("a", "b");
});
```

I think that this covers most typical usage scenarios. Feel free to download the code: [QuoteManager.zip](http://www.timvw.be/wp-content/code/csharp/QuoteManager.zip).
