---
title: Improvements for the SortableBindingList (and TypedList)
layout: post
dsq_thread_id:
  - 1923258156
tags:
  - 'C#'
  - Windows Forms
---
I found out that the sorting didn't work for 'Expression' properties. My first thought was to add another switch to the logic of the already existing code

```csharp
object value1 = t1;
object value2 = t2;

if (prop.Name.StartsWith("||"))
{
	// do something to find the 'ExpressionProperty' values
}
else
{
	foreach (string property in prop.Name.Split('.'))
	{
		// navigate through the relations
		PropertyInfo propertyInfo = value1.GetType().GetProperty(property);
		value1 = propertyInfo.GetValue(value1, null);
		value2 = propertyInfo.GetValue(value2, null);
	}
}
```

Since i already have a PropertyDescriptor it seems a lot smarter to use it's GetValue instead

```csharp
object value1 = prop.GetValue(t1);
object value2 = prop.GetValue(t2);
```

At [Matthieu MEZIL](http://blog.developpez.com/index.php?blog=121&title=typedlistalt_tagt&more=1&c=1&tb=1&pb=1)'s blog i found a suggestion to use [Comparer<T>](http://msdn2.microsoft.com/en-us/library/cfttsh47(VS.80).aspx). This allowed me to reduce

```csharp
IComparable comparable = value1 as IComparable;
if (comparable != null)
{
	return reverse * comparable.CompareTo(value2);
}
else
{
	comparable = value2 as IComparable;
	if (comparable != null)
	{
		return -1 \* reverse \* comparable.CompareTo(value1);
	}
	else
	{
		return 0;
	}
}
```

with

```csharp
// Notice that this requires that atleast value1 or value2 are an instance of a type that implements IComparable
return reverse * Comparer.Default.Compare(value1, value2);
```

Feel free to get yet another version of [TypedList.zip](http://www.timvw.be/wp-content/code/csharp/TypedList.zip).
