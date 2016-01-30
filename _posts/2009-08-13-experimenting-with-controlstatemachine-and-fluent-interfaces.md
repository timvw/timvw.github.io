---
ID: 1157
post_title: >
  Experimenting with ControlStateMachine
  and Fluent interfaces
author: timvw
post_date: 2009-08-13 19:52:25
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/08/13/experimenting-with-controlstatemachine-and-fluent-interfaces/
published: true
---
<p>A long time ago i read <a href="http://codebetter.com/blogs/jeremy.miller/archive/2007/07/25/the-build-your-own-cab-series-table-of-contents.aspx">Build your own CAB series</a> and recently i noticed that there is a wiki: <a href="http://www.jeremydmiller.com/ppatterns/Default.aspx?Page=MainPage&AspxAutoDetectCookieSupport=1">Presentation Patterns Wiki!</a> and it inspired me to experiment with state machines. Here are a couple of examples:</p>

[code lang="csharp"]controlStateMachine = new ControlStateMachine<states>(this);

controlStateMachine.AfterEachStateChange()
 .Do(MakeRelevantButtonsVisible);

controlStateMachine.WhenStateChangesTo(States.RetrievingSubscriptionPeriod)
 .TheOnlyVisibleControlsAre(flowLayoutPanel1, datePicker1);

controlStateMachine.WhenStateChangesTo(States.RetrievingCustomerInformation)
 .MakeVisible(customerInput1)
 .Do(() => customerInput1.Dock = DockStyle.Fill);

controlStateMachine.WhenStateChangesTo(States.Ready)
 .MakeInvisible(customerInput1);
[/code]

<p>And here is another example:</p>

[code lang="csharp"]wizardStateMachine = new WizardStateMachine<states>(controlStateMachine);

wizardStateMachine.InState(States.RetrievingSubscriptionPeriod)
 .OnCommand(WizardCommands.Next)
  .TransitionTo(States.RetrievingCustomerInformation);

wizardStateMachine.InState(States.RetrievingCustomerInformation)
 .OnCommand(WizardCommands.Back)
  .TransitionTo(States.RetrievingSubscriptionPeriod)
 .OnCommand(WizardCommands.Finish)
  .TransitionTo(States.Ready);

wizardStateMachine.InState(States.Ready)
 .OnCommand(WizardCommands.New)
  .Do(() => MessageBox.Show("Currently not supported"));
[/code]

<p>Stay tuned for future posts where i describe the problem space that have lead to this API.</p>