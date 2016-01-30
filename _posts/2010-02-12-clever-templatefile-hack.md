---
ID: 1679
post_title: Clever TemplateFile hack
author: timvw
post_date: 2010-02-12 21:50:58
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/02/12/clever-templatefile-hack/
published: true
dsq_thread_id:
  - "1922710157"
---
<p>In my current project i use TemplateFileTask (<a href="http://msbuildtasks.tigris.org/">MSBuild Community Tasks Project</a>) to generate configuration files. I ran into the problem that i don't want to expose a MEX endpoint in production. This is my initial template file:</p>

[code behaviorconfiguration="DemoBehavior" name="DemoService.FileService" language="xml"]
 &lt;endpoint address=&quot;&quot; binding=&quot;ws2007HttpBinding&quot; contract=&quot;DemoService.IFileService&quot; /&gt;
 ${MexEndpoint}
&lt;/service&gt;[/code]

<p>And here is my initial msbuild task:</p>

[code toolsversion="3.5" defaulttargets="GenerateConfigFiles" xmlns="http://schemas.microsoft.com/developer/msbuild/2003" language="xml"]
&lt;Import Project=&quot;$(MSBuildExtensionsPath)\MSBuildCommunityTasks\MSBuild.Community.Tasks.Targets&quot;/&gt;
 &lt;Target Name=&quot;GenerateConfigFiles&quot;&gt;
  &lt;PropertyGroup&gt;
   &lt;MexEndpoint&gt;
    &lt;endpoint address=&quot;mex&quot; binding=&quot;mexHttpBinding&quot; contract=&quot;IMetadataExchange&quot; /&gt;
   &lt;/MexEndpoint&gt;
  &lt;/PropertyGroup&gt;

  &lt;PropertyGroup Condition=&quot; '$(Env)'=='Production' &quot;&gt;
   &lt;MexEndpoint&gt;&lt;/MexEndpoint&gt;
  &lt;/PropertyGroup&gt;

  &lt;ItemGroup&gt;
   &lt;Tokens Include=&quot;MexEndpoint&quot;&gt;
    &lt;ReplacementValue&gt;$(MexEndpoint)&lt;/ReplacementValue&gt;
   &lt;/Tokens&gt;
  &lt;/ItemGroup&gt;

  &lt;TemplateFile Template=&quot;Web.template.config&quot; OutputFileName=&quot;Web.config&quot; Tokens=&quot;@(Tokens)&quot; /&gt;
 &lt;/Target&gt;
&lt;/Project&gt;[/code]

<p>This results in the following configuration file: (WCF does not like the xml namespace declaration):</p>

[code behaviorconfiguration="DemoBehavior" name="DemoService.FileService" language="xml"]
 &lt;endpoint address=&quot;&quot; binding=&quot;ws2007HttpBinding&quot; contract=&quot;DemoService.IFileService&quot; /&gt;
 &lt;endpoint address=&quot;mex&quot; binding=&quot;mexHttpBinding&quot; contract=&quot;IMetadataExchange&quot; xmlns=&quot;http://schemas.microsoft.com/developer/msbuild/2003&quot; /&gt;
&lt;/service&gt;[/code]

<p>I noticed that a smart collegue of mine came up with the following template file:</p>

[code behaviorconfiguration="DemoBehavior" name="DemoService.FileService" language="xml"]
 &lt;endpoint address=&quot;&quot; binding=&quot;ws2007HttpBinding&quot; contract=&quot;DemoService.IFileService&quot; /&gt;
 &lt;${MexBegin}endpoint address=&quot;mex&quot; binding=&quot;mexHttpBinding&quot; contract=&quot;IMetadataExchange&quot; /${MexEnd}&gt;
&lt;/service&gt;[/code]

<p>And this is how he defines the MexBegin and MexEnd properties in msbuild:</p>

[code lang="csharp"]&lt;PropertyGroup&gt;
 &lt;MexBegin&gt;&lt;/MexBegin&gt;
 &lt;MexEnd&gt;&lt;/MexEnd&gt;
&lt;/PropertyGroup&gt;

&lt;PropertyGroup Condition=&quot; '$(Env)'=='Production' &quot;&gt;
 &lt;MexBegin&gt;!--&lt;/MexBegin&gt;
 &lt;MexEnd&gt;--&lt;/MexEnd&gt;
&lt;/PropertyGroup&gt;[/code]

<p>This leads to a nice MEX endpoint for all environments and in Production we get the following:</p>

[code lang="xml"]&lt;!--endpoint address=&quot;mex&quot; binding=&quot;mexHttpBinding&quot; contract=&quot;IMetadataExchange&quot; /--&gt;[/code]

<p>Perhaps it is cleaner to implement my own TemplateFileTask but untill then this clever hack does the job ;)</p>