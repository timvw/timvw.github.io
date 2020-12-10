---
title: In case you really have to Append one array to another
layout: post
guid: http://www.timvw.be/?p=1544
tags:
  - 'C#'
  - Patterns
---
Here is another problem i've seen people solve once too many: Append one array to another. STOP. Revisit the problem. Can't you simply use List<T> and move on to solving actual business problems? In case you really can't get rid of the arrays read the following

```csharp
Given()
{
	source = new[] { SourceElement };
	destination = new[] { DestinationElement };
}
```

and

```csharp
When()
{
	source.AppendTo(ref destination);
}
```

and

```csharp
ThenTheDestinationShouldStillHaveTheDestinationElement()
{
	Assert.AreEqual(DestinationElement, destination[0]);
}
```

and

```csharp
ThenTheDestinationShouldHaveBeenExtendedWithTheSourceElement()
{
	Assert.AreEqual(SourceElement, destination[1]);
}
```

And here is the code which satisfies the requirements

```csharp
public static class Extensions
{
	public static void AppendTo<t>(this T[] sourceArray, ref T[] destinationArray)
	{
		var sourceLength = sourceArray.Length;
		var destinationLength = destinationArray.Length;
		var extendedLength = destinationLength + sourceLength;
		Array.Resize(ref destinationArray, extendedLength);
		Array.Copy(sourceArray, 0, destinationArray, destinationLength, sourceLength);
	}
}
```

Perhaps it's time to start (or does it exist already, cause i can't find it) an open-source project with extension methods.
