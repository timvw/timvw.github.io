---
ID: 1504
post_title: Presenting FilterList
author: timvw
post_date: 2009-11-06 11:18:27
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/11/06/presenting-filterlist/
published: true
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
  - "1"
---
<p>Earlier today i decided to add 'Filtering' to my SortableBindingList. This resulted in writing a <a href="http://www.timvw.be/wp-content/code/csharp/FilterList.txt">FilterList</a> class. This class can be easily used as following:</p>

[code lang="csharp"]void textBoxFilter_KeyUp(object sender, KeyEventArgs e)
{
 var filterChars = this.textBoxFilter.Text.ToLower();
 this.Filter(filterChars);
}

void Filter(string filterChars)
{
 var persons = (FilterList<person>)this.dataGridView1.DataSource;
 persons.Filter(p => p.Firstname.ToLower().Contains(filterChars));
}[/code]

<p>I even created a screencast to demonstrate it:</p>

[mediaplayer src='http://www.timvw.be/screencasts/filterlist.wmv'  width=512 height=344]