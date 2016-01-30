---
ID: 1430
post_title: >
  ViewModel to translate domain messages
  to view events
author: timvw
post_date: 2009-10-13 17:18:16
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/10/13/viewmodel-to-translate-domain-messages-to-view-events/
published: true
---
<p>Here is an example of a ViewModel that translates domain messages to view events:</p>

[code lang="csharp"]class GameViewModel : INotifyPropertyChanged, IListener<boardChanged>
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
}[/code]