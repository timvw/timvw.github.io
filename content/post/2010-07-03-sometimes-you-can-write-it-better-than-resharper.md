---
date: "2010-07-03T00:00:00Z"
guid: http://www.timvw.be/?p=1768
tags:
- CSharp
title: Sometimes you can write it better than Resharper
aliases:
 - /2010/07/03/sometimes-you-can-write-it-better-than-resharper/
 - /2010/07/03/sometimes-you-can-write-it-better-than-resharper.html
---
Here is a real-life example of when people are much better expressing intent than a tool: Consider the following code from a typical Silverlight Navigation application

```csharp
foreach (UIElement child in LinksStackPanel.Children)
{
	var hb = child as HyperlinkButton;
	if (hb != null && hb.NavigateUri != null)
	{ .. }
}
```

Resharper proposed to write this as following

```csharp
foreach (var hb in LinksStackPanel.Children
	.Select(child => child as HyperlinkButton)
	.Where(hb => hb != null && hb.NavigateUri != null))
	{ .. }
```

Here is what i wrote instead

```csharp
foreach (var hb in LinksStackPanel.Children
	.OfType<hyperlinkButton>()
	.Where(hb => hb.NavigateUri != null))
	{ .. }
```
