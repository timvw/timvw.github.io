---
date: "2009-10-08T00:00:00Z"
guid: http://www.timvw.be/?p=1313
tags:
- C#
title: 'Fluent Builders: More than creating context specifications'
aliases:
 - /2009/10/08/fluent-builders-more-than-creating-context-specifications/
 - /2009/10/08/fluent-builders-more-than-creating-context-specifications.html
---
Last couple of months i have been using the concept of (Fluent) Builder classes in order to create context specifications and i [blogged about the steps i take to design their API](http://www.timvw.be/about-the-design-of-a-fluent-interface/). Lately i have realised that this concept has more uses than context specifcation only. Here is an example:

In sokoban a game board can be stored in plain text using the following 'protocol':

| Level element  | Character |
| -------------- | --------- |
| Wall           | #         |
| Player         | @         |
| Player on Goal | +         |
| Box            | $         |
| Box on Goal    | *         |
| Goal           | .         |
| Floor          | (space)   |

Notice how a Fluent Builder allows us to implement this protocol with some elegant code:

```csharp
actions.Add('#', aBoard => aBoard.AddFloor().WithWall());
actions.Add('@', aBoard => aBoard.AddFloor().WithPlayer());
actions.Add('+', aBoard => aBoard.AddGoal().WithPlayer());
actions.Add('$', aBoard => aBoard.AddFloor().WithBox());
actions.Add('*', aBoard => aBoard.AddGoal().WithBox());
actions.Add('.', aBoard => aBoard.AddGoal());
actions.Add(' ', aBoard => aBoard.AddFloor());
```
