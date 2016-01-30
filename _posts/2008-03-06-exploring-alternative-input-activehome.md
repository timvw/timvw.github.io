---
ID: 213
post_title: 'Exploring alternative input: ActiveHome'
author: timvw
post_date: 2008-03-06 17:59:13
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/03/06/exploring-alternative-input-activehome/
published: true
---
<p>A while ago i bought <a href="http://www.easycomputing.com/product.asp?ref=3655">Media Centerkit</a> for an euro or two. I wouldn't recommend the product because it comes with crappy software. Anyway, i was only interested in playing with the hardware (RF Remote and USB Receiver) so i downloaded the <a href="http://www.activehomepro.com/sdk/sdk-info.html">ActiveHome Professional SDK</a>. Once you install this you can add a reference to "ActiveHomeScript 1.0 Type Library" under the COM tab in Visual Studio. I wrote a little library so that i can consume the ActiveHomeClass.RecvAction in a Type-safe way:</p>
<img src="http://www.timvw.be/wp-content/images/activehomelibrary.png" alt="class diagram of activehome library"/>
<p>Here is some sample code that demonstrates how you can use the Notifier to receive Notifications:</p>
[code lang="csharp"]
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
}[/code]
<p>As always feel free to download the library and sample application: <a href="http://www.timvw.be/wp-content/code/csharp/ActiveHome.zip">ActiveHome.zip</a></p>