---
id: 14
title: Using DataGridViewComboBoxColumn with Custom Objects
date: 2006-09-10T02:08:00+00:00
author: timvw
layout: post
guid: http://www.timvw.be/using-datagridviewcomboboxcolumn-with-custom-objects/
permalink: /2006/09/10/using-datagridviewcomboboxcolumn-with-custom-objects/
dsq_thread_id:
  - 1932025671
tags:
  - 'C#'
  - Windows Forms
---
Earlier today i was playing with the [DataGridView](http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridview.aspx) control. I wanted to have a couple of [DataGridViewComboBoxColumn](http://msdn2.microsoft.com/en-us/library/xwx934x7.aspx)s in order to limit the available input options for the user. The documentation clearly mentions the following

> <div>
>   The DataGridViewComboBoxColumn will only work properly if there is a mapping between all its cell values that are populated by the DataGridView.DataSource property and the range of choices populated either by the DataSource property or the Items property. If this mapping doesn't exist, the message "An Error happened Formatting, Display" will appear when the column is in view.
> </div>

Here is sample of a custom object

```csharp
public class Slot {
	private int id;
	private DateTime dateTime;

	public Slot( int id, DateTime dateTime ) {
		this.id = id;
		this.dateTime = dateTime;
	}

	public int Id {
		get { return this.id; }
	}

	public DateTime DateTime {
		get { return this.dateTime; }
	}
}
```

And here is the workaround for a one to one mapping

```csharp
public partial class Form1 : Form 
{
	// here we'll store the value the user selected in one of the comboboxcolumns
	private Object selectedValue;

	public Form1() 
	{
		InitializeComponent();
		selectedValues = new Object[this.dataGridView1.Columns.Count];

		// create a couple of slots an add them to the comboboxcolumns
		for ( int i = 0; i < 10; ++i ) 
		{ 
			Slot slot = new Slot( i, DateTime.Now.AddDays( i ) ); 
			this.Column1.Items.Add( slot ); 
			this.Column2.Items.Add( slot ); 
		} 
		this.Column1.DisplayMember = "DateTime"; 
		this.Column2.DisplayMember = "Id"; 
	} 
	
	private void dataGridView1_CellParsing( object sender, DataGridViewCellParsingEventArgs e ) 
	{ 
		// lookup the selected value 
		e.Value = this.selectedValue; 
		e.ParsingApplied = true; 
	} 
	
	private void dataGridView1_EditingControlShowing( object sender, DataGridViewEditingControlShowingEventArgs e ) 
	{ 
		ComboBox cb = e.Control as ComboBox; 
		if ( cb != null ) 
		{ 
			cb.SelectedIndexChanged -= cb_SelectedIndexChanged; 
			cb.SelectedIndexChanged += cb_SelectedIndexChanged; 
		} 
	} 
	
	void cb_SelectedIndexChanged(object sender, EventArgs e) 
	{ 
		ComboBox comboBox = sender as ComboBox; 
		this.selectedValue = comboBox.SelectedItem; 
	} 
}
```
