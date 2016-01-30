---
ID: 1880
post_title: >
  What i dislike about the Web.config
  Transformation in VS2010
author: timvw
post_date: 2010-08-25 20:34:15
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/08/25/what-i-dislike-about-the-web-config-transformation-in-vs2010/
published: true
dsq_thread_id:
  - "1922954609"
---
<p>There are a couple of things that i strongly dislike about the <a href="http://blogs.msdn.com/b/webdevtools/archive/2009/05/04/web-deployment-web-config-transformation.aspx">Web.config transformation in VS2010</a>:</p>

<ul>
<li>Only works with XML files (eg: Can't be used to generate a release notes.txt file)</li>
<li><del datetime="2010-08-26T08:05:21+00:00">Does not seem to support externalized sections, eg: log4net.config in a separate file</del></li>
<li><del datetime="2010-08-26T08:05:21+00:00">No support to copy/paste transform files</del></li>
<li>Only works when Visual Studio 2010 is installed (And i am still not convinced a build server should have this).</li>
<li>Ties environment to build configuration</li>
</ul>

<p><b>Lesson learned: Don't trust your co-workers, always double-check!</b></p>

<ul>
<li>Having multiple transformations is easy-peasy, just invoke the TransformXml task for all your config files and make sure your transformation files are correct. For log4net this would look like:</li>

[code lang="xml"]
&lt;log4net xmlns:xdt=&quot;http://schemas.microsoft.com/XML-Document-Transform&quot;&gt;
 &lt;root&gt;
  &lt;level value=&quot;ERROR&quot; xdt:Transform=&quot;Replace&quot;/&gt;
 &lt;/root&gt;
&lt;/log4net&gt;
[/code]

<li>The support for copy/paste can be achieved by removing the DependentUpon tag in your proj file (At the cost that you don't have the + sign in solution explorer which 'hides' the transforms files)</li>
</ul>