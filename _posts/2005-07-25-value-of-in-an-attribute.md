---
id: 104
title: value-of in an attribute
date: 2005-07-25T02:02:38+00:00
author: timvw
layout: post
guid: http://www.timvw.be/value-of-in-an-attribute/
permalink: /2005/07/25/value-of-in-an-attribute/
tags:
  - XML
---
There were days that i did not like XSL because it seemed to be impossible to insert a value inside an attribute. For example:

```xml
<form action="<xsl:value-of select="/page/action"/>" method="post">
```

Today i've seen that other people also struggle with this issue. So here is the solution:

```xml
<form action="{/page/action}" method="post">
```
