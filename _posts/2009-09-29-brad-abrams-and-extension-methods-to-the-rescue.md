---
ID: 1273
post_title: >
  Brad Abrams and extension methods to the
  rescue..
author: timvw
post_date: 2009-09-29 16:32:30
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/09/29/brad-abrams-and-extension-methods-to-the-rescue/
published: true
dsq_thread_id:
  - "1933325141"
---
<p>Currently i am implementing <a href="http://en.wikipedia.org/wiki/Sokoban">Sokoban</a> and i was pondering which methods i should add to my Cell class:</p>

<ul>
<li>bool HoldsWall</li>
<li>bool HoldsBox</li>
<li>bool HoldsPlayer</li>
</ul>

<p>Or</p>

<ul>
<li>bool HoldsPieceOfType(Type type)</li>
</ul>

<p>Which option should i choose? With the aid of extension methods (in the same namespace) i can have them both:</p>

[code lang="csharp"]namespace Sokoban.Domain
{
 public static class ExtensionMethods
 {
  public static bool HoldsBox(this Cell cell)
  {
   return cell.HoldsPieceOfType(typeof(Box));
  }

  public static bool HoldsPlayer(this Cell cell)
  {
   return cell.HoldsPieceOfType(typeof(Player));
  }

  public static bool HoldsWall(this Cell cell)
  {
   return cell.HoldsPieceOfType(typeof(Wall));
  }
 }
}[/code]

<p>In case you don't like this solution, blame <a href="http://blogs.msdn.com/brada/">Brad Abrams</a> who inspired me to implement it this way with his session at <a href="http://www.visug.be">Visug</a> yesterday.</p>

<p><b>Remark:</b> Because the possible pieces in Sokoban are very well known (the game/requirements are not going to change) thus one should choose the first option (No extension methods required.)</p>