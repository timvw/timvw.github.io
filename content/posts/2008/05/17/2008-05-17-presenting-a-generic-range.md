---
date: "2008-05-17T00:00:00Z"
guid: http://www.timvw.be/?p=225
tags:
- Patterns
title: Presenting a generic Range
---
Quite often i'm writing code that compares one value against a range of other values. Most implementations compare the value against the boundaries (smallest and largest in the collection of other values). Having written this sort of code way too much i've decided to generalize the problem and distill an interface

```csharp
public interface IRange<T>
{
	T Begin { get; set; }
	T End { get; set; }
	bool Includes(T t);
	bool Includes(IRange<T> range);
	bool Overlaps(IRange<T> range);
}
```

Offcourse, i've also written implementation. Feel free to download [IRange.txt](http://www.timvw.be/wp-content/code/csharp/IRange.txt), [Range.txt](http://www.timvw.be/wp-content/code/csharp/Range.txt) and [RangeTester.txt](http://www.timvw.be/wp-content/code/csharp/RangeTester.txt)
