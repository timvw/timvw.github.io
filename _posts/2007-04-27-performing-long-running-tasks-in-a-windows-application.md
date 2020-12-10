---
title: Performing long running tasks in a Windows Application
layout: post
tags:
  - 'C#'
  - Windows Forms
---
A while ago i blogged about [Thread Safe UI](http://www.timvw.be/about-thread-safe-gui/). Today someone asked the following

> <div>
>   On a form i have a datagridview and two button. One is for insert in a database the values in datagridview, and the other to update data in db.<br /> Now, i would like to have a kind of 'progress form' during the insert or the update. At the end, only when the operation is finished, the user can reuse the main form.
> </div>

The first thing i do is define a delegate (void Performer()) that will do the work of a long running operation. The reason i do this is because the compiler generates a class Performer that inherits from System.MulticastDelegate and exposes Begin- and EndInvoke methods.

![screenshot of ildasm displaying generated performer class](http://www.timvw.be/wp-content/images/performerdelegate.gif)

Since i want to disable my form before each run of a Performer and enable it after each run i implement a method Perform as following

```csharp
private void Perform(Performer performer, string message)
{
	this.PrePerform(message);
	performer.BeginInvoke(this.PostPerform, null);
}
```

Now it's simply a matter of implemeting Pre- and PostPerform

```csharp
private void PrePerform(string message)
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
}
```

Now that we have all the infrastructure i implement an eventhandler for a button click

```csharp
private void button1_Click(object sender, EventArgs e)
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
}
```

Here are a couple of screenshots of the running program

![screenshot of application not doing anything](http://www.timvw.be/wp-content/images/performerdelegate2.gif)
  
![screenshot of application performing long running task](http://www.timvw.be/wp-content/images/performerdelegate3.gif)
  
![screenshot of application after completion of long running task](http://www.timvw.be/wp-content/images/performerdelegate4.gif)

Feel free to download the [AsyncDemo.zip](http://www.timvw.be/wp-content/code/csharp/AsyncDemo.zip)
