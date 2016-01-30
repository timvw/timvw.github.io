---
ID: 1184
post_title: About the design of a fluent interface
author: timvw
post_date: 2009-08-17 14:59:43
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/08/17/about-the-design-of-a-fluent-interface/
published: true
dsq_thread_id:
  - "1925698629"
---
<p>Now that i have <a href="">presented a simple ControlStateMachine</a> i can raise the bar a little. A statemachine that handles commands. Here is how a developer should be able to initialize this machine:</p>

[code lang="csharp"]sut.WhenIn(States.Loading)
 .On(Commands.Next)
  .Do(() => Console.WriteLine("got next command while loading..."))
  .Do(() => Console.WriteLine("doing it again..."))
 .On(Commands.Previous)
  .Do(() => Console.WriteLine("got previous command while loading..."));

sut.WhenIn(States.Ready)
 .On(Commands.Previous)
  .Do(() => Console.WriteLine("got previous command while ready..."));[/code]

<p>So how should we define our methods to accomplish this initialization style? Let's begin with identifying the methods we need.</p>

<ul>
<li>WhenIn(TSTate state)</li>
<li>On(TCommand command)</li>
<li>Do(Action action)</li>
</ul>

<p>Next thing to do is analyze in which sequence these methods can be called:</p>

<table>
<tr><th style="width: 200px">From -> To</th><th style="width: 100px">WhenIn</th><th style="width: 100px">On</th><th style="width: 100px">Do</th></tr>
<tr><td>WhenIn</td><td></td><td>X</td><td></td></tr>
<tr><td>On</td><td></td><td></td><td>X</td></tr>
<tr><td>Do</td><td></td><td>X</td><td>X</td></tr>
</table>

<p>Ok, now that we have clarified the requirements a little we can start working on a solution. Let's start with defining an interface for each of the methods:</p>

[code lang="csharp"]interface IChooseState<tstate, TCommand> { Q1 WhenIn(TState state); }
interface IChooseCommand<tstate, TCommand> { Q2 On(TCommand command); }
interface IChooseAction<tstate, TCommand> { Q3 Do(Action action); }[/code]

<p>From WhenIn we need to be able to call On. Thus Q1 = IChooseCommand&lt;TState, TCommand&gt;. Q2 is also easily solved because from On we only have to be able to call Do, thus Q2 = IChooseAction&lt;TState, TCommand&gt;.</p>

<p>From Do we should be able to call both On and Do. We can do that by defining another interface which has both methods:</p>

[code lang="csharp"]interface IChooseCommandAndAction<tstate, TCommand> : IChooseCommand<tstate, TCommand>, IChooseAction<tstate, TCommand> { }[/code]

<p>Now that we have found answers for Q1, Q2 and Q3 we can define the API for initializing our StateMachine as following:</p>

[code lang="csharp"]IChooseCommand<tstate, TCommand> WhenIn(TState state);
IChooseAction<tstate, TCommand> On(TCommand command);
IChooseCommandAndAction<tstate, TCommand> Do(Action action);[/code]

<p>Now tell me about your strategy for implementing a fluent interface!</p>