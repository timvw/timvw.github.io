---
date: "2006-09-16T00:00:00Z"
tags:
- C#
- Windows Forms
title: DataGridView with EditOnEnter as EditMode
aliases:
 - /2006/09/16/datagridview-with-editonenter-as-editmode/
 - /2006/09/16/datagridview-with-editonenter-as-editmode.html
---
Earlier this week i found that when a [DataGridView](http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridview.aspx) has it's [EditMode](http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridview.editmode.aspx) property set to [EditOnEnter](http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridvieweditmode.aspx) the user cannot select an entire row by clicking on the row header. This prevents the user from being able to delete a row. A couple of websearches later i found a [bugreport](http://connect.microsoft.com/VisualStudio/feedback/ViewFeedback.aspx?FeedbackID=98504) but the proposed workarounds didn't work for me 🙁 Here is a workaround that does work for me

```csharp
private void dataGridView1_MouseClick( object sender, MouseEventArgs e ) 
{
	DataGridView.HitTestInfo hitInfo = this.dataGridView1.HitTest(e.X, e.Y);
	if( hitInfo.Type == DataGridViewHitTestType.RowHeader ) 
	{
		this.dataGridView1.EditMode = DataGridViewEditMode.EditOnKeystrokeOrF2;
		this.dataGridView1.EndEdit();
	}
	else
	{
		this.dataGridView1.EditMode = DataGridViewEditMode.EditOnEnter;
	}
}
```
