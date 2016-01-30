---
ID: 39
post_title: Removing selected items from a ListBox
author: timvw
post_date: 2006-02-16 02:53:39
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/02/16/removing-selected-items-from-a-listbox/
published: true
dsq_thread_id:
  - "1920134208"
---
<p>Today i was experimenting with a couple of windows controls. For some reason i wasn't able to remove the selected items from a <a href="http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpref/html/frlrfsystemwindowsformslistboxmemberstopic.asp">ListBox</a>. Here is the code that didn't work:</p>
[code lang="vbnet"]
For Each index As Integer = ListBox1.SelectedIndices
  ListBox2.Items.Add(ListBox1.Items(index))
  ListBox1.Items.Remove(index)
End For
[/code]
<p>The problem is that when you remove an item from the collection the indices change. Here is a possible solution:</p>
[code lang="vbnet"]
Dim index As Integer = ListBox1.SelectedIndex
While index <> -1
  ListBox2.Items.Add(ListBox1.Items(index))
  ListBox1.Items.Remove(index)
  index = ListBox1.SelectedIndex
End While
[/code]