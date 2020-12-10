---
title: 'Silverlight: leveraging attached properties to handle key events'
layout: post
guid: http://www.timvw.be/?p=1457
tags:
  - 'C#'
  - Silverlight
---
I strongly believe that input handling is a responsability that belongs to the View. At first i simply added the following in the code-behind of my GameView

```csharp
protected override void OnKeyDown(KeyEventArgs e)
{
	base.OnKeyDown(e);

	if (e.Key == Key.Left) Model.MovePlayerLeft();
	...
}
```

But i wanted to play with the cool kids so i exposed ICommand properties on my ViewModel instead and rewrote the code like this

```csharp
protected override void OnKeyDown(KeyEventArgs e)
{
	base.OnKeyDown(e);

	if (e.Key == Key.Left) Model.PlayerLeft.Execute(null);
	...
```

Offcourse, designers should not have to write code at all, thus i searched for a different solution. Because there isn't a behavior that allows me to differentiate the command based on the actual key being pressed i wrote my own KeyEvents class which allows the designer to map a key to a command. Here is an example

```xml 
<grid>
	<inf:KeyEvents.Down>
		<inf:KeyCommand Key="Right" CommandName="PlayerRight" />
		<inf:KeyCommand Key="Left" CommandName="PlayerLeft" />
		<inf:KeyCommand Key="Up" CommandName="PlayerUp" />
		<inf:KeyCommand Key="Down" CommandName="PlayerDown" />
	</inf:KeyEvents.Down>
	...
</grid>
```

The down property is nothing more than an attached property:

```csharp
public static readonly DependencyProperty DownProperty = DependencyProperty.RegisterAttached("Down", typeof(List<keyCommand>), typeof(KeyEvents), new PropertyMetadata(null, OnSetDownCallback));
```

A KeyCommand is a simple pair of a Key and a Command name:

```csharp
public class KeyCommand
{
	public Key Key { get; set; }
	public string CommandName { get; set; }
}
```

The GetDown method (for the attached Down property) will instantiate a KeyBehavior class which hooks up to the element's KeyDown and KeyUp events and uses a bit of reflection to find the commands...

```csharp
public class KeyBehavior
{
	public KeyBehavior(FrameworkElement frameworkElement)
	{
		FrameworkElement = frameworkElement;
		DownKeyCommands = new List<keyCommand>();
		UpKeyCommands = new List<keyCommand>();

		frameworkElement.KeyDown += frameworkElement_KeyDown;
		frameworkElement.KeyUp += frameworkElement_KeyUp;
	}

	public FrameworkElement FrameworkElement { get; set; }
	public IList<keyCommand> DownKeyCommands { get; set; }
	public IList<keyCommand> UpKeyCommands { get; set; }

	void frameworkElement_KeyUp(object sender, KeyEventArgs e)
	{
		ExecuteCommandsForKey(e.Key, UpKeyCommands);
	}

	void frameworkElement_KeyDown(object sender, KeyEventArgs e)
	{
		ExecuteCommandsForKey(e.Key, DownKeyCommands);
	}

	void ExecuteCommandsForKey(Key key, IEnumerable<keyCommand> commands)
	{
		var commandNamesForKey = commands.Where(p => p.Key == key).Select(p => p.CommandName);
		var viewModel = FrameworkElement.DataContext;
		foreach (var command in commandNamesForKey) GetCommandAndExecuteIt(viewModel, command);
	}

	void GetCommandAndExecuteIt(object model, string name)
	{
		var command = GetCommand(model, name);
		command.Execute(null);
	}

	ICommand GetCommand(object model, string name)
	{
		return (ICommand)model.GetType().GetProperty(name).GetValue(model, null);
	}
}
```

The only thing that is missing is a way to unsubscribe from the events (and so you will end up with memory leaks). WeakReferences may come of use but i'll leave that as an exercise for the reader. Many thanks go to the [WPF Disciples](http://wpfdisciples.wordpress.com/) because they inspired me to come up with this attached properties magic.
