---
id: 151
title: Presenting the DataGridViewLargeTextBoxCell
date: 2007-01-27T01:34:33+00:00
author: timvw
layout: post
guid: http://www.timvw.be/presenting-the-datagridviewlargetextboxcell/
permalink: /2007/01/27/presenting-the-datagridviewlargetextboxcell/
dsq_thread_id:
  - 1933325495
tags:
  - 'C#'
  - Windows Forms
---
Today i decided to experiment a bit with custom [DataGridViewCell](http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridviewcell.aspx) implementations. If you insert large text into a DataGridView it will (at best) wrap the text. I wanted my DataGridView to behave like [Excel](http://office.microsoft.com/excel/) so that the whole text is displayed. Here are a couple of screenshots of the result

![the large text flows over it's surrounding columns](http://www.timvw.be/wp-content/images/datagridviewlargetextboxcell-1.gif)
  
![the editingcontrol is resized to fit the complete text](http://www.timvw.be/wp-content/images/datagridviewlargetextboxcell-2.gif)

Feel free to download [CustomDataGridViewCells.zip](http://www.timvw.be/wp-content/code/csharp/CustomDataGridViewCells.zip).
