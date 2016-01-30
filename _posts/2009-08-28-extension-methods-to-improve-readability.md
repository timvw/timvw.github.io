---
ID: 1234
post_title: Extension methods to improve readability
author: timvw
post_date: 2009-08-28 07:59:16
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/08/28/extension-methods-to-improve-readability/
published: true
---
<p>A common reason to take advantage of extension methods is to enhance readability (think fluent interfaces). My team uses the <a href="http://en.wikipedia.org/wiki/Specification_pattern">specification pattern</a> regularly and in case a requirement says something like "if the player has reached level 10 a message should be displayed" they would implement it as:</p>

[code lang="csharp"]if (new HasReachedLevel(10).IsSatisfiedBy(player))
{
 view.DisplayMessage("Congratulations! You have reached level 10.");
}[/code]

<p>Pretty good but did you notice that they changed the order of player and level in their (code) story? With the aid of an extension method we can express this requirement as:</p>

[code lang="csharp"]if (player.Satisfies(new HasReachedLevel(10)))
{
 view.DisplayMessage("Congratulations! You have reached level 10.");
}[/code]

<p>Here is the extension method that allows you to express the requirement in this way:</p>

[code lang="csharp"]public static bool Satisfies<t>(this T candidate, ISpecification<t> specification)
{
 return specification.IsSatisfiedBy(candidate);
}[/code]