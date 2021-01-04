---
date: "2006-05-31T00:00:00Z"
tags:
- Java
title: Printing an array of strings
aliases:
 - /2006/05/31/printing-an-array-of-strings/
 - /2006/05/31/printing-an-array-of-strings.html
---
Yesterday i've been experimenting with [Printing on the Java Platform](http://java.sun.com/printing/). I needed to generate a printout of ordered menuitems on the default printer. It took a while before i found out there is translation needed between the coordinates of the [Graphics](http://java.sun.com/j2se/1.4.2/docs/api/java/awt/Graphics.html) device and the [PageFormat](http://java.sun.com/j2se/1.4.2/docs/api/java/awt/print/PageFormat.html). Here is my [LinesPrinter](http://www.timvw.be/wp-content/code/java/LinesPrinter.java.txt). Here is an example of how you can use the class

```java
ArrayList<string> lines = new ArrayList<string>();

StringBuffer buf = new StringBuffer("De RegaPan\t");
buf.append(DateFormat.getDateTimeInstance().format(new Date()));
lines.add(buf.toString());
lines.add("");

DecimalFormat df = new DecimalFormat("##.00");

Enumeration e = billModel.elements();
while (e.hasMoreElements()) {
	Order o = (Order) e.nextElement();
	MenuItem mi = o.getMenuItem();

	buf = new StringBuffer(mi.getName());
	buf.append("\t");
	buf.append(df.format(mi.getPriceIncVat()));

	lines.add(buf.toString());
}

lines.add("\t-------");
lines.add("\t" + df.format(getTotal()));

LinesPrinter.print((String[]) lines.toArray(new String[0]));
```
