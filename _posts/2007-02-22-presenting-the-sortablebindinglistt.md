---
title: 'Presenting the SortableBindingList&lt;T&gt;'
layout: post
dsq_thread_id:
  - 1920113687
tags:
  - 'C#'
  - Windows Forms
---
If you are databinding your custom objects (in a Bindinglist of <T>) to a DataGridView you will notice that the users can't sort the rows by clicking on the columnheaders... Unlike an unbound DataGridView, the SortCompare event is not raised. Here is a class that uses IComparer to implement a BindingList that supports Sorting:

**Please read the [follow up article](http://www.timvw.be/presenting-the-sortablebindinglistt-take-two/) to find the updated source code.**

Using this SortableBindingList is as easy as

```csharp
public Form1()
{
	InitializeComponent();

	SortableBindingList<person> persons = new SortableBindingList<person>();
	persons.Add(new Person(1, "timvw", new DateTime(1980, 04, 30)));
	persons.Add(new Person(2, "John Doe", DateTime.Now));

	this.dataGridView1.AutoGenerateColumns = false;
	this.ColumnId.DataPropertyName = "Id";
	this.ColumnName.DataPropertyName = "Name";
	this.ColumnBirthday.DataPropertyName = "Birthday";
	this.dataGridView1.DataSource = persons;
}
```
  

  
![the sortablebindinglist at work](http://www.timvw.be/wp-content/images/sortablebindinglist.gif)

Feel free to download the source and demoproject: [SortableBindingList.zip](http://www.timvw.be/wp-content/code/csharp/SortableBindingList.zip).

**Edit:** You can find the latest implementation at [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework), a project where i will keep classes that i find interesting.
