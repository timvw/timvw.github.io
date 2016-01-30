---
ID: 209
post_title: Writing Xml without the XmlDeclaration
author: timvw
post_date: 2008-02-26 20:16:02
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/02/26/writing-xml-without-the-xmldeclaration/
published: true
---
<p>Consider the following xml file:</p>
[code lang="xml"]
<?xml version="1.0" encoding="utf-8" ?>
<!-- some comment -->
<root>
</root>
<!-- another comment -->
[/code]
<p>If you look at the <a href="http://www.w3.org/TR/REC-xml/#sec-well-formed">Well-Formed XML Documents</a> section in the <a href="http://www.w3.org/TR/REC-xml/">XML specification</a>  you see that a well-formed document is defined as:</p>
<blockquote>
[1] document ::= <a href="http://www.w3.org/TR/REC-xml/#NT-prolog">prolog</a> <a href="http://www.w3.org/TR/REC-xml/#NT-element">element</a> <a href="http://www.w3.org/TR/REC-xml/#NT-Misc">Misc*</a>
</blockquote>

<p>Since there is only 1 root element (ever), i assumed that if you <a href="http://msdn2.microsoft.com/en-us/library/system.xml.xmldocument.load.aspx">Load</a> this file with <a href="http://msdn2.microsoft.com/en-us/library/system.xml.xmldocument.aspx">XmlDocument</a> their would be only one <a href="http://msdn2.microsoft.com/en-us/library/system.xml.xmlnode.aspx">XmlNode</a> in the document <a href="http://msdn2.microsoft.com/en-us/library/system.xml.xmlnode.childnodes.aspx">ChildNodes</a>. In reality there ChildNodes.Count returns 4.</p>

<p>The simplest way to write this XmlDocument without the declaration would be as following:</p>

[code lang="csharp"]XmlWriterSettings xmlWriterSettings = new XmlWriterSettings();
xmlWriterSettings.OmitXmlDeclaration = true;
xmlWriterSettings.Encoding = Encoding.UTF8;
using (XmlWriter writer = XmlWriter.Create(@"result.xml", xmlWriterSettings))
{
 xmlDoc.WriteTo(writer);
}
[/code]