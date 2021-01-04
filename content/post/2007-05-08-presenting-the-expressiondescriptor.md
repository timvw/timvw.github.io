---
date: "2007-05-08T00:00:00Z"
tags:
- CSharp
- Windows Forms
title: Presenting the ExpressionDescriptor
aliases:
 - /2007/05/08/presenting-the-expressiondescriptor/
 - /2007/05/08/presenting-the-expressiondescriptor.html
---
A couple of days ago i presented you the [TypedList](http://www.timvw.be/presenting-the-typedlistt/) which supports navigation through subproperties. Another common feature request is the possibility to add a column that has a value based on other values in the row (like a DataColumn with it's Expression property set). With the plumbing code i've written it's as simple as implementing the following interface

```csharp
public interface IExpressionProvider<componentType, PropertyType>
{
	string Name { get; }
	PropertyType GetValue(ComponentType component);
}
```

An example implementation could be an expression that represents the duration of an Appointment

```csharp
public class DurationExpressionProvider : IExpressionProvider<appointment, TimeSpan>
{
	public string Name { get { return "||Duration"; } }

	public TimeSpan GetValue(Appointment component)
	{
		return component.DateTimeRange.End -- component.DateTimeRange.Start;
	}
}
```

I've changed the constructor of TypedList a bit so that it accepts an enumeration of PropertyDescriptors. In my example you can initialise the list as following

```csharp
List<propertyDescriptor> propertyDescriptors = new List<propertyDescriptor>();

// create the subpropertydescriptors
string[] propertyNames = new string[] { "Patient.Name", "Patient.Address.Municipality", "DateTimeRange.Start", "DateTimeRange.End" };
propertyDescriptors.AddRange(Array.ConvertAll<string, SubPropertyDescriptor<appointment>>(propertyNames, delegate(string propertyName) { return new SubPropertyDescriptor<appointment>(propertyName); }));

// add an expressiondescriptor
IExpressionProvider<appointment, TimeSpan> expressionProvider = new DurationExpressionProvider();
ExpressionDescriptor<appointment, TimeSpan> durationDescriptor = new ExpressionDescriptor<appointment, TimeSpan>(expressionProvider);
propertyDescriptors.Add(durationDescriptor);

TypedBindingList<appointment> appointments = new TypedBindingList<appointment>(propertyDescriptors);
```

And this is how it looks like at runtime

![image of the typedlist](http://www.timvw.be/wp-content/images/typedlist-3.gif)

As always, feel free to download the code: [TypedList.zip](http://www.timvw.be/wp-content/code/csharp/TypedList.zip).
