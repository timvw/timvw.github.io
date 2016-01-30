---
ID: 10
post_title: >
  DataGridView with EditOnEnter as
  EditMode
author: timvw
post_date: 2006-09-16 02:04:08
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/09/16/datagridview-with-editonenter-as-editmode/
published: true
dsq_thread_id:
  - "1920133873"
---
<p>Earlier this week i found that when a <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridview.aspx">DataGridView</a> has it's <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridview.editmode.aspx">EditMode</a> property set to <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridvieweditmode.aspx">EditOnEnter</a> the user cannot select an entire row by clicking on the row header. This prevents the user from being able to delete a row. A couple of websearches later i found a <a href="http://connect.microsoft.com/VisualStudio/feedback/ViewFeedback.aspx?FeedbackID=98504">bugreport</a> but the proposed workarounds didn't work for me :( Here is a workaround that does work for me:</p>
[code lang="csharp"]
private void dataGridView1_MouseClick( object sender, MouseEventArgs e ) {
 DataGridView.HitTestInfo hitInfo = this.dataGridView1.HitTest(e.X, e.Y);
 if( hitInfo.Type == DataGridViewHitTestType.RowHeader ) {
  this.dataGridView1.EditMode = DataGridViewEditMode.EditOnKeystrokeOrF2;
  this.dataGridView1.EndEdit();
 }
 else
 {
  this.dataGridView1.EditMode = DataGridViewEditMode.EditOnEnter;
 }
}
[/code]