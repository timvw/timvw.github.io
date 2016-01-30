---
ID: 1947
post_title: >
  Build your solution with Visual Studio
  from MSBuild
author: timvw
post_date: 2010-11-07 20:16:36
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/11/07/build-your-solution-with-visual-studio-from-msbuild/
published: true
---
<p>Unfortunately MSBuild and <a href="http://bidshelper.codeplex.com/">BIDS Helper</a> are not able to build an .asdatabase from our Analysis Services project (.dwproj). Here is a task which invokes Visual Studio to build such a solution:</p>

[code lang="xml"]
&lt;Target Name=&quot;DevEnvBuild&quot;&gt;
 &lt;Error Condition=&quot;'$(SolutionFile)'==''&quot; Text=&quot;Missing SolutionFile&quot; /&gt;
 &lt;PropertyGroup&gt;
  &lt;DevEnvTool Condition=&quot;'$(DevEnvTool)'==''&quot;&gt;C:\Program Files\Microsoft Visual Studio 9.0\Common7\IDE\devenv.exe&lt;/DevEnvTool&gt;
  &lt;DevEnvSwitch Condition=&quot;'$(DevEnvSwitch)'==''&quot;&gt;Build&lt;/DevEnvSwitch&gt;
  &lt;DevEnvBuildCommand&gt;&quot;$(DevEnvTool)&quot; &quot;$(SolutionFile)&quot; /$(DevEnvSwitch)&lt;/DevEnvBuildCommand&gt;
 &lt;/PropertyGroup&gt;
 &lt;Exec Command=&quot;$(DevEnvBuildCommand)&quot; /&gt;
&lt;/Target&gt;
[/code]