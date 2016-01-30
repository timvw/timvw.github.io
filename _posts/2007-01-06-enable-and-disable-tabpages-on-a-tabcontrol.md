---
ID: 141
post_title: >
  Enable and disable TabPages on a
  TabControl
author: timvw
post_date: 2007-01-06 15:29:41
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/01/06/enable-and-disable-tabpages-on-a-tabcontrol/
published: true
dsq_thread_id:
  - "1920154547"
---
<img src="http://www.timvw.be/wp-content/images/disabled-tabcontrol-1.gif" alt="screenshot of tabcontrol with disabled tabpages"/>
<img src="http://www.timvw.be/wp-content/images/disabled-tabcontrol-2.gif" alt="screenshot of tabcontrol with disabled tabpages"/>
<p>Apparently <a href="http://www.microsoft.com">Microsoft</a> choose not to implement support for disabled <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.tabpage.aspx">TabPage</a>s. The reason seems to be that it's against their <a href="http://msdn2.microsoft.com/en-us/library/aa511493.aspx">Guidelines for Tabs</a>. Let's ignore the guideline and implement the support anyway. First we set the <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.tabcontrol.drawmode.aspx">DrawMode</a> property of the <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.tabcontrol.aspx">TabControl</a> to <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.tabdrawmode.aspx">OwnerDrawFixed</a>. Next we add an eventhandler for the <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.tabcontrol.drawitem.aspx">DrawItem</a> Event:</p>
[code lang="csharp"]private void tabControl1_DrawItem(object sender, DrawItemEventArgs e)
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
}[/code]
<p>And we handle the <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.tabcontrol.selecting.aspx">Selecting</a> Event as following:</p>
[code lang="csharp"]private void tabControl1_Selecting(object sender, TabControlCancelEventArgs e)
{
 if (!e.TabPage.Enabled)
 {
  e.Cancel = true;
 }
}[/code]
<p>This works pretty fine, but we still have to make sure that the TabPages are Invalidated when the users changes their <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.enabled.aspx">Enabled</a> property. We do this by attaching and detaching an eventhandler for their <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.enabledchanged.aspx">EnabledChanged</a> Event when they're <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.controladded.aspx">added</a> and <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.controlremoved.aspx">removed</a>.</p>
[code lang="csharp"]private void tabControl1_ControlAdded(object sender, ControlEventArgs e)
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
}[/code]
<p>Feel free to download the demo application: <a href="http://www.timvw.be/wp-content/code/csharp/DisabledTabControl.zip">DisabledTabControl.zip</a>.</p>