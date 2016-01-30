---
ID: 151
post_title: >
  Presenting the
  DataGridViewLargeTextBoxCell
author: timvw
post_date: 2007-01-27 01:34:33
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/01/27/presenting-the-datagridviewlargetextboxcell/
published: true
---
<p>Today i decided to experiment a bit with custom <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridviewcell.aspx">DataGridViewCell</a> implementations. If you insert large text into a DataGridView it will (at best) wrap the text. I wanted my DataGridView to behave like <a href="http://office.microsoft.com/excel/">Excel</a> so that the whole text is displayed. Here are a couple of screenshots of the result:</p>
<img src="http://www.timvw.be/wp-content/images/datagridviewlargetextboxcell-1.gif" alt="the large text flows over it's surrounding columns"/>
<img src="http://www.timvw.be/wp-content/images/datagridviewlargetextboxcell-2.gif" alt="the editingcontrol is resized to fit the complete text"/>
<p>Feel free to download <a href="http://www.timvw.be/wp-content/code/csharp/CustomDataGridViewCells.zip">CustomDataGridViewCells.zip</a>.</p>