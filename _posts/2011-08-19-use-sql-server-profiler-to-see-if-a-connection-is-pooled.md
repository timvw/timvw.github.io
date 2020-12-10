---
title: Use SQL Server Profiler to see if a connection is pooled
layout: post
guid: http://www.timvw.be/?p=2216
categories:
  - Uncategorized
tags:
  - pooling
  - profiler
  - SQL
---
It took me a couple of websearches to discover how i can see in SQL Server Profiler whether or not a connection is pooled. Apparently you have to check 'Show all columns' and then you can check the 'EventSubClass' column:

[<img src="http://www.timvw.be/wp-content/uploads/2011/08/sql_server_profiler_eventsubclass.png" alt="" title="sql_server_profiler_eventsubclass" width="847" height="536" class="alignnone size-full wp-image-2217" srcset="http://www.timvw.be/wp-content/uploads/2011/08/sql_server_profiler_eventsubclass.png 847w, http://www.timvw.be/wp-content/uploads/2011/08/sql_server_profiler_eventsubclass-300x189.png 300w" sizes="(max-width: 847px) 100vw, 847px" />](http://www.timvw.be/wp-content/uploads/2011/08/sql_server_profiler_eventsubclass.png)

This is how it looks like in your trace window:

[<img src="http://www.timvw.be/wp-content/uploads/2011/08/sql_server_profiler_eventsubclass_trace.png" alt="" title="sql_server_profiler_eventsubclass_trace" width="769" height="407" class="alignnone size-full wp-image-2221" srcset="http://www.timvw.be/wp-content/uploads/2011/08/sql_server_profiler_eventsubclass_trace.png 769w, http://www.timvw.be/wp-content/uploads/2011/08/sql_server_profiler_eventsubclass_trace-300x158.png 300w" sizes="(max-width: 769px) 100vw, 769px" />](http://www.timvw.be/wp-content/uploads/2011/08/sql_server_profiler_eventsubclass_trace.png)