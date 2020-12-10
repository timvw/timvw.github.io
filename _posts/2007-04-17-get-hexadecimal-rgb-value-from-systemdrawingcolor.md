---
title: Get hexadecimal RGB value from System.Drawing.Color
layout: post
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
