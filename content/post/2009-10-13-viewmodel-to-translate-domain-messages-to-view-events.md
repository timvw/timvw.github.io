---
date: "2009-10-13T00:00:00Z"
guid: http://www.timvw.be/?p=1430
tags:
- C#
- Silverlight
- WPF
title: ViewModel to translate domain messages to view events
aliases:
 - /2009/10/13/viewmodel-to-translate-domain-messages-to-view-events/
 - /2009/10/13/viewmodel-to-translate-domain-messages-to-view-events.html
---
Here is an example of a ViewModel that translates domain messages to view events:

```csharp
class GameViewModel : INotifyPropertyChanged, IListener<boardChanged>
{
	public event PropertyChangedEventHandler PropertyChanged = delegate { };

	public GameViewModel()
	{
		var messageBus = ServiceLocator.MessageBus;
		messageBus.Subscribe<boardChanged>(this);
	}

	void IListener<boardChanged>.Handle(BoardChanged message)
	{
		PropertyChanged("Board");
	}
}
```