---
ID: 1768
post_title: >
  Sometimes you can write it better than
  Resharper
author: timvw
post_date: 2010-07-03 17:11:11
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/07/03/sometimes-you-can-write-it-better-than-resharper/
published: true
dsq_thread_id:
  - "1926529087"
---
<p>Here is a real-life example of when people are much better expressing intent than a tool: Consider the following code from a typical Silverlight Navigation application:</p>

[code lang="csharp"]foreach (UIElement child in LinksStackPanel.Children)
{
 var hb = child as HyperlinkButton;
 if (hb != null && hb.NavigateUri != null)
 { .. }
}[/code]

<p>Resharper proposed to write this as following:</p>

[code lang="csharp"]foreach (var hb in LinksStackPanel.Children
 .Select(child => child as HyperlinkButton)
 .Where(hb => hb != null && hb.NavigateUri != null))
{ .. }[/code]

<p>Here is what i wrote instead:</p>

[code lang="csharp"]foreach (var hb in LinksStackPanel.Children
 .OfType<hyperlinkButton>()
 .Where(hb => hb.NavigateUri != null))
{ .. }[/code]