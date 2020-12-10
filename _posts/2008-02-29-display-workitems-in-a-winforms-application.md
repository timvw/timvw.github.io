---
title: Display WorkItems in a WinForms application
layout: post
tags:
  - 'C#'
  - Windows Forms
---
Using the Microsoft.TeamFoundation.WorkItemTracking.Controls assembly it is possibe to display WorkItems. Here is a little demo application that will display all the WorkItems that have been changed by one of the given users in the given range

![screenshot of workitemtracker application](http://www.timvw.be/wp-content/images/workitemtracker.gif)

Feel free to download the source: [WorkItemTracker.zip](http://www.timvw.be/wp-content/code/csharp/WorkItemTracker.zip)

**Edit (05/03/2008):** 
  
Refactored the code a little and added some features like sortable columns, loading default tfsserver and users from App.Config, ...
