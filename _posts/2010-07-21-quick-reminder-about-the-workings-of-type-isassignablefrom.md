---
id: 1833
title: Quick reminder about the workings of Type.IsAssignableFrom
date: 2010-07-21T10:55:23+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1833
permalink: /2010/07/21/quick-reminder-about-the-workings-of-type-isassignablefrom/
tags:
  - 'C#'
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
