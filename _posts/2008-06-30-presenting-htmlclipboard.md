---
ID: 241
post_title: Presenting HtmlClipboard
author: timvw
post_date: 2008-06-30 09:28:38
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/06/30/presenting-htmlclipboard/
published: true
---
<p>Very often i need to encode/decode the contents of my Clipboard so i decided to write a little tray application to help me:</p>
<img src="http://www.timvw.be/wp-content/images/htmlclipboard.gif" alt="screenshot of htmlclipboard tray application"/>
<p>With the aid of <a href="http://msdn.microsoft.com/en-us/library/system.windows.forms.clipboard.aspx">Clipboard</a> and <a href="http://msdn.microsoft.com/en-us/library/system.web.httputility.aspx">HttpUtility</a> this is quite easy to implement:</p>
[code lang="csharp"]
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
[/code]
<p>Anyway, feel free to download <a href="http://www.timvw.be/wp-content/code/csharp/HtmlClipboard.zip">HtmlClipboard.zip</a>.</p>