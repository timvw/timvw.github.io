---
id: 133
title: A DateAndTimePicker control
date: 2006-12-18T00:13:15+00:00
author: timvw
layout: post
guid: http://www.timvw.be/a-dateandtimepicker-control/
permalink: /2006/12/18/a-dateandtimepicker-control/
tags:
  - 'C#'
  - Windows Forms
---
The [DateTimePicker](http://msdn2.microsoft.com/en-us/library/system.windows.forms.datetimepicker.aspx) control allows the user to input a Date or a Time. The problem is that you can't let the user pick both a date and a time with one instance of the control (unless you set the CustomFormat property and give up the 'nice' ui) so i decided to build my own DateAndTimePicker control

![screenshot of the dateandtimepicker control](http://www.timvw.be/wp-content/images/dateandtimepicker.jpg)

Feel free to download and extended the [DateAndTimePicker.zip](http://www.timvw.be/wp-content/code/csharp/DateAndTimePicker.zip).
