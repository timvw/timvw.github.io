---
date: "2008-02-26T00:00:00Z"
tags:
- CSharp
- XML
title: Writing Xml without the XmlDeclaration
aliases:
 - /2008/02/26/writing-xml-without-the-xmldeclaration/
 - /2008/02/26/writing-xml-without-the-xmldeclaration.html
---
Consider the following xml file:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<!-- some comment -->
<root>
</root>
<!-- another comment -->
```

If you look at the [Well-Formed XML Documents](http://www.w3.org/TR/REC-xml/#sec-well-formed) section in the [XML specification](http://www.w3.org/TR/REC-xml/) you see that a well-formed document is defined as:

> [1] document ::= [prolog](http://www.w3.org/TR/REC-xml/#NT-prolog) [element](http://www.w3.org/TR/REC-xml/#NT-element) [Misc*](http://www.w3.org/TR/REC-xml/#NT-Misc) 

Since there is only 1 root element (ever), i assumed that if you [Load](http://msdn2.microsoft.com/en-us/library/system.xml.xmldocument.load.aspx) this file with [XmlDocument](http://msdn2.microsoft.com/en-us/library/system.xml.xmldocument.aspx) their would be only one [XmlNode](http://msdn2.microsoft.com/en-us/library/system.xml.xmlnode.aspx) in the document [ChildNodes](http://msdn2.microsoft.com/en-us/library/system.xml.xmlnode.childnodes.aspx). In reality there ChildNodes.Count returns 4.

The simplest way to write this XmlDocument without the declaration would be as following:

```csharp
XmlWriterSettings xmlWriterSettings = new XmlWriterSettings();
xmlWriterSettings.OmitXmlDeclaration = true;
xmlWriterSettings.Encoding = Encoding.UTF8;
using (XmlWriter writer = XmlWriter.Create(@"result.xml", xmlWriterSettings))
{
	xmlDoc.WriteTo(writer);
}
```
