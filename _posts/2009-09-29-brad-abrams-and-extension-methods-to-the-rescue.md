---
id: 1273
title: Brad Abrams and extension methods to the rescue..
date: 2009-09-29T16:32:30+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1273
permalink: /2009/09/29/brad-abrams-and-extension-methods-to-the-rescue/
dsq_thread_id:
  - 1933325141
tags:
  - 'C#'
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
