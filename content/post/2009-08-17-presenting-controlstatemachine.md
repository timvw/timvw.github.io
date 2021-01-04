---
date: "2009-08-17T00:00:00Z"
guid: http://www.timvw.be/?p=1170
tags:
- C#
- Windows Forms
title: Presenting ControlStateMachine
aliases:
 - /2009/08/17/presenting-controlstatemachine/
 - /2009/08/17/presenting-controlstatemachine.html
---
Here is a situation we are all familiar with: A form that only displays a certain set of controls depending on the mode or state of the application. Let me start with an example: At design time there are three buttons

![screenshot of flowlayoutpanel with three buttons: edit, save and cancel.](http://www.timvw.be/wp-content/images/controlstatemachine.design.png)

The user can look at the data and decide to edit it:

![screenshot of flowlayoutpanel with only one visible button: edit.](http://www.timvw.be/wp-content/images/controlstatemachine.display.png)

Or the user is editing the data and can decide to commit or discard her changes:

![screenshot of flowlayoutpanel with two visible buttons: save and cancel.](http://www.timvw.be/wp-content/images/controlstatemachine.edit.png)

A couple of years i ago i used to spread such display logic all over my code and it was hard to figure out which control was visible at a given point. Later on i refactored that code and encapsulated it in functions like: MakeControlsForDisplayVisible and MakeControlsForEditVisible which felt like a huge improvement. These days i have the feeling that a very simple state machine can improve the readability even better.

Ok, so how simple is simple? Currently the requirements list is pretty limited:

![screenshot of unittests for controlstatemachine](http://www.timvw.be/wp-content/images/controlstatemachine.specs.png)

Anyway, here is how i would write the code today (Yeah, for a stupid example this looks like overkill):

```csharp
private void InitializeButtonLayoutPanelMachine()
{
controlStateMachine = new ControlStateMachine<displayAndEditStates>(buttonLayoutPanel);

controlStateMachine.WhenStateChangesTo(DisplayAndEditStates.Display)
.TheOnlyVisibleControlsAre(buttonEdit);

controlStateMachine.WhenStateChangesTo(DisplayAndEditStates.Edit)
.TheOnlyVisibleControlsAre(buttonSave, buttonCancel);
}
```

As always, here is the source: [ControlStateMachine](http://www.timvw.be/wp-content/code/csharp/ControlStateMachine.cs.txt) and [WhenChangingState](http://www.timvw.be/wp-content/code/csharp/WhenChangingState.cs.txt).
