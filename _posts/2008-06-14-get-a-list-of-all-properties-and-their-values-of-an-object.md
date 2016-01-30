---
ID: 230
post_title: >
  Enumerate all properties and their value
  of an object
author: timvw
post_date: 2008-06-14 13:11:17
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/06/14/get-a-list-of-all-properties-and-their-values-of-an-object/
published: true
---
<p>Earlier today someone asked me how to generate a List with all the properties (and their respective value) that an object has. With C# 2.0 i would have created a class to represent a single element, PropertyRow, with a Name and a Value property and a class that is IEnumerable&lt;PropertyRow&gt; to hold all PropertyRows.</p>
<p>With C# 3.0 we can take advantage of <a href="http://msdn.microsoft.com/en-us/library/bb397696.aspx">anonymous types</a> and the code we have to write is fairly minimal:</p>
[code lang="csharp"]
Person angelina = new Person("Angelina", "Jolie", "0275198123", "CloseToMe blv 12");

var propertyRows =
  from propertyInfo in angelina.GetType().GetProperties()
  select new { Name = propertyInfo.Name, Value = propertyInfo.GetValue(angelina, null) };

BindingSource bs = new BindingSource();
bs.DataSource = propertyRows;

this.dataGridView1.DataSource = bs;
[/code]
<p>Just as with anonymous delegates, as soon as you notice that you define the same anonymous class more than once, you may want to consider to take it out of the anonymousity.</p>