---
date: "2007-01-06T00:00:00Z"
tags:
- CSharp
- Windows Forms
title: Enable and disable TabPages on a TabControl
aliases:
 - /2007/01/06/enable-and-disable-tabpages-on-a-tabcontrol/
 - /2007/01/06/enable-and-disable-tabpages-on-a-tabcontrol.html
---
![screenshot of tabcontrol with disabled tabpages](http://www.timvw.be/wp-content/images/disabled-tabcontrol-1.gif)
  
![screenshot of tabcontrol with disabled tabpages](http://www.timvw.be/wp-content/images/disabled-tabcontrol-2.gif)

Apparently [Microsoft](http://www.microsoft.com) choose not to implement support for disabled [TabPage](http://msdn2.microsoft.com/en-us/library/system.windows.forms.tabpage.aspx)s. The reason seems to be that it's against their [Guidelines for Tabs](http://msdn2.microsoft.com/en-us/library/aa511493.aspx). Let's ignore the guideline and implement the support anyway. First we set the [DrawMode](http://msdn2.microsoft.com/en-us/library/system.windows.forms.tabcontrol.drawmode.aspx) property of the [TabControl](http://msdn2.microsoft.com/en-us/library/system.windows.forms.tabcontrol.aspx) to [OwnerDrawFixed](http://msdn2.microsoft.com/en-us/library/system.windows.forms.tabdrawmode.aspx). Next we add an eventhandler for the [DrawItem](http://msdn2.microsoft.com/en-us/library/system.windows.forms.tabcontrol.drawitem.aspx) Event

```csharp
private void tabControl1_DrawItem(object sender, DrawItemEventArgs e)
{
	TabControl tabControl = sender as TabControl;
	TabPage tabPage = tabControl.TabPages[e.Index];
	Rectangle tabRectangle = tabControl.GetTabRect(e.Index);

	if (tabControl.Alignment == TabAlignment.Left || tabControl.Alignment == TabAlignment.Right)
	{
		float rotateAngle = 90;
		if (tabControl.Alignment == TabAlignment.Left)
		{
			rotateAngle = 270;
		}

		PointF cp = new PointF(tabRectangle.Left + (tabRectangle.Width / 2), tabRectangle.Top + (tabRectangle.Height / 2));
		e.Graphics.TranslateTransform(cp.X, cp.Y);
		e.Graphics.RotateTransform(rotateAngle);
		tabRectangle = new Rectangle(-(tabRectangle.Height / 2), -(tabRectangle.Width / 2), tabRectangle.Height, tabRectangle.Width);
	}

	using (SolidBrush foreBrush = new SolidBrush(tabPage.ForeColor))
	{
		using (SolidBrush backBrush = new SolidBrush(tabPage.BackColor))
		{
			if (!tabPage.Enabled)
			{
				foreBrush.Color = SystemColors.GrayText;
			}

			e.Graphics.FillRectangle(backBrush, tabRectangle);

			using (StringFormat stringFormat = new StringFormat())
			{
				stringFormat.Alignment = StringAlignment.Center;
				stringFormat.LineAlignment = StringAlignment.Center;
				e.Graphics.DrawString(tabPage.Text, e.Font, foreBrush, tabRectangle, stringFormat);
			}
		}
	}

	e.Graphics.ResetTransform();
}
```

And we handle the [Selecting](http://msdn2.microsoft.com/en-us/library/system.windows.forms.tabcontrol.selecting.aspx) Event as following

```csharp
private void tabControl1_Selecting(object sender, TabControlCancelEventArgs e)
{
	if (!e.TabPage.Enabled)
	{
		e.Cancel = true;
	}
}
```

This works pretty fine, but we still have to make sure that the TabPages are Invalidated when the users changes their [Enabled](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.enabled.aspx) property. We do this by attaching and detaching an eventhandler for their [EnabledChanged](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.enabledchanged.aspx) Event when they're [added](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.controladded.aspx) and [removed](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.controlremoved.aspx).

```csharp
private void tabControl1_ControlAdded(object sender, ControlEventArgs e)
{
	TabPage tabPage = sender as TabPage;
	if (tabPage != null)
	{
		tabPage.EnabledChanged += new EventHandler(this.tabPage_EnabledChanged);
	}
}

private void tabControl1_ControlRemoved(object sender, ControlEventArgs e)
{
	TabPage tabPage = sender as TabPage;
	if (tabPage != null)
	{
		tabPage.EnabledChanged -= new EventHandler(this.tabPage_EnabledChanged);
	}
}

void tabPage_EnabledChanged(object sender, EventArgs e)
{
	TabPage tabPage = sender as TabPage;
	TabControl tabControl = tabPage.Parent as TabControl;
	tabControl.Invalidate(tabPage.ClientRectangle);
}
```

Feel free to download the demo application: [DisabledTabControl.zip](http://www.timvw.be/wp-content/code/csharp/DisabledTabControl.zip).
