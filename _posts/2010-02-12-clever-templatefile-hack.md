---
id: 1679
title: Clever TemplateFile hack
date: 2010-02-12T21:50:58+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1679
permalink: /2010/02/12/clever-templatefile-hack/
dsq_thread_id:
  - 1922710157
tags:
  - MSBuild
---
In my current project i use TemplateFileTask ([MSBuild Community Tasks Project](http://msbuildtasks.tigris.org/)) to generate configuration files. I ran into the problem that i don't want to expose a MEX endpoint in production. This is my initial template file

```xml
<service behaviorconfiguration="DemoBehavior" name="DemoService.FileService">
	<endpoint address="" binding="ws2007HttpBinding" contract="DemoService.IFileService" />
	${MexEndpoint}
</service>
```

And here is my initial msbuild task

```xml
<Project ToolsVersion="3.5" dDfaultTargets="GenerateConfigFiles" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
	<Import Project="$(MSBuildExtensionsPath)\MSBuildCommunityTasks\MSBuild.Community.Tasks.Targets"/>
	<Target Name="GenerateConfigFiles">
		<PropertyGroup>
			<MexEndpoint>
				<endpoint address="mex" binding="mexHttpBinding" contract="IMetadataExchange" />
			</MexEndpoint>
		</PropertyGroup>

		<PropertyGroup Condition=" '$(Env)'=='Production' ">
			<MexEndpoint></MexEndpoint>
		</PropertyGroup>

		<ItemGroup>
			<Tokens Include="MexEndpoint">
				<ReplacementValue>$(MexEndpoint)</ReplacementValue>
			</Tokens>
		</ItemGroup>

		<TemplateFile Template="Web.template.config" OutputFileName="Web.config" Tokens="@(Tokens)" />
	</Target>
</Project>
```

This results in the following configuration file: (WCF does not like the xml namespace declaration):

```xml
<service behaviorconfiguration="DemoBehavior" name="DemoService.FileService">
	<endpoint address="" binding="ws2007HttpBinding" contract="DemoService.IFileService" />
	<endpoint address="mex" binding="mexHttpBinding" contract="IMetadataExchange" xmlns="http://schemas.microsoft.com/developer/msbuild/2003" />
</service>
```

I noticed that a smart collegue of mine came up with the following template file:

```xml
<service behaviorconfiguration="DemoBehavior" name="DemoService.FileService">
	<endpoint address="" binding="ws2007HttpBinding" contract="DemoService.IFileService" />
	<${MexBegin}endpoint address="mex" binding="mexHttpBinding" contract="IMetadataExchange" /${MexEnd}>
</service>
```

And this is how he defines the MexBegin and MexEnd properties in msbuild:

```xml
<PropertyGroup>
	<MexBegin></MexBegin>
	<MexEnd></MexEnd>
</PropertyGroup>

<PropertyGroup Condition=" '$(Env)'=='Production' ">
	<MexBegin>!--</MexBegin>
	<MexEnd>--</MexEnd>
</PropertyGroup>
```

This leads to a nice MEX endpoint for all environments and in Production we get the following:

```xml
<!--endpoint address="mex" binding="mexHttpBinding" contract="IMetadataExchange" /-->
```

Perhaps it is cleaner to implement my own TemplateFileTask but untill then this clever hack does the job.
