---
date: "2009-08-28T00:00:00Z"
guid: http://www.timvw.be/?p=1234
tags:
- C#
- Patterns
title: Extension methods to improve readability
aliases:
 - /2009/08/28/extension-methods-to-improve-readability/
 - /2009/08/28/extension-methods-to-improve-readability.html
---
A common reason to take advantage of extension methods is to enhance readability (think fluent interfaces). My team uses the [specification pattern](http://en.wikipedia.org/wiki/Specification_pattern) regularly and in case a requirement says something like "if the player has reached level 10 a message should be displayed" they would implement it as

```csharp
if (new HasReachedLevel(10).IsSatisfiedBy(player))
{
	view.DisplayMessage("Congratulations! You have reached level 10.");
}
```

Pretty good but did you notice that they changed the order of player and level in their (code) story? With the aid of an extension method we can express this requirement as

```csharp
if (player.Satisfies(new HasReachedLevel(10)))
{
	view.DisplayMessage("Congratulations! You have reached level 10.");
}
```

Here is the extension method that allows you to express the requirement in this way

```csharp
public static bool Satisfies<t>(this T candidate, ISpecification<t> specification)
{
	return specification.IsSatisfiedBy(candidate);
}
```
