---
date: "2006-09-14T00:00:00Z"
tags:
- CSharp
- Windows Forms
title: Adding DataGridViewColumns (lots of them)
aliases:
 - /2006/09/14/adding-datagridviewcolumns-lots-of-them/
 - /2006/09/14/adding-datagridviewcolumns-lots-of-them.html
---
Last couple of days i've been trying to add a couple (750+) columns into a DataGridView. Initially i tried the following

```csharp
this.dataGridView1.ColumnCount = 750;
```

The code above results in the following error: **Sum of the columns' FillWeight values cannot exceed 65535.** Then i tried the following

```csharp
DataGridViewColumn[] columns = new DataGridViewColumn[750];
for ( int i = 0; i < columns.Length; ++i ) 
{ 
	DataGridViewColumn column = new DataGridViewColumn(); 
	column.CellTemplate = new DataGridViewTextBoxCell(); 
	column.FillWeight = 1; columns[i] = column; 
} 
this.dataGridView1.Columns.AddRange( columns );
``` 

This results in the following error: **At least one of the DataGridView control's columns has no cell template.** Thus i tried the following

```csharp
DataGridViewColumn[] columns = new DataGridViewColumn[750];
for ( int i = 0; i < columns.Length; ++i ) 
{ 
	DataGridViewColumn column = new DataGridViewTextBoxColumn(); 
	column.FillWeight = 1; columns[i] = column; 
} 
this.dataGridView1.Columns.AddRange( columns ); 
``` 

This code works but the AddRange call took about 15 seconds to complete. With the aid of a collegue and [Reflector](http://www.aisto.com/roeder/dotnet/) i set the ColumnHeadersHeightSize to DisableResizing. This reduced the calltime to less than 0.5 seconds 🙂
