---
ID: 1313
post_title: 'Fluent Builders: More than creating context specifications'
author: timvw
post_date: 2009-10-08 08:13:14
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/10/08/fluent-builders-more-than-creating-context-specifications/
published: true
---
<p>Last couple of months i have been using the concept of (Fluent) Builder classes in order to create context specifications and i <a href="http://www.timvw.be/about-the-design-of-a-fluent-interface/
">blogged about the steps i take to design their API</a>. Lately i have realised that this concept has more uses than context specifcation only. Here is an example:</p>

<p>In sokoban a game board can be stored in plain text using the following 'protocol':</p>

<table>
<tr><th>Level element</th><th>Character</th></tr>
<tr><td>Wall</td><td>#</td></tr>
<tr><td>Player</td><td>@</td></tr>
<tr><td>Player on Goal</td><td>+</td></tr>
<tr><td>Box</td><td>$</td></tr>
<tr><td>Box on Goal</td><td>*</td></tr>
<tr><td>Goal</td><td>.</td></tr>
<tr><td>Floor</td><td>  (space)</td></tr>
</table>

<p>Notice how a Fluent Builder allows us to implement this protocol with some elegant code:</p>

[code lang="csharp"]actions.Add('#', aBoard => aBoard.AddFloor().WithWall());
actions.Add('@', aBoard => aBoard.AddFloor().WithPlayer());
actions.Add('+', aBoard => aBoard.AddGoal().WithPlayer());
actions.Add('$', aBoard => aBoard.AddFloor().WithBox());
actions.Add('*', aBoard => aBoard.AddGoal().WithBox());
actions.Add('.', aBoard => aBoard.AddGoal());
actions.Add(' ', aBoard => aBoard.AddFloor());[/code]