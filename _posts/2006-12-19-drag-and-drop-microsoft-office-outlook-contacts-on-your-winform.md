---
id: 135
title: Drag and Drop Microsoft Office Outlook Contacts on your WinForm
date: 2006-12-19T23:44:23+00:00
author: timvw
layout: post
guid: http://www.timvw.be/drag-and-drop-microsoft-office-outlook-contacts-on-your-winform/
permalink: /2006/12/19/drag-and-drop-microsoft-office-outlook-contacts-on-your-winform/
tags:
  - 'C#'
  - Windows Forms
---
Earlier today i saw someone that wanted to know how to drag and drop Microsoft Office Outlook Contacts on his winform (and get the data of the contact). Here are the few lines of code that do what he asked for

```csharp
// in the constructor of the form (or in the InitializeComponent method if you set it via the Designer)
this.AllowDrop = true;

// handle the DragOver event
private void Form1_DragOver(object sender, DragEventArgs e)
{
	e.Effect = DragDropEffects.All;
}

// handle the DragDrop event
private void Form1_DragDrop(object sender, DragEventArgs e)
{
	string text = (string)e.Data.GetData("Text", true);
	this.label1.Text = text;

	// for more finegrained access to the data
	//string[] lines = text.Split(new string[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
}
```
  

  
![screenshot of outlook contact that was dragged and dropped on the form](http://www.timvw.be/wp-content/images/outlookcontactdragdrop.jpg)
