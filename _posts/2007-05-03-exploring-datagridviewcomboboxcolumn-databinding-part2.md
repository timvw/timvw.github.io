---
title: Exploring DataGridViewComboBoxColumn databinding (part2)
layout: post
dsq_thread_id:
  - 1920394058
tags:
  - 'C#'
  - Windows Forms
---
A while ago i wrote about [Exploring DataGridViewComboBoxColumn databinding](http://www.timvw.be/exploring-datagridviewcomboboxcolumn-databinding/) using Business Objects. Some people asked me to give an example using DataSets...

I'll start with creating a DataSet, add two DataTables, and create a relation on PersonType.Id (int32). In the designer this looks like

![screenshot of dataset designer displaying person and persontype](http://www.timvw.be/wp-content/images/databind-dataset1.gif)

Next i create a DataSetDac that will return an instance of a Filled PersonDataSet (In real life you would probably use a TableAdapter and get the data from a database) The code is as simple as

```csharp
public static PersonsDataSet Find()
{
	PersonsDataSet personsDataSet = new PersonsDataSet();

	personsDataSet.PersonType.Rows.Add(new object[] { 0, "A geeky person" });
	personsDataSet.PersonType.Rows.Add(new object[] { 1, "A coward" });
	personsDataSet.PersonType.Rows.Add(new object[] { 2, "Feeling hot hot hot" });
	personsDataSet.PersonType.Rows.Add(new object[] { -1, "(None)" });

	personsDataSet.Person.Rows.Add(new object[] { "Timvw", 0 });
	personsDataSet.Person.Rows.Add(new object[] { "John Doe", 1 });
	personsDataSet.Person.Rows.Add(new object[] { "An Onymous", 1 });
	personsDataSet.Person.Rows.Add(new object[] { "Jenna Jameson", 2 });
	personsDataSet.Person.Rows.Add(new object[] { "Null Able", -1 });

	return personsDataSet;
}
```

And now comes the important stuff: Bind the data to the DataGridView and DataGridViewComboBoxColumn

```csharp
public Form1()
{
	InitializeComponent();

	PersonsDataSet personsDataSet = DataSetDac.Find();

	this.dataGridView1.AutoGenerateColumns = false;
	this.ColumnName.DataPropertyName = "Name";
	this.ColumnPersonTypeCode.DataPropertyName = "PersonTypeId";

	this.ColumnPersonTypeCode.DisplayMember = "Label";
	this.ColumnPersonTypeCode.ValueMember = "Id";
	this.ColumnPersonTypeCode.DataSource = personsDataSet.PersonType;

	BindingSource bindingSource = new BindingSource();
	bindingSource.DataSource = personsDataSet.Person;
	this.dataGridView1.DataSource = bindingSource;
}
```

Geeks are doomed to stay Geeks forever. When you try change a Person that is a Geek, the values in ComboBox should be limited to Geek and (None). The following code takes care of that

```csharp
void dataGridView1_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
{
	if (this.dataGridView1.CurrentCell.ColumnIndex == this.ColumnPersonTypeCode.Index)
	{
		BindingSource bindingSource = this.dataGridView1.DataSource as BindingSource;
		PersonsDataSet.PersonRow person = (bindingSource.Current as DataRowView).Row as PersonsDataSet.PersonRow;

		// this method returns the allowed persontypes for the given person
		PersonsDataSet.PersonTypeDataTable personTypeDataTable = DataSetDac.FindPersonTypes(person);

		DataGridViewComboBoxEditingControl comboBox = e.Control as DataGridViewComboBoxEditingControl;
		comboBox.DataSource = personTypeDataTable;

		comboBox.SelectionChangeCommitted -= this.comboBox_SelectionChangeCommitted;
		comboBox.SelectionChangeCommitted += this.comboBox_SelectionChangeCommitted;
	}
}

public static PersonsDataSet.PersonTypeDataTable FindPersonTypes(PersonsDataSet.PersonRow person)
{
	// by default, all persons simply have one of the available persontypecodes
	PersonsDataSet personsDataSet = Find();

	if (person.PersonTypeId.Equals(0))
	{
		// geeks are doomed to stay geeks
		personsDataSet.PersonType.Rows.RemoveAt(2);
		personsDataSet.PersonType.Rows.RemoveAt(1);
	}

	return personsDataSet.PersonType;
}

void comboBox_SelectionChangeCommitted(object sender, EventArgs e)
{
	this.dataGridView1.EndEdit();
}
```

As always, feel free to download [DataGridViewComboBoxBinding2.zip](http://www.timvw.be/wp-content/code/csharp/DataGridViewComboBoxBinding2.zip).
