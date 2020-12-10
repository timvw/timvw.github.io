---
title: Experimenting with ControlStateMachine and Fluent interfaces
layout: post
guid: http://www.timvw.be/?p=1157
tags:
  - 'C#'
  - Patterns
  - Windows Forms
---
A long time ago i read [Build your own CAB series](http://codebetter.com/blogs/jeremy.miller/archive/2007/07/25/the-build-your-own-cab-series-table-of-contents.aspx) and recently i noticed that there is a wiki: [Presentation Patterns Wiki!](http://www.jeremydmiller.com/ppatterns/Default.aspx?Page=MainPage&AspxAutoDetectCookieSupport=1) and it inspired me to experiment with state machines. Here are a couple of examples:

```csharp
controlStateMachine = new ControlStateMachine<states>(this);

controlStateMachine.AfterEachStateChange()
.Do(MakeRelevantButtonsVisible);

controlStateMachine.WhenStateChangesTo(States.RetrievingSubscriptionPeriod)
.TheOnlyVisibleControlsAre(flowLayoutPanel1, datePicker1);

controlStateMachine.WhenStateChangesTo(States.RetrievingCustomerInformation)
.MakeVisible(customerInput1)
.Do(() => customerInput1.Dock = DockStyle.Fill);

controlStateMachine.WhenStateChangesTo(States.Ready)
.MakeInvisible(customerInput1);
```

And here is another example:

```csharp
wizardStateMachine = new WizardStateMachine<states>(controlStateMachine);

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
```

Stay tuned for future posts where i describe the problem space that have lead to this API.
