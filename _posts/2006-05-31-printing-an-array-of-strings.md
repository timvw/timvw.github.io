---
ID: 26
post_title: Printing an array of strings
author: timvw
post_date: 2006-05-31 02:34:52
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/05/31/printing-an-array-of-strings/
published: true
---
<p>Yesterday i've been experimenting with <a href="http://java.sun.com/printing/">Printing on the Java Platform</a>. I needed to generate a printout of ordered menuitems on the default printer. It took a while before i found out there is translation needed between the coordinates of the <a href="http://java.sun.com/j2se/1.4.2/docs/api/java/awt/Graphics.html">Graphics</a> device and the <a href="http://java.sun.com/j2se/1.4.2/docs/api/java/awt/print/PageFormat.html">PageFormat</a>. Here is my <a href="http://www.timvw.be/wp-content/code/java/LinesPrinter.java.txt">LinesPrinter</a>. Here is an example of how you can use the class:</p>

[code lang="java"]
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

lines.add("\t----------");
lines.add("\t" + df.format(getTotal()));

LinesPrinter.print((String[]) lines.toArray(new String[0]));
[/code]