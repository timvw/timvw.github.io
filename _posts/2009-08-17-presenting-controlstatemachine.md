---
ID: 1170
post_title: Presenting ControlStateMachine
author: timvw
post_date: 2009-08-17 08:10:42
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/08/17/presenting-controlstatemachine/
published: true
dsq_thread_id:
  - "1926050483"
---
<p>Here is a situation we are all familiar with: A form that only displays a certain set of controls depending on the mode or state of the application. Let me start with an example: At design time there are three buttons</p>

<img src="http://www.timvw.be/wp-content/images/controlstatemachine.design.png" alt="screenshot of flowlayoutpanel with three buttons: edit, save and cancel." />

<p>The user can look at the data and decide to edit it:</p>

<img src="http://www.timvw.be/wp-content/images/controlstatemachine.display.png" alt="screenshot of flowlayoutpanel with only one visible button: edit." />

<p>Or the user is editing the data and can decide to commit or discard her changes:</p>

<img src="http://www.timvw.be/wp-content/images/controlstatemachine.edit.png" alt="screenshot of flowlayoutpanel with two visible buttons: save and cancel." />

<p>A couple of years i ago i used to spread such display logic all over my code and it was hard to figure out which control was visible at a given point. Later on i refactored that code and encapsulated it in functions like: MakeControlsForDisplayVisible and MakeControlsForEditVisible which felt like a huge improvement. These days i have the feeling that a very simple state machine can improve the readability even better.</p>

<p>Ok, so how simple is simple? Currently the requirements list is pretty limited:</p>

<img src="http://www.timvw.be/wp-content/images/controlstatemachine.specs.png" alt="screenshot of unittests for controlstatemachine" />

<p>Anyway, here is how i would write the code today (Yeah, for a stupid example this looks like overkill):</p>

[code lang="csharp"]private void InitializeButtonLayoutPanelMachine()
{
 controlStateMachine = new ControlStateMachine<displayAndEditStates>(buttonLayoutPanel);

 controlStateMachine.WhenStateChangesTo(DisplayAndEditStates.Display)
  .TheOnlyVisibleControlsAre(buttonEdit);

 controlStateMachine.WhenStateChangesTo(DisplayAndEditStates.Edit)
  .TheOnlyVisibleControlsAre(buttonSave, buttonCancel);
}[/code]

<p>As always, here is the source: <a href="http://www.timvw.be/wp-content/code/csharp/ControlStateMachine.cs.txt">ControlStateMachine</a> and <a href="http://www.timvw.be/wp-content/code/csharp/WhenChangingState.cs.txt">WhenChangingState</a>.</p>