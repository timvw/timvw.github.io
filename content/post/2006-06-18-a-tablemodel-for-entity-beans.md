---
date: "2006-06-18T00:00:00Z"
tags:
- Hibernate
title: A TableModel for Entity Beans
aliases:
 - /2006/06/18/a-tablemodel-for-entity-beans/
 - /2006/06/18/a-tablemodel-for-entity-beans.html
---
For my graduation project i needed a component that could display a list of [Entity Beans](http://java.sun.com/j2ee/tutorial/1_3-fcs/doc/EJBConcepts4.html). I found that [JTable](http://java.sun.com/j2se/1.5.0/docs/api/javax/swing/JTable.html) is such a component and with the help of custom [TableCellRenderer](http://java.sun.com/j2se/1.5.0/docs/api/javax/swing/table/TableCellRenderer.html) and [TableCellEditor](http://java.sun.com/j2se/1.5.0/docs/api/javax/swing/table/TableCellEditor.html) components i was able to customize the rendering to my needs. In order to get the data into the JTable i implemented a custom [TableModel](http://java.sun.com/j2se/1.5.0/docs/api/javax/swing/table/TableModel.html), namely [EntityTableModel](http://www.timvw.be/wp-content/code/java/EntityTableModel.java.txt). Now i can easily generate a JTable that displays Entity Beans

```java
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
```
