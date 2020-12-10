---
title: ViewModel to translate domain messages to view events
layout: post
guid: http://www.timvw.be/?p=1430
tags:
  - 'C#'
  - Silverlight
  - WPF
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
