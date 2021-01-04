---
date: "2008-10-13T00:00:00Z"
guid: http://www.timvw.be/?p=677
tags:
- CSharp
- Visual Studio
title: Revisited the int and string ValueObject templates
---
After reading [The Compare Contract](http://blogs.msdn.com/bclteam/archive/2008/10/06/the-compare-contract-kim-hamilton.aspx) last week i realized that my [templates for int and string ValueObjects](http://www.timvw.be/presenting-templates-for-int-and-string-valueobjects) did not comply with the contract so i decided to add a unittest that reproduces the faulty behavior (and then corrected the implementation)

```csharp
[TestMethod]
public void ShouldReturnPositiveWhenComparedWithNull()
{
	$classname$ value = new $classname$("0");
	Assert.IsTrue(value.CompareTo(null) > 0);
}
```

Anyway, feel free to download the corrected [IntValueObject](http://www.timvw.be/wp-content/code/csharp/IntValueObject.zip) and [StringValueObject](http://www.timvw.be/wp-content/code/csharp/StringValueObject.zip) templates.
