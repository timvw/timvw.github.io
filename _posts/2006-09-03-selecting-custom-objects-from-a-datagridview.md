---
id: 16
title: Selecting custom Objects from a DataGridView
date: 2006-09-03T02:09:56+00:00
author: timvw
layout: post
guid: http://www.timvw.be/selecting-custom-objects-from-a-datagridview/
permalink: /2006/09/03/selecting-custom-objects-from-a-datagridview/
tags:
  - 'C#'
  - Windows Forms
---
Here is a way that allows the user to select a row (custom object properties are used as column values) from a [DataGridView](http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridview.aspx) assuming that the [SelectionMode](http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridview.selectionmode.aspx) property is set FullRowSelect

```csharp
private void FillDataGridViewPersons( List<person> persons ) 
{
	this.dataGridViewPersons.Rows.Clear();

	for ( int i = 0; i < persons.Count; ++i ) 
	{ 
		this.dataGridViewPersons.Rows.Add(); 
		this.dataGridViewPersons.Rows[i].Tag = persons[i]; 
		this.dataGridViewPersons.Rows[i].SetValues( new object[] { persons[i].Id, persons[i].Name } ); 
	} 
} 

private void buttonDoSomething_Click( object sender, EventArgs e ) 
{ 
	if ( this.dataGridViewPersons.SelectedRows.Count == 1 ) 
	{ 
		int selectedRowIndex = this.dataGridViewPersons.SelectedCells[0].RowIndex; 
		Person selectedPerson = (Person)this.dataGridViewPersons.Rows[selectedRowIndex].Tag; 
		MessageBox.Show( String.Format( "You selected the person with id: {0}", selectedPerson.Id ) ); 
	} 
} 
```
