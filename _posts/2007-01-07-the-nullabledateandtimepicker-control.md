---
id: 142
title: The NullableDateAndTimePicker Control
date: 2007-01-07T14:53:47+00:00
author: timvw
layout: post
guid: http://www.timvw.be/the-nullabledateandtimepicker-control/
permalink: /2007/01/07/the-nullabledateandtimepicker-control/
tags:
  - 'C#'
  - Windows Forms
---
A while ago i presented the concept of a [DateAndTimePicker](http://www.timvw.be/a-dateandtimepicker-control/). Today someone asked if it's possible to give the user an option to 'not choose a DateTime'. I created a UserControl that has both a DateAndTimePicker and a CheckBox with a Value property of Nullable<DateTime>.

![screenshot of the nullable dateandtimepicker](http://www.timvw.be/wp-content/images/dateandtimepicker-nullable-1.gif)

![screenshot of the nullable dateandtimepicker](http://www.timvw.be/wp-content/images/dateandtimepicker-nullable-2.gif)

Feel free to download the updated [DateAndTimePicker.zip](http://www.timvw.be/wp-content/code/csharp/DateAndTimePicker.zip).