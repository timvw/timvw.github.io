---
title: Developing a DataSource for your DataGridView
layout: post
dsq_thread_id:
  - 1933324909
tags:
  - 'C#'
  - Windows Forms
---
Imagine that you want to develop a DataSource that is capable to represent the data displayed in the following excel sheet

![screenshot of excel sheet](http://www.timvw.be/wp-content/images/dgv-ds-1.gif)

For each region the values are given. The YEAR value is defined as the sum of Q1, Q2, Q3 and Q4, eg: for EMEA this is SUM(B2:E2). The GLOBAL values are calculated as the sum of the regions for the quarter, eg: for Q1 this is SUM(B2:B5). We'll start with the easiest task: Add columns to the DGV and define the headers

![screenshot of first datagridview](http://www.timvw.be/wp-content/images/dgv-ds-2.gif)

If we look at the DGV it becomes clear that each row exists out of a Label, values for Q1 to Q4 and the sum of those values. If we translate this to code we end up with something like: [SalesRow](http://www.timvw.be/wp-content/code/csharp/SalesRow.txt)

I've implemented [INotifyPropertyChanged](http://msdn2.microsoft.com/en-us/library/system.componentmodel.inotifypropertychanged.aspx) because i want the DGV to request and display the updated Year value when one of the quarterly values changes. Configure the Columns to use these properties as DataPropertyName and add a couple of SalesRow instances to a [BindingList](http://msdn2.microsoft.com/en-us/library/ms132679.aspx) that we use as DataSource for the DGV.

```csharp
public Form1()
{
	InitializeComponent();

	this.dataGridView1.AutoGenerateColumns = false;
	this.ColumnRegion.DataPropertyName = "Label";
	this.ColumnQ1.DataPropertyName = "Q1";
	this.ColumnQ2.DataPropertyName = "Q2";
	this.ColumnQ3.DataPropertyName = "Q3";
	this.ColumnQ4.DataPropertyName = "Q4";
	this.ColumnYear.DataPropertyName = "Year";

	BindingList<salesRow> bindingList = new BindingList<salesRow>();
	bindingList.Add(new SalesRow("EMEA", new int[] { 100, 100, 100, 100 }));
	bindingList.Add(new SalesRow("LATAM", new int[] { 150, 150, 150, 150 }));
	bindingList.Add(new SalesRow("APAC", new int[] { 100, 100, 100, 100 }));
	bindingList.Add(new SalesRow("NORAM", new int[] { 150, 150, 150, 150 }));
	this.dataGridView1.DataSource = bindingList;
}
```

Notice that the Year value is nicely updated when the user changes one of the quarterly values

![screenshot of datagridview with rows for regions.](http://www.timvw.be/wp-content/images/dgv-ds-3.gif)

In order to calculate the GLOBAL values we inherit from the SalesRow class and override the implementation for the Q1, Q2, Q3, Q4 and Year properties: [GlobalSalesRow](http://www.timvw.be/wp-content/code/csharp/GlobalSalesRow.txt).

Finally we can wrap everyting in a [SalesRows](http://www.timvw.be/wp-content/code/csharp/SalesRows.txt) class to represent our Data. Hooking this code up is as easy as

```csharp
public Form1()
{
	InitializeComponent();

	this.dataGridView1.AutoGenerateColumns = false;
	this.ColumnRegion.DataPropertyName = "Label";
	this.ColumnQ1.DataPropertyName = "Q1";
	this.ColumnQ2.DataPropertyName = "Q2";
	this.ColumnQ3.DataPropertyName = "Q3";
	this.ColumnQ4.DataPropertyName = "Q4";
	this.ColumnYear.DataPropertyName = "Year";

	BindingList<salesRow> bindingList = new BindingList<salesRow>();
	bindingList.Add(new SalesRow("EMEA", new int[] { 100, 100, 100, 100 }));
	bindingList.Add(new SalesRow("LATAM", new int[] { 150, 150, 150, 150 }));
	bindingList.Add(new SalesRow("APAC", new int[] { 100, 100, 100, 100 }));
	bindingList.Add(new SalesRow("NORAM", new int[] { 150, 150, 150, 150 }));

	SalesRows salesRows = new SalesRows(bindingList);
	this.dataGridView1.DataMember = "Rows";
	this.dataGridView1.DataSource = salesRows;
}
```

And here is a screenshot of the result

![screenshot of the complete implementation at work](http://www.timvw.be/wp-content/images/dgv-ds-4.gif)

Feel free to download the complete project: [DataGridViewDataSource.zip](http://www.timvw.be/wp-content/code/csharp/DataGridViewDataSource.zip).
