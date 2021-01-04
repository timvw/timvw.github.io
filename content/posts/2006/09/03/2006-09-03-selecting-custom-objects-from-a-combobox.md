---
date: "2006-09-03T00:00:00Z"
tags:
- CSharp
- Windows Forms
title: Selecting custom Objects from a ComboBox
aliases:
 - /2006/09/03/selecting-custom-objects-from-a-combobox/
 - /2006/09/03/selecting-custom-objects-from-a-combobox.html
---
Earlier this week someone asked me how he could select custom objects from a [ComboBox](http://msdn2.microsoft.com/en-us/library/system.windows.forms.combobox.aspx). Here is the code he used

```csharp
private void FillComboBoxPersons(List<person> persons) 
{
	this.comboBoxPersons.Items.Clear();
	this.comboBoxPersons.Items.Add( "-- Select Person -------------" );
	foreach ( Person person in persons ) 
	{
		this.comboBoxPersons.Items.Add( person.Name );
	}
	this.comboBoxPersons.SelectedIndex = 0;
}
```

In order to get the selected item he then used the [SelectedIndex](http://msdn2.microsoft.com/en-us/library/system.windows.forms.combobox.selectedindex.aspx) property to lookup the Person in a cache of the persons collection.

Here is an approach that doesn't require you to have a cache of the collection (Since the persons are already stored in the items)

```csharp
private void FillComboBoxPersons(List<person> persons) 
{
	this.comboBoxPersons.Items.Clear();
	this.comboBoxPersons.Items.Add( "-- Select Person -------------" );
	this.comboBoxPersons.DisplayMember = "Name";
	foreach ( Person person in persons ) 
	{
		this.comboBoxPersons.Items.Add( person );
	}
	this.comboBoxPersons.SelectedIndex = 0;
}
```

Now you can easily access the selected item through the [SelectedValue](http://msdn2.microsoft.com/en-us/library/system.windows.forms.listcontrol.selectedvalue.aspx) property.
