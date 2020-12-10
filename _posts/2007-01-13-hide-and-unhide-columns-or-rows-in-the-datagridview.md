---
title: Hide and unhide columns (or rows) in the DataGridView
layout: post
dsq_thread_id:
  - 1921455794
tags:
  - 'C#'
  - Windows Forms
---
Once in a while i see the following question

> <div>
>   I have to create a customized datagridview to enable the expandable columns. Expandable column in the sense drilling down the columns.... One column can hide multiple columns. The user can see the child columns by clicking the + button before the column name
> </div>

Using the Visibile property of the DataGridViewColumn makes this a no-brainer. Let's take the [Databound DataGridView](http://www.timvw.be/developing-a-datasource-for-your-datagridview/) and implement functionality to hide/unhide the quarterly results. All you have to do is add a DataGridViewButtonColumn and handle the DataGridView CellClick event as following

```csharp
private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
{
	if (e.ColumnIndex == this.ColumnButton.Index)
	{
		bool visible = !this.ColumnQ1.Visible;
		this.ColumnQ1.Visible = visible;
		this.ColumnQ2.Visible = visible;
		this.ColumnQ3.Visible = visible;
		this.ColumnQ4.Visible = visible;
		this.ColumnButton.HeaderText = visible ? "-" : "+";
	}
}
```

This is how it looks like

![screenshot of datagridview hiding columns](http://www.timvw.be/wp-content/images/datagridview-hide.gif)
  
![screenshot of datagridview unhiding columns](http://www.timvw.be/wp-content/images/datagridview-unhide.gif)

Feel free to download the updated source code for [DataGridViewDataSource.zip](http://www.timvw.be/wp-content/code/csharp/DataGridViewDataSource.zip).
