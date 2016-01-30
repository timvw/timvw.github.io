---
ID: 2216
post_title: >
  Use SQL Server Profiler to see if a
  connection is pooled
author: timvw
post_date: 2011-08-19 00:13:27
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/08/19/use-sql-server-profiler-to-see-if-a-connection-is-pooled/
published: true
dsq_thread_id:
  - "1929244854"
---
<p>It took me a couple of websearches to discover how i can see in SQL Server Profiler whether or not a connection is pooled. Apparently you have to check 'Show all columns' and then you can check the 'EventSubClass' column:</p>

<a href="http://www.timvw.be/wp-content/uploads/2011/08/sql_server_profiler_eventsubclass.png"><img src="http://www.timvw.be/wp-content/uploads/2011/08/sql_server_profiler_eventsubclass.png" alt="" title="sql_server_profiler_eventsubclass" width="847" height="536" class="alignnone size-full wp-image-2217" /></a>

<p>This is how it looks like in your trace window:</p>

<a href="http://www.timvw.be/wp-content/uploads/2011/08/sql_server_profiler_eventsubclass_trace.png"><img src="http://www.timvw.be/wp-content/uploads/2011/08/sql_server_profiler_eventsubclass_trace.png" alt="" title="sql_server_profiler_eventsubclass_trace" width="769" height="407" class="alignnone size-full wp-image-2221" /></a>