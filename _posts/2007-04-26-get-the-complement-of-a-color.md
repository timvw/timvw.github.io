---
title: Get the complement of a Color
layout: post
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
