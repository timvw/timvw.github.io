---
id: 39
title: Removing selected items from a ListBox
date: 2006-02-16T02:53:39+00:00
author: timvw
layout: post
guid: http://www.timvw.be/removing-selected-items-from-a-listbox/
permalink: /2006/02/16/removing-selected-items-from-a-listbox/
dsq_thread_id:
  - 1920134208
tags:
  - Visual Basic
  - Windows Forms
---
Today i was experimenting with a couple of windows controls. For some reason i wasn't able to remove the selected items from a [ListBox](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpref/html/frlrfsystemwindowsformslistboxmemberstopic.asp). Here is the code that didn't work

```vbnet
For Each index As Integer = ListBox1.SelectedIndices
	ListBox2.Items.Add(ListBox1.Items(index))
	ListBox1.Items.Remove(index)
End For
```

The problem is that when you remove an item from the collection the indices change. Here is a possible solution

```vbnet
Dim index As Integer = ListBox1.SelectedIndex
While index <> -1
	ListBox2.Items.Add(ListBox1.Items(index))
	ListBox1.Items.Remove(index)
	index = ListBox1.SelectedIndex
End While
```
