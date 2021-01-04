---
date: "2008-06-30T00:00:00Z"
guid: http://www.timvw.be/?p=241
tags:
- CSharp
title: Presenting HtmlClipboard
---
Very often i need to encode/decode the contents of my Clipboard so i decided to write a little tray application to help me

![screenshot of htmlclipboard tray application](http://www.timvw.be/wp-content/images/htmlclipboard.gif)

With the aid of [Clipboard](http://msdn.microsoft.com/en-us/library/system.windows.forms.clipboard.aspx) and [HttpUtility](http://msdn.microsoft.com/en-us/library/system.web.httputility.aspx) this is quite easy to implement

```csharp
private void toolStripMenuItemDecode_Click(object sender, EventArgs e)
{
	string original = Clipboard.GetText();
	string decodedHtml = HttpUtility.HtmlDecode(original);
	Clipboard.SetText(decodedHtml);
}

private void toolStripMenuItemEncode_Click(object sender, EventArgs e)
{
	string original = Clipboard.GetText();
	string encodedHtml = HttpUtility.HtmlEncode(original);
	Clipboard.SetText(encodedHtml);
}
```

Anyway, feel free to download [HtmlClipboard.zip](http://www.timvw.be/wp-content/code/csharp/HtmlClipboard.zip).
