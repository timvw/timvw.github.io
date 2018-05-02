---
id: 1504
title: Presenting FilterList
date: 2009-11-06T11:18:27+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1504
permalink: /2009/11/06/presenting-filterlist/
enclosure:
  - |
    |
        http://www.timvw.be/screencasts/filterlist.wmv
        357569
        video/x-ms-wmv
        
  - |
    http://www.timvw.be/screencasts/filterlist.wmv
    357569
    video/x-ms-wmv
  - |
    http://www.timvw.be/screencasts/filterlist.wmv
    357569
    video/x-ms-wmv
  - |
    http://www.timvw.be/screencasts/filterlist.wmv
    357569
    video/x-ms-wmv
wp_media_player:
  - 1
dsq_thread_id:
  - 1933325256
tags:
  - 'C#'
  - Windows Forms
---
Earlier today i decided to add 'Filtering' to my SortableBindingList. This resulted in writing a [FilterList](http://www.timvw.be/wp-content/code/csharp/FilterList.txt) class. This class can be easily used as following

```csharp
void textBoxFilter_KeyUp(object sender, KeyEventArgs e)
{
	var filterChars = this.textBoxFilter.Text.ToLower();
	this.Filter(filterChars);
}

void Filter(string filterChars)
{
	var persons = (FilterList<person>)this.dataGridView1.DataSource;
	persons.Filter(p => p.Firstname.ToLower().Contains(filterChars));
}
```

I even created a screencast to demonstrate it:

[mediaplayer src='http://www.timvw.be/screencasts/filterlist.wmv' width=512 height=344]
