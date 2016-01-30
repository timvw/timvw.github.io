---
ID: 1482
post_title: 'Separation of concerns: Behavior = Trigger + TriggerAction'
author: timvw
post_date: 2009-10-19 20:40:43
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/10/19/separation-of-concerns-behavior-trigger-triggeraction/
published: true
---
<p>If you look at my <a href="http://www.timvw.be/true-keybehavior-with-system-windows-interactivity-behavior/">KeyBehavior</a> you notice that it is doing two things: register for events so that the behavior can be triggered and handle the actual command invocation. In order to enhance reuse we can refactor this KeyBehavior in a KeyTrigger and an InvokeCommandAction. Well, we're not going to do that, because they exist already in the silverlight sdk ;)</p>

<p>A shortcoming of the InvokeCommandAction is that it can only invoke commands on the FrameworkElement itself, thus we write a custom implementation that finds commands on the DataContext instead:</p>

[code lang="csharp"]public class InvokeCommandAction : TriggerAction<frameworkElement>
{
 public string CommandName { get; set; }

 protected override void Invoke(object parameter)
 {
  var viewModel = AssociatedObject.DataContext;
  GetCommandAndExecuteIt(viewModel, CommandName);
 }

 void GetCommandAndExecuteIt(object viewModel, string commandName)
 {
  var command = viewModel.GetPropertyValue<icommand>(commandName);
  if(command.CanExecute(null)) command.Execute(null);
 }
}[/code]

<p>And now we can drag this action on our design surface in Blend and select a trigger that goes with it:</p>

<img src="http://www.timvw.be/wp-content/images/InvokeCommandAction_ChooseTrigger.png" alt="choosing a keypress trigger in blend" />

<p>All we have to do is choose the Key and Command to invoke:</p>

<img src="http://www.timvw.be/wp-content/images/InvokeCommandAction_SetProperties.png" alt="setting properties for action in blend" />

<p>In XAML this looks like:</p>

[code lang="xml"]<interactivity:Interaction.Triggers>
 <ii:KeyTrigger Key="Right">
  <inf:InvokeCommandAction CommandName="PlayerRight"/>
 </ii:KeyTrigger>
 <ii:KeyTrigger Key="Left">
  <inf:InvokeCommandAction CommandName="PlayerLeft"/>
 </ii:KeyTrigger>
 <ii:KeyTrigger Key="Up">
  <inf:InvokeCommandAction CommandName="PlayerUp"/>
 </ii:KeyTrigger>
 <ii:KeyTrigger Key="Down">
  <inf:InvokeCommandAction CommandName="PlayerDown"/>
 </ii:KeyTrigger>
</interactivity:Interaction.Triggers>[/code]

<p>I guess this ends our exploration of the behavior features in Silverlight.</p>