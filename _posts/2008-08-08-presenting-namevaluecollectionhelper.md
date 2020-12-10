---
title: Presenting NameValueCollectionHelper
layout: post
guid: http://www.timvw.be/?p=359
tags:
  - 'C#'
---
Here are a couple functions that i find extremely useful when i'm working with a [NameValueCollection](http://msdn.microsoft.com/en-us/library/system.collections.specialized.namevaluecollection.aspx)

```csharp
public static class NameValueCollectionHelper
{
	public static void AddOrIgnoreOnDuplicateKey(NameValueCollection collection, NameValueCollection nameValuesToAdd);
	public static void AddOrReplaceOnDuplicateKey(NameValueCollection collection, NameValueCollection nameValuesToAdd);
	public static void AddOrCombineOnDuplicateKey(NameValueCollection collection, NameValueCollection nameValuesToAdd);
	public static void AddOrFailOnDuplicateKey(NameValueCollection collection, NameValueCollection nameValuesToAdd);
}
```

All these methods provide a specific scenario of the more generic Add operation

```csharp 
public static class NameValueCollectionHelper
{
	private static Dictionary<duplicateKeyBehavior, Action<nameValueCollection, NameValueCollection>> duplicateKeyBehaviors;

	static NameValueCollectionHelper()
	{
		duplicateKeyBehaviors = new Dictionary<duplicateKeyBehavior, Action<nameValueCollection, NameValueCollection>>();
		duplicateKeyBehaviors.Add(DuplicateKeyBehavior.Ignore, NameValueCollectionHelper.AddOrIgnoreOnDuplicateKey);
		duplicateKeyBehaviors.Add(DuplicateKeyBehavior.Replace, NameValueCollectionHelper.AddOrReplaceOnDuplicateKey);
		duplicateKeyBehaviors.Add(DuplicateKeyBehavior.Combine, NameValueCollectionHelper.AddOrCombineOnDuplicateKey);
		duplicateKeyBehaviors.Add(DuplicateKeyBehavior.Fail, NameValueCollectionHelper.AddOrFailOnDuplicateKey);
	}

	public static void Add(NameValueCollection collection, NameValueCollection nameValuesToAdd, DuplicateKeyBehavior duplicateKeyBehavior)
	{
		duplicateKeyBehaviors[duplicateKeyBehavior](collection, nameValuesToAdd);
	}
}
```

You should already know that the source is available at [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework).
