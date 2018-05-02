---
id: 163
title: Get hexadecimal RGB value from System.Drawing.Color
date: 2007-04-17T17:03:04+00:00
author: timvw
layout: post
guid: http://www.timvw.be/get-hexadecimal-rgb-value-from-systemdrawingcolor/
permalink: /2007/04/17/get-hexadecimal-rgb-value-from-systemdrawingcolor/
tags:
  - 'C#'
---
Here's a simple function that returns the [hexadecimal](http://en.wikipedia.org/wiki/Hexadecimal) [RGB](http://en.wikipedia.org/wiki/Rgb) value of a [System.Drawing.Color](http://msdn2.microsoft.com/en-us/library/system.drawing.color.aspx)

```csharp
private string ToHexadecimalRgb(Color color)
{
	return color.ToArgb().ToString("X").Substring(2);
}
```

**EDIT** Apparently there is also a [ColorTranslator](http://msdn2.microsoft.com/en-us/library/system.drawing.colortranslator.aspx) with methods [ToHtml](http://msdn2.microsoft.com/en-us/library/system.drawing.colortranslator.tohtml.aspx) and [FromHtml](http://msdn2.microsoft.com/en-us/library/system.drawing.colortranslator.fromhtml.aspx).
