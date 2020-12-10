---
title: What i dislike about the Web.config Transformation in VS2010
layout: post
guid: http://www.timvw.be/?p=1880
dsq_thread_id:
  - 1922954609
tags:
  - MSBuild
  - Visual Studio
---
There are a couple of things that i strongly dislike about the [Web.config transformation in VS2010](http://blogs.msdn.com/b/webdevtools/archive/2009/05/04/web-deployment-web-config-transformation.aspx)

* Only works with XML files (eg: Can't be used to generate a release notes.txt file)
* <del datetime="2010-08-26T08:05:21+00:00">Does not seem to support externalized sections, eg: log4net.config in a separate file</del>
* <del datetime="2010-08-26T08:05:21+00:00">No support to copy/paste transform files</del>
* Only works when Visual Studio 2010 is installed (And i am still not convinced a build server should have this).
* Ties environment to build configuration

**Lesson learned: Don't trust your co-workers, always double-check!**

* Having multiple transformations is easy-peasy, just invoke the TransformXml task for all your config files and make sure your transformation files are correct. For log4net this would look like

```xml
<log4net xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
	<root>
		<level value="ERROR" xdt:Transform="Replace"/>
	</root>
</log4net>
```

* The support for copy/paste can be achieved by removing the DependentUpon tag in your proj file (At the cost that you do not have the + sign in solution explorer which 'hides' the transforms files)
