---
ID: 155
post_title: 'Presenting the SortableBindingList&lt;T&gt;'
author: timvw
post_date: 2007-02-22 01:32:43
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/02/22/presenting-the-sortablebindinglistt/
published: true
dsq_thread_id:
  - "1920113687"
---
<p>If you are databinding your custom objects (in a Bindinglist of &lt;T&gt;) to a DataGridView you will notice that the users can't sort the rows by clicking on the columnheaders... Unlike an unbound DataGridView, the SortCompare event is not raised. Here is a class that uses IComparer to implement a BindingList that supports Sorting:</p>

<p><b>Please read the <a href="http://www.timvw.be/presenting-the-sortablebindinglistt-take-two/">follow up article</a> to find the updated source code.</b></p>

<p>Using this SortableBindingList is as easy as:</p>
[code lang="csharp"]public Form1()
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
}[/code]
<br/>
<img src="http://www.timvw.be/wp-content/images/sortablebindinglist.gif" alt="the sortablebindinglist at work"/>
<p>Feel free to download the source and demoproject: <a href="http://www.timvw.be/wp-content/code/csharp/SortableBindingList.zip">SortableBindingList.zip</a>.</p>
<p><b>Edit:</b> You can find the latest implementation at <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a>, a project where i will keep classes that i find interesting.</p>