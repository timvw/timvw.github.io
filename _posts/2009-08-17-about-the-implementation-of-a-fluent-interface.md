---
title: About the implementation of a fluent interface
layout: post
guid: http://www.timvw.be/?p=1218
tags:
  - 'C#'
---
Now that i have [defined my API for initialization](http://www.timvw.be/about-the-design-of-a-fluent-interface/) it is time to implement it. Inspired by the Moq.Language and Moq.Language.Flow namespaces in [Moq](http://code.google.com/p/moq/) i have decided to define my interfaces in a separate namespace: Infrastructure.StateMachineLanguage.

Ever since i have read [Clean code](http://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882) i feel the need to write classes that do one thing (and one thing only) so i came up with the following classes

* something to store commands per state, CommandsForState
* something to store actions per command, ActionsForCommand

For the implementation of the IChooseCommandAndAction interface i have decided to create a class that falls back on my classes that handle IChooseCommand and IChooseAction already

```csharp
public class CommandAndActionForState<tstate, TCommand> : IChooseCommandAndAction<tstate, TCommand>
{
	private readonly CommandsForState<tstate, TCommand> commandsForState;
	private readonly ActionsForCommand<tstate, TCommand> actionsForCommand;

	public CommandAndActionForState(CommandsForState<tstate, TCommand> commands, ActionsForCommand<tstate, TCommand> actions)
	{
		commandsForState = commands;
		actionsForCommand = actions;
	}

	public IChooseAction<tstate, TCommand> On(TCommand command)
	{
		return commandsForState.On(command);
	}

	public IChooseCommandAndAction<tstate, TCommand> Do(Action action)
	{
		return actionsForCommand.Do(action);
	}
}
```


![screenshot of files in statemachine solution.](http://www.timvw.be/wp-content/images/statemachine.solution.png)

As you can see, complex problems can have simple solutions. Feel free to download the complete solution: [StateMachine.zip](http://www.timvw.be/wp-content/code/csharp/StateMachine.zip).
