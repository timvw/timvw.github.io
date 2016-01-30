---
ID: 211
post_title: >
  Display WorkItems in a WinForms
  application
author: timvw
post_date: 2008-02-29 20:51:10
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/02/29/display-workitems-in-a-winforms-application/
published: true
---
<p>Using the Microsoft.TeamFoundation.WorkItemTracking.Controls assembly it is possibe to display WorkItems. Here is a little demo application that will display all the WorkItems that have been changed by one of the given users in the given range:</p>
<img src="http://www.timvw.be/wp-content/images/workitemtracker.gif" alt="screenshot of workitemtracker application"/>
<p>Feel free to download the source: <a href="http://www.timvw.be/wp-content/code/csharp/WorkItemTracker.zip">WorkItemTracker.zip</a></p>

<p>
<b>Edit (05/03/2008): </b><br/>
Refactored the code a little and added some features like sortable columns, loading default tfsserver and users from App.Config, ...
</p>