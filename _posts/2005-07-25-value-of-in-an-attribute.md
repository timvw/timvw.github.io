---
ID: 104
post_title: value-of in an attribute
author: timvw
post_date: 2005-07-25 02:02:38
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/07/25/value-of-in-an-attribute/
published: true
---
<p>There were days that i didn't like XSL because it seemed to be impossible to insert a value inside an attribute. For example:</p>

[code lang="xml"]
<form action="<xsl:value-of select="/page/action"/>" method="post">
[/code]

<p>Today i've seen that other people also struggle with this issue. So here is the solution:</p>

[code lang="xml"]
<form action="{/page/action}" method="post">
</form>[/code]