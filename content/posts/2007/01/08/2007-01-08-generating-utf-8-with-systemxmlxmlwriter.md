---
date: "2007-01-08T00:00:00Z"
tags:
- CSharp
- XML
title: Generating UTF-8 with System.Xml.XmlWriter
aliases:
 - /2007/01/08/generating-utf-8-with-systemxmlxmlwriter/
 - /2007/01/08/generating-utf-8-with-systemxmlxmlwriter.html
---
Today i decided to experiment with [XmlWriter](http://msdn2.microsoft.com/en-us/library/system.xml.xmlwriter.aspx). The first i wanted to do was set the Encoding to UTF-8.

```csharp
StringBuilder stringBuilder = new StringBuilder();
XmlWriter xmlWriter = XmlWriter.Create(stringBuilder);
xmlWriter.Settings.Encoding = Encoding.UTF8;
```

When i ran this code i recieved the following exception: XmlException was unhandled: The 'XmlWriterSettings.Encoding' property is read only and cannot be set. The documentation for the [Settings](http://msdn2.microsoft.com/en-us/library/system.xml.xmlwriter.settings.aspx) property clearly says

> <div>
>   The XmlWriterSettings object returned by the Settings property cannot be modified. Any attempt to change individual settings results in an exception being thrown.
> </div>

So i wrote the following

```csharp
StringBuilder stringBuilder = new StringBuilder();
XmlWriterSettings xmlWriterSettings = new XmlWriterSettings();
xmlWriterSettings.Encoding = Encoding.UTF8;

XmlWriter xmlWriter = XmlWriter.Create(stringBuilder, xmlWriterSettings);
xmlWriter.WriteStartDocument();
xmlWriter.WriteStartElement("root", "http://www.timvw.be/ns");
xmlWriter.WriteEndElement();
xmlWriter.WriteEndDocument();
xmlWriter.Flush();
xmlWriter.Close();

string xmlString = stringBuilder.ToString();
```

As you can see: **<?xml version="1.0" encoding="utf-16"?><root xmlns="http://www.timvw.be/ns" />** is still not what i want. Apparently is the Encoding property ignored if the XmlWriter is not using a Stream. So here is my next attempt

```csharp
MemoryStream memoryStream = new MemoryStream();
// initialize xmlWriterSettings as above...

XmlWriter xmlWriter = XmlWriter.Create(memoryStream, xmlWriterSettings);
// call the same operations on the xmlWriter as above...

string xmlString = Encoding.UTF8.GetString(memoryStream.ToArray());
```

Ok, i'm getting close: **?<?xml version="1.0" encoding="utf-8"?><root xmlns="http://www.timvw.be/ns" />**. Luckily enough i knew that the ? (byte with value 239) at the beginning is the [BOM](http://en.wikipedia.org/wiki/Byte_Order_Mark). In order to get rid of that byte i had to create my own instance of [UTF8Encoding](http://msdn2.microsoft.com/en-us/library/system.text.utf8encoding.aspx). Finally, i can present some working code

```csharp
MemoryStream memoryStream = new MemoryStream();
XmlWriterSettings xmlWriterSettings = new XmlWriterSettings();
xmlWriterSettings.Encoding = new UTF8Encoding(false);
xmlWriterSettings.ConformanceLevel = ConformanceLevel.Document;
xmlWriterSettings.Indent = true;

XmlWriter xmlWriter = XmlWriter.Create(memoryStream, xmlWriterSettings);
xmlWriter.WriteStartDocument();
xmlWriter.WriteStartElement("root", "http://www.timvw.be/ns");
xmlWriter.WriteEndElement();
xmlWriter.WriteEndDocument();
xmlWriter.Flush();
xmlWriter.Close();

string xmlString = Encoding.UTF8.GetString(memoryStream.ToArray());
```
