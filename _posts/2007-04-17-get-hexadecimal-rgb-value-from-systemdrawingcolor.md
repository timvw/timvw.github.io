---
ID: 163
post_title: >
  Get hexadecimal RGB value from
  System.Drawing.Color
author: timvw
post_date: 2007-04-17 17:03:04
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/04/17/get-hexadecimal-rgb-value-from-systemdrawingcolor/
published: true
---
<p>Here's a simple function that returns the <a href="http://en.wikipedia.org/wiki/Hexadecimal">hexadecimal</a> <a href="http://en.wikipedia.org/wiki/Rgb">RGB</a> value of a <a href="http://msdn2.microsoft.com/en-us/library/system.drawing.color.aspx">System.Drawing.Color</a>:</p>
[code lang="csharp"]private string ToHexadecimalRgb(Color color)
{
 return color.ToArgb().ToString("X").Substring(2);
}[/code]
<p><b>EDIT</b> Apparently there is also a <a href="http://msdn2.microsoft.com/en-us/library/system.drawing.colortranslator.aspx">ColorTranslator</a> with methods <a href="http://msdn2.microsoft.com/en-us/library/system.drawing.colortranslator.tohtml.aspx">ToHtml</a> and <a href="http://msdn2.microsoft.com/en-us/library/system.drawing.colortranslator.fromhtml.aspx">FromHtml</a>.</p>