---
ID: 90
post_title: XSLT annoyances
author: timvw
post_date: 2005-01-20 01:15:04
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/01/20/xslt-annoyances/
published: true
---
<p>Today i've finally made the switch. My code generates <a href="http://www.w3.org/XML/">XML</a> and then i translate it to <a href="http://www.w3.org/TR/xhtml1/">XHTML</a> with <a href="http://www.w3.org/TR/xslt">XSLT</a>. However, if i write </p>
[code lang="xml"]
<textarea name="foo"></textarea>
[/code]
<p>it will be translated to:</p>
[code lang="xml"]
<textarea name="foo"/>.
[/code]
<p>A not so good workaround is to write: (Notice the space in the xsl:text)</p>
[code lang="xml"]
<textarea name="foo"><xsl:text> </xsl:text></textarea>
[/code]

<p>UPDATE on 2005-01-20 05:42
The solution is to use html as output method instead of xml.</p>
[code lang="xml"]
<xsl:output method='html'/>
[/code]

<p>UPDATE on 2005-01-21 02:15
You may also want to make sure  HTML tags do not get transformed:</p>
 [code lang="xml"]
<xsl:value-of select="attribute[@name='content']" disable-output-escaping="yes"/>
[/code]