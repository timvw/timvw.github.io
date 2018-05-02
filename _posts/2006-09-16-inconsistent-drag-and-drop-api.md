---
id: 11
title: Inconsistent Drag and Drop API
date: 2006-09-16T02:05:04+00:00
author: timvw
layout: post
guid: http://www.timvw.be/inconsistent-drag-and-drop-api/
permalink: /2006/09/16/inconsistent-drag-and-drop-api/
tags:
  - 'C#'
  - Windows Forms
---
Every System.Windows.Forms.Control has the following events

* public event DragEventHandler [DragDrop](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.dragdrop.aspx)
* public event DragEventHandler [DragEnter](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.dragenter.aspx)
* public event EventHandler [DragLeave](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.dragleave.aspx)
* public event DragEventHandler [DragOver](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.dragover.aspx)

This means, when the user drags something away of the control, you can't access the data anymore (unless you cached it somewhere when the DragEnter or DragOver events occured). Here is an extract from Microsoft patterns and practives on [Event Design](http://msdn2.microsoft.com/en-us/library/ms229011.aspx)

> <div>
>   If you define an event that takes an EventArgs instance instead of a derived class that you define, you cannot add data to the event in later versions. For that reason, it is preferable to create an empty derived class of EventArgs. This allows you add data to the event in later versions without introducing breaking changes.
> </div>