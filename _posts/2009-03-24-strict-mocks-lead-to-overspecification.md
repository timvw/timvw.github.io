---
ID: 927
post_title: Strict mocks lead to overspecification
author: timvw
post_date: 2009-03-24 16:49:02
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/03/24/strict-mocks-lead-to-overspecification/
published: true
---
<p>Here is an example that demonstrates how strick mocks lead to overspecification. Imagine that we are creating a simple screen in a <a href="http://martinfowler.com/eaaDev/PassiveScreen.html">Passive View</a> architecture. The first feature that we implement is displaying the message "edit" when the user clicks the edit button:</p>

[code lang="csharp"][Fact] public void ShouldDisplayEditClickMessage()
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
}[/code]

<br/>

<img src="http://www.timvw.be/wp-content/images/overspecification-01.PNG" alt="screenshot of test runner with all tests passing" />

<p>And now we add the feature that displays the message "save" whenever the user clicks on the save button:</p>

[code lang="csharp"][Fact] public void ShouldDisplaySaveClickMessage()
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
}[/code]

<br/>

<img src="http://www.timvw.be/wp-content/images/overspecification-02.PNG" alt="screenshot of test runner with a failing test." />

<p>Although we implemented the feature correctly, and left the code of the first feature untouched, we notice that our ShouldDisplayEditClickMessage test fails because it is not expecting a subscription to the SaveClick event. Imho, this way of testing is a testing <b>anti-pattern</b>.</p>