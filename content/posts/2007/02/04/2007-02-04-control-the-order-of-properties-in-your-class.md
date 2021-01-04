---
date: "2007-02-04T00:00:00Z"
tags:
- CSharp
- Windows Forms
title: Control the order of Properties in your Class
---
Sometimes you want to manipulate the order in which properties are used for databinding. Eg: If you drag and drop an object datasource on a DataGridView you have no control in which order it binds the properties. Offcourse, you can order the columns by moving them around... Today someone asked the following

> <div>
>   I would like to have it come from the class in the order I want it. Any suggestions on how to set the display order without referencing the actual member names?
> </div>

I started with the implementation of a PropertyOrderAttribute

```csharp
[AttributeUsage(AttributeTargets.Property)]
public class PropertyOrderAttribute : Attribute
{
	private int order;

	public PropertyOrderAttribute(int order)
	{
		this.order = order;
	}

	public int Order
	{
		get { return this.order; }
	}
}
```

So the user can use this attribute to define the order in which the properties should appear as following

```csharp
class Foo
{
	private int id;
	private string name;
	private DateTime birthDay;

	public Foo(int id, string name, DateTime birthDay)
	{
		this.id = id;
		this.name = name;
		this.birthDay = birthDay;
	}

	[PropertyOrder(0)]
	public int Id
	{
		get { return id; }
		set { id = value; }
	}

	[PropertyOrder(2)]
	public string Name
	{
		get { return name; }
		set { name = value; }
	}

	[PropertyOrder(1)]
	public DateTime BirthDay
	{
		get { return birthDay; }
		set { birthDay = value; }
	}
}
```

And now i implement a generic BindingList that makes use of the PropertyOrderAttributes

```csharp
class PropertyOrderBindingList<T> : BindingList<T>, ITypedList
{
	public PropertyOrderBindingList()
	: base()
	{ }

	public PropertyDescriptorCollection GetItemProperties(PropertyDescriptor[] listAccessors)
	{
		PropertyDescriptorCollection typePropertiesCollection = TypeDescriptor.GetProperties(typeof(T));
		return typePropertiesCollection.Sort(new PropertyDescriptorComparer());
	}

	public string GetListName(PropertyDescriptor[] listAccessors)
	{
		return string.Format("A list with Properties for {0}", typeof(T).Name);
	}
}

class PropertyDescriptorComparer : IComparer
{
	public int Compare(object x, object y)
	{
		if (x == y) return 0;
		if (x == null) return 1;
		if (y == null) return -1;

		PropertyDescriptor propertyDescriptorX = x as PropertyDescriptor;
		PropertyDescriptor propertyDescriptorY = y as PropertyDescriptor;

		PropertyOrderAttribute propertyOrderAttributeX = propertyDescriptorX.Attributes[typeof(PropertyOrderAttribute)] as PropertyOrderAttribute;
		PropertyOrderAttribute propertyOrderAttributeY = propertyDescriptorY.Attributes[typeof(PropertyOrderAttribute)] as PropertyOrderAttribute;

		if (propertyOrderAttributeX == propertyOrderAttributeY) return 0;
		if (propertyOrderAttributeX == null) return 1;
		if (propertyOrderAttributeY == null) return -1;

		return propertyOrderAttributeX.Order.CompareTo(propertyOrderAttributeY.Order);
	}
}
```

With all this infrastructure it becomes as easy as

```csharp
public Form1()
{
	InitializeComponent();

	PropertyOrderBindingList<foo> fooList = new PropertyOrderBindingList<foo>();
	fooList.Add(new Foo(1, "Timvw", new DateTime(1980, 4, 30)));
	fooList.Add(new Foo(2, "Mike", new DateTime(1984, 1, 1)));
	this.dataGridView1.DataSource = fooList;
}
```
