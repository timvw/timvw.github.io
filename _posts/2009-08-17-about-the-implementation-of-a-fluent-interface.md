---
ID: 1218
post_title: >
  About the implementation of a fluent
  interface
author: timvw
post_date: 2009-08-17 16:45:47
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/08/17/about-the-implementation-of-a-fluent-interface/
published: true
dsq_thread_id:
  - "1925695189"
---
<p>Now that i have <a href="http://www.timvw.be/about-the-design-of-a-fluent-interface/">defined my API for initialization</a> it is time to implement it. Inspired by the Moq.Language and Moq.Language.Flow namespaces in <a href="http://code.google.com/p/moq/">Moq</a> i have decided to define my interfaces in a separate namespace: Infrastructure.StateMachineLanguage.</p>

<p>Ever since i have read <a href="http://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882">Clean code</a> i feel the need to write classes that do one thing (and one thing only) so i came up with the following classes:</p>

<ul>
<li>something to store commands per state, CommandsForState</li>
<li>something to store actions per command, ActionsForCommand</li>
</ul>

<p>For the implementation of the IChooseCommandAndAction interface i have decided to create a class that falls back on my classes that handle IChooseCommand and IChooseAction already:</p>

[code lang="csharp"]public class CommandAndActionForState<tstate, TCommand> : IChooseCommandAndAction<tstate, TCommand>
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
}[/code]

<br/>

<img src="http://www.timvw.be/wp-content/images/statemachine.solution.png" alt="screenshot of files in statemachine solution." />

<p>As you can see, complex problems can have simple solutions. Feel free to download the complete solution: <a href="http://www.timvw.be/wp-content/code/csharp/StateMachine.zip">StateMachine.zip</a>.</p>