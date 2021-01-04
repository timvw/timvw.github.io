---
date: "2010-07-21T00:00:00Z"
guid: http://www.timvw.be/?p=1833
tags:
- CSharp
title: Quick reminder about the workings of Type.IsAssignableFrom
aliases:
 - /2010/07/21/quick-reminder-about-the-workings-of-type-isassignablefrom/
 - /2010/07/21/quick-reminder-about-the-workings-of-type-isassignablefrom.html
---
Here is a quick reminder about the workings of [Type.IsAssignableFrom](http://msdn.microsoft.com/en-us/library/system.type.isassignablefrom.aspx)

```csharp
class Fruit {}
class Banana : Fruit {}

[Test]
public void CanAssignBananaToFruit()
{
	var fruit = typeof (Fruit);
	var banana = typeof (Banana);
	Assert.IsTrue(fruit.IsAssignableFrom(banana));
}

[Test]
public void CanNotAssignFruitToBanana()
{
	var fruit = typeof(Fruit);
	var banana = typeof(Banana);
	Assert.IsFalse(banana.IsAssignableFrom(fruit));
}
```

I really hate this API because it always seems backward to me. Here is how i really want to use it

```csharp
Assert.IsTrue(banana.CanBeAssignedTo(fruit));
Assert.IsFalse(fruit.CanBeAssignedTo(banana));
```

With the aid of an extension method we can easily achieve this

```csharp
public static bool CanBeAssignedTo(this Type sourceType, Type destinationType)
{
	return destinationType.IsAssignableFrom(sourceType);
}
```
