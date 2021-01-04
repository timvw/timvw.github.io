---
date: "2009-03-24T00:00:00Z"
guid: http://www.timvw.be/?p=927
tags:
- CSharp
- Patterns
title: Strict mocks lead to overspecification
aliases:
 - /2009/03/24/strict-mocks-lead-to-overspecification/
 - /2009/03/24/strict-mocks-lead-to-overspecification.html
---
Here is an example that demonstrates how strick mocks lead to overspecification. Imagine that we are creating a simple screen in a [Passive View](http://martinfowler.com/eaaDev/PassiveScreen.html) architecture. The first feature that we implement is displaying the message "edit" when the user clicks the edit button

```csharp
[Fact] public void ShouldDisplayEditClickMessage()
{
	// Establish context
	MockRepository mockRepository = new MockRepository();
	IView view = mockRepository.StrictMock<iview>();
	Expect.Call(delegate { view.EditClick += null; }).IgnoreArguments();
	mockRepository.Replay(view);

	// Create sut
	Presenter sut = new Presenter(view);

	// Setup expectations
	mockRepository.BackToRecord(view, BackToRecordOptions.Expectations);
	Expect.Call(delegate { view.DisplayClickMessage("edit"); });
	mockRepository.ReplayAll();

	// Exercise
	RhinoMocksExtensions
	.GetEventRaiser(view, delegate(IView v) { v.EditClick += null; })
	.Raise(view, EventArgs.Empty);

	// Verify
	mockRepository.VerifyAll();
}
```



![screenshot of test runner with all tests passing](http://www.timvw.be/wp-content/images/overspecification-01.PNG)

And now we add the feature that displays the message "save" whenever the user clicks on the save button

```csharp
[Fact] public void ShouldDisplaySaveClickMessage()
{
	// Establish context
	MockRepository mockRepository = new MockRepository();
	IView view = mockRepository.StrictMock<iview>();
	Expect.Call(delegate { view.EditClick += null; }).IgnoreArguments();
	Expect.Call(delegate { view.SaveClick += null; }).IgnoreArguments();
	mockRepository.Replay(view);

	// Create sut
	Presenter sut = new Presenter(view);

	// Setup expectations
	mockRepository.BackToRecord(view, BackToRecordOptions.Expectations);
	Expect.Call(delegate { view.DisplayClickMessage("save"); });
	mockRepository.ReplayAll();

	// Exercise
	RhinoMocksExtensions
	.GetEventRaiser(view, delegate(IView v) { v.SaveClick += null; })
	.Raise(view, EventArgs.Empty);

	// Verify
	mockRepository.VerifyAll();
	}
}
```

![screenshot of test runner with a failing test.](http://www.timvw.be/wp-content/images/overspecification-02.PNG)

Although we implemented the feature correctly, and left the code of the first feature untouched, we notice that our ShouldDisplayEditClickMessage test fails because it is not expecting a subscription to the SaveClick event. Imho, this way of testing is a testing **anti-pattern**.
