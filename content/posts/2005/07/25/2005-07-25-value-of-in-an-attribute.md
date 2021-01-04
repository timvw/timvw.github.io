---
date: "2005-07-25T00:00:00Z"
tags:
- XML
title: value-of in an attribute
aliases:
 - /2005/07/25/value-of-in-an-attribute/
 - /2005/07/25/value-of-in-an-attribute.html
---
There were days that i did not like XSL because it seemed to be impossible to insert a value inside an attribute. For example:

```xml
<form action="<xsl:value-of select="/page/action"/>" method="post">
```

Today i've seen that other people also struggle with this issue. So here is the solution:

```xml
<form action="{/page/action}" method="post">
```
