---
ID: 143
post_title: >
  Generating UTF-8 with
  System.Xml.XmlWriter
author: timvw
post_date: 2007-01-08 23:59:44
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/01/08/generating-utf-8-with-systemxmlxmlwriter/
published: true
dsq_thread_id:
  - "1921251479"
---
<p>Today i decided to experiment with <a href="http://msdn2.microsoft.com/en-us/library/system.xml.xmlwriter.aspx">XmlWriter</a>. The first i wanted to do was set the Encoding to UTF-8.:</p>

[code lang="csharp"]StringBuilder stringBuilder = new StringBuilder();
XmlWriter xmlWriter = XmlWriter.Create(stringBuilder);
xmlWriter.Settings.Encoding = Encoding.UTF8;[/code]

<p>When i ran this code i recieved the following exception: XmlException was unhandled: The 'XmlWriterSettings.Encoding' property is read only and cannot be set. The documentation for the <a href="http://msdn2.microsoft.com/en-us/library/system.xml.xmlwriter.settings.aspx">Settings</a> property clearly says:</p>

<blockquote>
<div>
The XmlWriterSettings object returned by the Settings property cannot be modified. Any attempt to change individual settings results in an exception being thrown.
</div>
</blockquote>

<p>So i wrote the following:</p>

[code lang="csharp"]StringBuilder stringBuilder = new StringBuilder();
XmlWriterSettings xmlWriterSettings = new XmlWriterSettings();
xmlWriterSettings.Encoding = Encoding.UTF8;

XmlWriter xmlWriter = XmlWriter.Create(stringBuilder, xmlWriterSettings);
xmlWriter.WriteStartDocument();
xmlWriter.WriteStartElement("root", "http://www.timvw.be/ns");
xmlWriter.WriteEndElement();
xmlWriter.WriteEndDocument();
xmlWriter.Flush();
xmlWriter.Close();

string xmlString = stringBuilder.ToString();[/code]

<p>As you can see: <b>&lt;?xml version="1.0" encoding="utf-16"?&gt;&lt;root xmlns="http://www.timvw.be/ns" /&gt;</b> is still not what i want. Apparently is the Encoding property ignored if the XmlWriter is not using a Stream. So here is my next attempt:</p>

[code lang="csharp"]MemoryStream memoryStream = new MemoryStream();
// initialize xmlWriterSettings as above...

XmlWriter xmlWriter = XmlWriter.Create(memoryStream, xmlWriterSettings);
// call the same operations on the xmlWriter as above...

string xmlString = Encoding.UTF8.GetString(memoryStream.ToArray());[/code]
<p>Ok, i'm getting close: <b>?&lt;?xml version="1.0" encoding="utf-8"?&gt;&lt;root xmlns="http://www.timvw.be/ns" /&gt;</b>. Luckily enough i knew that the ? (byte with value 239) at the beginning is the <a href="http://en.wikipedia.org/wiki/Byte_Order_Mark">BOM</a>. In order to get rid of that byte i had to create my own instance of <a href="http://msdn2.microsoft.com/en-us/library/system.text.utf8encoding.aspx">UTF8Encoding</a>. Finally, i can present some working code:</p>
[code lang="csharp"]MemoryStream memoryStream = new MemoryStream();
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

string xmlString = Encoding.UTF8.GetString(memoryStream.ToArray());[/code]