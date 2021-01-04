---
date: "2005-01-20T00:00:00Z"
tags:
- XML
title: XSLT annoyances
aliases:
 - /2005/01/20/xslt-annoyances/
 - /2005/01/20/xslt-annoyances.html
---
Today i've finally made the switch. My code generates [XML](http://www.w3.org/XML/) and then i translate it to [XHTML](http://www.w3.org/TR/xhtml1/) with [XSLT](http://www.w3.org/TR/xslt). However, if i write 

```xml
<textarea name="foo"></textarea>
```

it will be translated to:

```xml
<textarea name="foo" />.
```

A not so good workaround is to write: (Notice the space in the xsl:text)

```xml
<textarea name="foo"><xsl:text> </xsl:text></textarea>
```

UPDATE on 2005-01-20 05:42
  
The solution is to use html as output method instead of xml.

```xml
<xsl:output method='html'/>
```

UPDATE on 2005-01-21 02:15
  
You may also want to make sure HTML tags do not get transformed:

```xml
<xsl:value-of select="attribute[@name='content']" disable-output-escaping="yes"/>
```
