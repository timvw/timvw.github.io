---
date: "2006-12-13T00:00:00Z"
tags:
- CSharp
- Windows Forms
title: What goes up must come down...
---
What goes up must come down... So you might think that after each CellMouseDown event you recieve a CellMouseUp event... Well, here is some code that proves that isn't always true

```csharp
public partial class Form1 : Form
{
	private string lastEvent;

	public Form1()
	{
		InitializeComponent();
		this.dataGridView1.ColumnCount = 10;
		this.dataGridView1.RowCount = 10;
	}

	public string LastEvent
	{
		get { return this.lastEvent; }
		set {
			if (this.lastEvent == value)
			{
				MessageBox.Show("i've detected two " + value + " after each other");
			}
			this.lastEvent = value;
		}
	}

	private void dataGridView1_CellMouseDown(object sender, DataGridViewCellMouseEventArgs e)
	{
		LastEvent = "MouseDown";
	}

	private void dataGridView1_CellMouseUp(object sender, DataGridViewCellMouseEventArgs e)
	{
		LastEvent = "MouseUp";
	}
}
```

And with a bit of a twisted optical mouse it's pretty easy to see the following MessageBox

![MessageBox that says the MouseDownEvent was captured two times after each other](http://www.timvw.be/wp-content/images/mousedown.jpg)

After a bit of research i also found the following at [MouseEventArgs](http://msdn2.microsoft.com/en-us/library/system.windows.forms.mouseeventargs.aspx)

> <div>
>   It is possible to receive a MouseDown event without a corresponding MouseUp, if the user switches focus to another application before releasing the mouse button.
> </div>
