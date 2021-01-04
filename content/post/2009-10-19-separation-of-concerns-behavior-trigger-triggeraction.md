---
date: "2009-10-19T00:00:00Z"
guid: http://www.timvw.be/?p=1482
tags:
- CSharp
- Silverlight
title: 'Separation of concerns: Behavior = Trigger + TriggerAction'
aliases:
 - /2009/10/19/separation-of-concerns-behavior-trigger-triggeraction/
 - /2009/10/19/separation-of-concerns-behavior-trigger-triggeraction.html
---
If you look at my [KeyBehavior](http://www.timvw.be/true-keybehavior-with-system-windows-interactivity-behavior/) you notice that it is doing two things: register for events so that the behavior can be triggered and handle the actual command invocation. In order to enhance reuse we can refactor this KeyBehavior in a KeyTrigger and an InvokeCommandAction. Well, we're not going to do that, because they exist already in the silverlight sdk.

A shortcoming of the InvokeCommandAction is that it can only invoke commands on the FrameworkElement itself, thus we write a custom implementation that finds commands on the DataContext instead

```csharp
public class InvokeCommandAction : TriggerAction<frameworkElement>
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
}
```

And now we can drag this action on our design surface in Blend and select a trigger that goes with it

![choosing a keypress trigger in blend](http://www.timvw.be/wp-content/images/InvokeCommandAction_ChooseTrigger.png)

All we have to do is choose the Key and Command to invoke

![setting properties for action in blend](http://www.timvw.be/wp-content/images/InvokeCommandAction_SetProperties.png)

In XAML this looks like

```xml
<interactivity:Interaction.Triggers>
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
</interactivity:Interaction.Triggers>
```

I guess this ends our exploration of the behavior features in Silverlight.
