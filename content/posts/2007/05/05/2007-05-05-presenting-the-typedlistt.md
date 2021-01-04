---
date: "2007-05-05T00:00:00Z"
tags:
- CSharp
- Windows Forms
title: Presenting the TypedList<T>
---
A while ago i presented the [SortableBindingList](http://www.timvw.be/presenting-the-sortablebindinglistt/). One of the nice features you get with DataSets is that you can use relations to navigate through the data. Business Objects don't give you this functionality by default. Today i implemented a BindingList that supports navigation through relations. First i'll present you the Business Objects


![screenshot of business objects](http://www.timvw.be/wp-content/images/typedlist-1.gif) 

We would like to create an overview of the appointments using a datagridview

![screenshot of wanted ui](http://www.timvw.be/wp-content/images/typedlist-2.gif)

I drag a datagridview on the designer form, add columns, and then i set the datapropertynames as following: (Notice how i use a . to navigate the relations)

```csharp
this.dataGridView1.AutoGenerateColumns = false;
this.ColumnId.DataPropertyName = "Id";
this.ColumnPatient.DataPropertyName = "Patient.Name";
this.ColumnMunicipality.DataPropertyName = "Patient.Address.Municipality";
this.ColumnStart.DataPropertyName = "DateTimeRange.Start";
this.ColumnEnd.DataPropertyName = "DateTimeRange.End";
```

First we need to implement a method that allows us to find a PropertyInfo for the given property name

```csharp
public static PropertyInfo Resolve(string propertyName)
{
	Type t = typeof(T);
	PropertyInfo propertyInfo = null;

	string[] subPropertyNames = propertyName.Split('.');
	if (subPropertyNames.Length == 1)
	{
		// a regular property
		propertyInfo = t.GetProperty(propertyName);
	}
	else
	{
		// navigate through the subproperties
		for (int i = 0; i < subPropertyNames.Length - 1; ++i) 
		{ 
			propertyInfo = t.GetProperty(subPropertyNames[i]); 
			t = propertyInfo.PropertyType; 
		} 
	} 
	return propertyInfo; 
}
``` 

Now we are ready to implement the ITypedList.GetItemProperties method in our TypedList

```csharp
public PropertyDescriptorCollection GetItemProperties(PropertyDescriptor[] listAccessors)
{
	PropertyDescriptorCollection propertyDescriptors = new PropertyDescriptorCollection(listAccessors);

	// add the regular property descriptors T has
	foreach (PropertyDescriptor propertyDescriptor in TypeDescriptor.GetProperties(typeof(T)))
	{
		propertyDescriptors.Add(propertyDescriptor);
	}

	// add the subproperties
	foreach (string subPropertyName in this.subPropertyNames)
	{
		propertyDescriptors.Add(new SubPropertyDescriptor<t>(subPropertyName));
	}

	return propertyDescriptors;
}
```

Using this class is as simple as

```csharp
// create a TypedList that holds Appointments
TypedBindingList<appointment> appointments = new TypedBindingList<appointment>(new string[] { "Patient.Name", "Patient.Address.Municipality", "DateTimeRange.Start", "DateTimeRange.End" });

// Initialise two patients
Patient patient = new Patient(1, "Tim", new Address(1, "MyStreet", 1820, "Melsbroek"));
Patient patient2 = new Patient(2, "John", new Address(2, "His Street", 3000, "Leuven"));

// Add appointsments to the list
appointments.Add(new Appointment(1, patient, new DateTimeRange(new DateTime(2007, 5, 3, 15, 0, 0), new DateTime(2007, 5, 3, 16, 0, 0))));
appointments.Add(new Appointment(2, patient2, new DateTimeRange(new DateTime(2007, 5, 4, 15, 0, 0), new DateTime(2007, 5, 4, 16, 0, 0))));
appointments.Add(new Appointment(3, patient, new DateTimeRange(new DateTime(2007, 5, 5, 15, 0, 0), new DateTime(2007, 5, 5, 16, 0, 0))));
appointments.Add(new Appointment(4, patient, new DateTimeRange(new DateTime(2007, 5, 6, 15, 0, 0), new DateTime(2007, 5, 6, 16, 0, 0))));
appointments.Add(new Appointment(5, patient2, new DateTimeRange(new DateTime(2007, 5, 7, 15, 0, 0), new DateTime(2007, 5, 7, 16, 0, 0))));
appointments.Add(new Appointment(6, patient, new DateTimeRange(new DateTime(2007, 5, 7, 17, 0, 0), new DateTime(2007, 5, 7, 17, 15, 0))));

// Assign this list to the datagridview datasource
this.dataGridView1.DataSource = appointments;
```

Pretty cool, don't you think? As always, feel free to download the code: [TypedList.zip](http://www.timvw.be/wp-content/code/csharp/TypedList.zip)

**Edit:** Today, May 8th 2007, i discovered a but in SubPropertyDescriptor.SetValue and uploaded a newer version of the code.
