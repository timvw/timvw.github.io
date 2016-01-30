---
ID: 24
post_title: A TableModel for Entity Beans
author: timvw
post_date: 2006-06-18 02:28:22
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/06/18/a-tablemodel-for-entity-beans/
published: true
---
<p>For my graduation project i needed a component that could display a list of <a href="http://java.sun.com/j2ee/tutorial/1_3-fcs/doc/EJBConcepts4.html">Entity Beans</a>. I found that <a href="http://java.sun.com/j2se/1.5.0/docs/api/javax/swing/JTable.html">JTable</a> is such a component and with the help of custom <a href="http://java.sun.com/j2se/1.5.0/docs/api/javax/swing/table/TableCellRenderer.html">TableCellRenderer</a> and <a href="http://java.sun.com/j2se/1.5.0/docs/api/javax/swing/table/TableCellEditor.html">TableCellEditor</a> components i was able to customize the rendering to my needs. In order to get the data into the JTable i implemented a custom <a href="http://java.sun.com/j2se/1.5.0/docs/api/javax/swing/table/TableModel.html">TableModel</a>, namely <a href="http://www.timvw.be/wp-content/code/java/EntityTableModel.java.txt">EntityTableModel</a>. Now i can easily generate a JTable that displays Entity Beans: </p>

[code lang="java"]
// fetch the elements we want to display
Object[] elements = employeeController
  .getEntityManager()
  .createNamedQuery("findEmployees")
  .getResultList()
  .toArray();

// build map with column name, entity attribute pairs
HashMap<string, String> colAttrs = new LinkedHashMap<string, String>();
colAttrs.put("First Name", "firstName");
colAttrs.put("Last Name", "lastName");

// build collection with editable attributes
Collection<string> editables = new ArrayList<string>();

// initialise the tablemodel
TableModel tableModel = new EntityTableModel(elements, colAttrs, editables);

// initialise the table
JTable table = new JTable(tableModel);
[/code]