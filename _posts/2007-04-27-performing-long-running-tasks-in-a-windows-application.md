---
ID: 165
post_title: >
  Performing long running tasks in a
  Windows Application
author: timvw
post_date: 2007-04-27 23:12:22
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/04/27/performing-long-running-tasks-in-a-windows-application/
published: true
dsq_thread_id:
  - "1933325640"
---
<p>A while ago i blogged about <a href="http://www.timvw.be/about-thread-safe-gui/">Thread Safe UI</a>. Today someone asked the following:</p>

<blockquote>
<div>
On a form i have a datagridview and two button. One is for insert in a database the values in datagridview, and the other to update data in db.
Now, i would like to have a kind of 'progress form'  during the insert or the update. At the end, only when the operation is finished, the user can reuse the main form.
</div>
</blockquote>

<p>The first thing i do is define a delegate (void Performer()) that will do the work of a long running operation. The reason i do this is because the compiler generates a class Performer that inherits from System.MulticastDelegate and exposes Begin- and EndInvoke methods.</p>
<img src="http://www.timvw.be/wp-content/images/performerdelegate.gif" alt="screenshot of ildasm displaying generated performer class"/>
<p>Since i want to disable my form before each run of a Performer and enable it after each run i implement a method Perform as following:</p>
[code lang="csharp"]private void Perform(Performer performer, string message)
{
 this.PrePerform(message);
 performer.BeginInvoke(this.PostPerform, null);
}[/code]
<p>Now it's simply a matter of implemeting Pre- and PostPerform:</p>
[code lang="csharp"]private void PrePerform(string message)
{
 if (this.InvokeRequired)
 {
  this.EndInvoke(this.BeginInvoke(new MethodInvoker(delegate { this.PrePerform(message); })));
 }
 else
 {
  this.Enabled = false;
  this.toolStripStatusLabel1.Text = message;
  this.toolStripStatusLabel1.Visible = true;
  this.toolStripProgressBar1.Visible = true;
 }
}

private void PostPerform(object state)
{
 if (this.InvokeRequired)
 {
  this.EndInvoke(this.BeginInvoke(new MethodInvoker(delegate { this.PostPerform(state); })));
 }
 else
 {
  this.toolStripProgressBar1.Visible = false;
  this.toolStripStatusLabel1.Visible = false;
  this.toolStripStatusLabel1.Text = string.Empty;
  this.Enabled = true;
 }
}[/code]
<p>Now that we have all the infrastructure i implement an eventhandler for a button click:</p>
[code lang="csharp"]private void button1_Click(object sender, EventArgs e)
{
 // remove previously retrieved results
 this.UpdateResultLabel(string.Empty);

 this.Perform(delegate
 {
  // simulate the effect of a blocking operation that takes a while to complete
  // eg: remoting, webrequests, database queries, ...
  Thread.Sleep(5000);

  // display the result of the long running operation
  this.UpdateResultLabel("Value was retrieved...");
 }, "Retrieving value...");
}[/code]
<p>Here are a couple of screenshots of the running program:</p>
<img src="http://www.timvw.be/wp-content/images/performerdelegate2.gif" alt="screenshot of application not doing anything"/><br/>
<img src="http://www.timvw.be/wp-content/images/performerdelegate3.gif" alt="screenshot of application performing long running task"/><br/>
<img src="http://www.timvw.be/wp-content/images/performerdelegate4.gif" alt="screenshot of application after completion of long running task"/><br/>

<p>Feel free to download the <a href="http://www.timvw.be/wp-content/code/csharp/AsyncDemo.zip">AsyncDemo.zip</a></p>