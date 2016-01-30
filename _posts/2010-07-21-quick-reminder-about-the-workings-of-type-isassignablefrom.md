---
ID: 1833
post_title: >
  Quick reminder about the workings of
  Type.IsAssignableFrom
author: timvw
post_date: 2010-07-21 10:55:23
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/07/21/quick-reminder-about-the-workings-of-type-isassignablefrom/
published: true
---
<p>Here is a quick reminder about the workings of <a href="http://msdn.microsoft.com/en-us/library/system.type.isassignablefrom.aspx">Type.IsAssignableFrom</a>:</p>

[code lang="csharp"]class Fruit {}
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
}[/code]

<p>I really hate this API because it always seems backward to me. Here is how i really want to use it:</p>

[code lang="csharp"]Assert.IsTrue(banana.CanBeAssignedTo(fruit));
Assert.IsFalse(fruit.CanBeAssignedTo(banana));[/code]

<p>With the aid of an extension method we can easily achieve this:</p>

[code lang="csharp"]public static bool CanBeAssignedTo(this Type sourceType, Type destinationType)
{
 return destinationType.IsAssignableFrom(sourceType);
}[/code]