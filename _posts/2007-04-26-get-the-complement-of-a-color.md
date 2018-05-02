---
id: 164
title: Get the complement of a Color
date: 2007-04-26T20:40:13+00:00
author: timvw
layout: post
guid: http://www.timvw.be/get-the-complement-of-a-color/
permalink: /2007/04/26/get-the-complement-of-a-color/
tags:
  - 'C#'
---
Here is a simple function that returns the complement of a given Color

```csharp
public static void GetComplement(Color color)
{
	return Color.FromArgb(int.MaxValue -- color.ToArgb());
}
```
