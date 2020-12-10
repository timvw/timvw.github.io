---
title: 'Exploring alternative input: ActiveHome'
layout: post
tags:
  - 'C#'
---
A while ago i bought [Media Centerkit](http://www.easycomputing.com/product.asp?ref=3655) for an euro or two. I wouldn't recommend the product because it comes with crappy software. Anyway, i was only interested in playing with the hardware (RF Remote and USB Receiver) so i downloaded the [ActiveHome Professional SDK](http://www.activehomepro.com/sdk/sdk-info.html). Once you install this you can add a reference to "ActiveHomeScript 1.0 Type Library" under the COM tab in Visual Studio. I wrote a little library so that i can consume the ActiveHomeClass.RecvAction in a Type-safe way

![class diagram of activehome library](http://www.timvw.be/wp-content/images/activehomelibrary.png)

Here is some sample code that demonstrates how you can use the Notifier to receive Notifications

```csharp
// register our eventhandler and tell the notifier to start raising events
Notifier.Instance.NotificationReceived += this.Instance_NotificationReceived;
Notifier.Instance.Enable();

private void Instance_NotificationReceived(object sender, NotificationReceivedEventArgs e)
{
	// for more complex logic i would recommend that you apply a Filter pattern...
	RadioFrequencyNotification rfNotification = e.Notification as RadioFrequencyNotification;
	if (rfNotification.IsKeyPressed)
	{
		if (rfNotification.Command == RadioFrequencyCommand.Menu)
		{
			this.RaiseToolStripMenuItemClicked(this.MenuClicked, EventArgs.Empty);
		}
	}
}
```

As always feel free to download the library and sample application: [ActiveHome.zip](http://www.timvw.be/wp-content/code/csharp/ActiveHome.zip)
