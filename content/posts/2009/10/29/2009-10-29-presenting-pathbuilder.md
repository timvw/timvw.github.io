---
date: "2009-10-29T00:00:00Z"
guid: http://www.timvw.be/?p=1493
tags:
- CSharp
title: Presenting PathBuilder
---
Currently it is annoying to build a path with [Path.Combine](http://msdn.microsoft.com/en-us/library/fyy7a5kt.aspx)

```csharp
var home1 = Path.Combine(Path.Combine(Path.Combine("C", "Users"), "timvw"), "My Documents");
```

And here is how it can be:

```csharp
var home2 = PathBuilder.Combine("C", "Users", "timvw", "My Documents");
```

The implementation is pretty simple:

```csharp
public static class PathBuilder
{
	public static string Combine(params string[] parts)
	{
		return parts.Aggregate((l, r) => Path.Combine(l, r));
	}
}
```
