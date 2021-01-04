---
date: "2007-04-29T00:00:00Z"
tags:
- CSharp
- Windows Forms
title: Presenting the MultiPanel
aliases:
 - /2007/04/29/presenting-the-multipanel/
 - /2007/04/29/presenting-the-multipanel.html
---
A while ago i was thinking that i would be nice to have a control that exposes multiple designer panels, but only shows one at a time... Somewhat like a TabControl, but without the header.. Anyway, i found out ([here](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=1518961&SiteID=1)) that a TabControl can be tweaked into that behaviour

```csharp
public class MultiPanel : TabControl
{
	protected override void WndProc(ref Message m)
	{
		if (m.Msg == 0x1328 && !DesignMode)
		{
			m.Result = (IntPtr) 1;
		}
		else
		{
			base.WndProc(ref m);
		}
	}
}
```

In the designer it appears as following

![screenshot of MultiPanel at designtime](http://www.timvw.be/wp-content/images/MultiPanel1.gif)
  
![screenshot of MultiPanel at designtime](http://www.timvw.be/wp-content/images/MultiPanel2.gif)

And at runtime it appears as following

![screenshot of MultiPanel at designtime](http://www.timvw.be/wp-content/images/MultiPanel3.gif)
  
![screenshot of MultiPanel at designtime](http://www.timvw.be/wp-content/images/MultiPanel4.gif)
