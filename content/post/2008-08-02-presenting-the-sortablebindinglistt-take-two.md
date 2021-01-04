---
date: "2008-08-02T00:00:00Z"
guid: http://www.timvw.be/?p=314
tags:
- CSharp
title: Presenting the SortableBindingList<T> (take two)
aliases:
 - /2008/08/02/presenting-the-sortablebindinglistt-take-two/
 - /2008/08/02/presenting-the-sortablebindinglistt-take-two.html
---
I'm in the progress of adding classes that i find interesting to the [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework) project. The original implementation of my [SortableBindingList<T>](http://www.timvw.be/presenting-the-sortablebindinglistt/) relied on [IComparable](http://msdn.microsoft.com/en-us/library/system.icomparable.aspx) to implement ApplySortCore(PropertyDescriptor property, ListSortDirection direction). I received some good feedback and [blogged about those improvements](http://www.timvw.be/improvements-for-the-sortablebindinglist-and-typedlist/).

Because some of my classes only implement [IComparable<T>](http://msdn.microsoft.com/en-us/library/4d7sx9hd.aspx) i needed support for this too. My first thought was to use Comparer<T>

```csharp
IComparer comparer = Comparer<t>.Default;
itemsList.Sort(delegate(T t1, T t2)
{
	object property1 = prop.GetValue(t1);
	object property2 = prop.GetValue(t2);
	return reverse * comparer.Compare(property1, property2);
});
```

Obviously that didn't work. The problem is that i received the default Comparer for T, instead of the Comparer for the type of the property. Anyway, with a bit of reflection i got access to that Comparer

```csharp
Type comparablePropertyType = typeof(Comparer<>).MakeGenericType(property.PropertyType);
IComparer comparer = (IComparer)comparablePropertyType.InvokeMember("Default", BindingFlags.Static | BindingFlags.GetProperty | BindingFlags.Public, null, null, null);
```

After a bit of refactoring i ended up with a PropertyComparer<T> which allowed me to implement the sorting as following

```csharp
Type propertyType = property.PropertyType;

// this cache minimizes the cost of reflection in the PropertyComparer constructor
PropertyComparer<t> comparer;
if (!this.comparers.TryGetValue(propertyType, out comparer))
{
	comparer = new PropertyComparer<t>(property, direction);
	this.comparers.Add(propertyType, comparer);
}
else
{
	comparer.SetListSortDirection(direction);
}

itemsList.Sort(comparer);
```

In order to write unittests, i needed a way to get instances of a [PropertyDescriptor](http://msdn.microsoft.com/en-us/library/system.componentmodel.propertydescriptor.aspx). This was achieved by using the [TypeDescriptor](http://msdn.microsoft.com/en-us/library/system.componentmodel.typedescriptor_methods.aspx) as following

```csharp
PropertyDescriptor GetPropertyDescriptor(object component, string propertyName)
{
	PropertyDescriptorCollection propertyDescriptors = TypeDescriptor.GetProperties(component);
	foreach (PropertyDescriptor propertyDescriptor in propertyDescriptors)
	{
		if (propertyDescriptor.Name == propertyName)
		{
			return propertyDescriptor;
		}
	}
	throw new ArgumentException(string.Format("The property '{0}' was not found.", propertyName));
}
```

Feel free to download the updated demo application: [sortablebindinglist.zip](http://www.timvw.be/wp-content/code/csharp/SortableBindingList.zip). There are even real applications that use this class, eg: [VSTrac](http://vstrac.devjavu.com/) and [MonoTorrent](http://monotorrent.com/). If you're interested in the unittests you'll have to get the code at [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework).
