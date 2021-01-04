---
date: "2010-06-26T00:00:00Z"
guid: http://www.timvw.be/?p=1766
tags:
- MSBuild
title: Convention over configuration with MSBuild
aliases:
 - /2010/06/26/convention-over-configuration-with-msbuild/
 - /2010/06/26/convention-over-configuration-with-msbuild.html
---
A while ago i blogged that i was using the TemplateFile task from the <a hrefhttp://msbuildtasks.tigris.org/">MSBuild Community Tasks Project</a> to generate configuration files. Each project that required templating would have modified it's csproj file as following

```xml
<!-- To modify your build process, add your task inside one of the targets below and uncomment it.
Other similar extension points exist, see Microsoft.Common.targets. -->
<import Project="$(MSBuildProjectDirectory)\config.msbuild" />
<target Name="BeforeBuild">
	<callTarget Targets="GenerateConfigurationFiles" />
</target>
```

And each of these config.msbuild files looked as following

```xml 
<templateFile Template="web.template.config" OutputFileName="web.config" Tokens="@(TemplateTokens)" />
<templateFile Template="Config\WcfClients.config" OutputFileName="Config\WcfClients.config" Tokens="@(TemplateTokens)" />
```

As you can notice the convention here is that each template file has '.template.' in it's name, and the name of an output file is the template file name without '.template.'.

```xml
<!-- validate input -->
<error Condition="'$(SourceFile)'==''" Text="Missing SourceFile" />

<!-- calculate destination file -->
<regexReplace Input="$(SourceFile)" Expression="(\.template)\." Replacement="." Count="1">
	<output TaskParameter="Output" PropertyName="DestinationFile" />
</regexReplace>

<!-- generate file -->
<templateFile Template="$(SourceFile)" OutputFileName="$(DestinationFile)" Tokens="@(TemplateTokens)" />
```

Now that we can do it for one file, we can do it for many files too

```xml 
<!-- valide input -->
<error Condition="'$(SourceDir)'==''" Text="Missing SourceDir" />

<!-- find all template files -->
<itemGroup>
	<templateFiles Include="$(SourceDir)\*\*\\*.template.\*" Exlude="$(SourceDir)\\*\*\\*.svn*" />
</itemGroup>

<!-- process each template file -->
<msbuild Projects="$(MSBuildProjectFile)" Targets="ProcessTemplate" Properties="SourceFile=%(TemplateFiles.FullPath)" />
```

After these core improvements we wrote a common.proj.targets file as following

```xml 
<!-- import global variables -->
<import Project="$(MSBuildThisFileDirectory)\configuration.proj" />
<propertyGroup>
	<buildDependsOn>CommonBeforeBuild;$(BuildDependsOn);CommonAfterBuild</buildDependsOn> 
</propertyGroup> 

<target Name="CommonBeforeBuild">
	<msbuild Projects="$(CommonTargetsPath)" Targets="ProcessTemplates" Properties="SourceDir=$(MSBuildProjectDirectory)" />
</target>

<target Name="CommonAfterBuild">
	<!--<msbuild Projects="$(CommonBuildTargetsPath)" Targets="PEVerify" Properties="SourceFile=$(TargetPath)" />-->
</target> 
```

Now we only need to import our common.proj.targets file in projects that have template files and focus on real business problems ;)
