---
ID: 12
post_title: >
  Adding DataGridViewColumns (lots of
  them)
author: timvw
post_date: 2006-09-14 02:06:26
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/09/14/adding-datagridviewcolumns-lots-of-them/
published: true
dsq_thread_id:
  - "1920133897"
---
<p>Last couple of days i've been trying to add a couple (750+) columns into a DataGridView. Initially i tried the following:</p>

[code lang="csharp"]this.dataGridView1.ColumnCount = 750;[/code]

<p>The code above results in the following error: <b>Sum of the columns' FillWeight values cannot exceed 65535.</b> Then i tried the following:</p>

[code lang="csharp"]DataGridViewColumn[] columns = new DataGridViewColumn[750];
for ( int i = 0; i < columns.Length; ++i )
{
 DataGridViewColumn column = new DataGridViewColumn();
 column.CellTemplate = new DataGridViewTextBoxCell();
 column.FillWeight = 1;
 columns[i] = column;
}
this.dataGridView1.Columns.AddRange( columns );[/code]

<p>This results in the following error: <b>At least one of the DataGridView control's columns has no cell template.</b> Thus i tried the following:</p>

[code lang="csharp"]DataGridViewColumn[] columns = new DataGridViewColumn[750];
for ( int i = 0; i < columns.Length; ++i )
{
 DataGridViewColumn column = new DataGridViewTextBoxColumn();
 column.FillWeight = 1;
 columns[i] = column;
}
this.dataGridView1.Columns.AddRange( columns );
[/code]

<p>This code works but the AddRange call took about 15 seconds to complete. With the aid of a collegue and  <a href="http://www.aisto.com/roeder/dotnet/">Reflector</a> i set the ColumnHeadersHeightSize to DisableResizing. This reduced the calltime to less than 0.5 seconds :)</p>