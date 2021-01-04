---
date: "2007-04-26T00:00:00Z"
tags:
- CSharp
title: Get the complement of a Color
aliases:
 - /2007/04/26/get-the-complement-of-a-color/
 - /2007/04/26/get-the-complement-of-a-color.html
---
Here is a simple function that returns the complement of a given Color

```csharp
public static void GetComplement(Color color)
{
	return Color.FromArgb(int.MaxValue -- color.ToArgb());
}
```
