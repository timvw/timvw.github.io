---
ID: 11
post_title: Inconsistent Drag and Drop API
author: timvw
post_date: 2006-09-16 02:05:04
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/09/16/inconsistent-drag-and-drop-api/
published: true
---
<p>Every System.Windows.Forms.Control has the following events:</p>

<ul>
<li>public event DragEventHandler <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.dragdrop.aspx">DragDrop</a></li>
<li>public event DragEventHandler <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.dragenter.aspx">DragEnter</a></li>
<li>public event EventHandler <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.dragleave.aspx">DragLeave</a></li>
<li>public event DragEventHandler <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.dragover.aspx">DragOver</a></li>
</ul>

<p>This means, when the user drags something away of the control, you can't access the data anymore (unless you cached it somewhere when the DragEnter or DragOver events occured). Here is an extract from Microsoft patterns and practives on <a href="http://msdn2.microsoft.com/en-us/library/ms229011.aspx">Event Design</a>:</p>

<blockquote>
<div>
If you define an event that takes an EventArgs instance instead of a derived class that you define, you cannot add data to the event in later versions. For that reason, it is preferable to create an empty derived class of EventArgs. This allows you add data to the event in later versions without introducing breaking changes.
</div>
</blockquote>