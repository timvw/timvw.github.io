---
date: "2009-09-29T00:00:00Z"
guid: http://www.timvw.be/?p=1273
tags:
- C#
title: Brad Abrams and extension methods to the rescue..
aliases:
 - /2009/09/29/brad-abrams-and-extension-methods-to-the-rescue/
 - /2009/09/29/brad-abrams-and-extension-methods-to-the-rescue.html
---
Currently i am implementing [Sokoban](http://en.wikipedia.org/wiki/Sokoban) and i was pondering which methods i should add to my Cell class:

  * bool HoldsWall
  * bool HoldsBox
  * bool HoldsPlayer

Or

  * bool HoldsPieceOfType(Type type)

Which option should i choose? With the aid of extension methods (in the same namespace) i can have them both:

```csharp
namespace Sokoban.Domain
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
}
```

In case you don't like this solution, blame [Brad Abrams](http://blogs.msdn.com/brada/) who inspired me to implement it this way with his session at [Visug](http://www.visug.be) yesterday.

**Remark:** Because the possible pieces in Sokoban are very well known (the game/requirements are not going to change) thus one should choose the first option (No extension methods required.)
