---
ID: 146
post_title: >
  Hide and unhide columns (or rows) in the
  DataGridView
author: timvw
post_date: 2007-01-13 03:00:23
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/01/13/hide-and-unhide-columns-or-rows-in-the-datagridview/
published: true
dsq_thread_id:
  - "1921455794"
---
<p>Once in a while i see the following question:</p>

<blockquote>
<div>
I have to create a customized datagridview to enable the expandable columns. Expandable column in the sense drilling down the columns.... One column can hide multiple columns. The user can see the child columns by clicking the + button before the column name
</div>
</blockquote>

<p>Using the Visibile property of the DataGridViewColumn makes this a no-brainer. Let's take the <a href="http://www.timvw.be/developing-a-datasource-for-your-datagridview/">Databound DataGridView</a> and implement functionality to hide/unhide the quarterly results. All you have to do is add a DataGridViewButtonColumn and handle the DataGridView CellClick event as following:</p>
[code lang="csharp"]private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
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
}[/code]
<p>This is how it looks like:</p>
<img src="http://www.timvw.be/wp-content/images/datagridview-hide.gif" alt="screenshot of datagridview hiding columns"/>
<img src="http://www.timvw.be/wp-content/images/datagridview-unhide.gif" alt="screenshot of datagridview unhiding columns"/>
<p>Feel free to download the updated source code for <a href="http://www.timvw.be/wp-content/code/csharp/DataGridViewDataSource.zip">DataGridViewDataSource.zip</a>.</p>