---
date: "2009-10-19T00:00:00Z"
guid: http://www.timvw.be/?p=1472
tags:
- CSharp
- Silverlight
title: True KeyBehavior with System.Windows.Interactivity.Behavior
---
Yesterday i demonstrated how attached properties can be used to invoke commands on specific key presses (and releases). With the aid of System.Windows.Interactivity.Behavior we can implement a true behavior and we get an extension point to do the required cleanup.

![screenshot of Blend managing a KeyBehavior](http://www.timvw.be/wp-content/images/BlendKeyBehavior.png)

```xml
<grid>
	<interactivity:Interaction.Behaviors>
		<inf:KeyBehavior>
			<inf:KeyBehavior.DownKeyCommands>
				<inf:KeyCommandName Key="Right" CommandName="PlayerRight" />
				<inf:KeyCommandName Key="Left" CommandName="PlayerLeft" />
				<inf:KeyCommandName Key="Up" CommandName="PlayerUp" />
				<inf:KeyCommandName Key="Down" CommandName="PlayerDown" />
			</inf:KeyBehavior.DownKeyCommands>
		</inf:KeyBehavior>
	</interactivity:Interaction.Behaviors>
...
</grid>
```

The behavior implementation is the same as yesterday, only this time we thankfully override the OnAttached and OnDetaching methods

```csharp
public class KeyBehavior : Behavior<frameworkElement>
{
	public List<keyCommandName> DownKeyCommands { get; set; }
	public List<keyCommandName> UpKeyCommands { get; set; }

	public KeyBehavior()
	: base()
	{
		DownKeyCommands = new List<keyCommandName>();
		UpKeyCommands = new List<keyCommandName>();
	}

	protected override void OnAttached()
	{
		base.OnAttached();
		SubscribeToKeyEvents();
	}

	protected override void OnDetaching()
	{
		UnsubscribeFromKeyEvents();
		base.OnDetaching();
	}

	void SubscribeToKeyEvents()
	{
		AssociatedObject.KeyDown += AssociatedObject_KeyDown;
		AssociatedObject.KeyUp += AssociatedObject_KeyUp;
	}

	void UnsubscribeFromKeyEvents()
	{
		AssociatedObject.KeyDown -= AssociatedObject_KeyDown;
		AssociatedObject.KeyUp -= AssociatedObject_KeyUp;
	}
}
```
