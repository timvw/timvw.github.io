---
date: "2010-08-25T00:00:00Z"
guid: http://www.timvw.be/?p=1871
tags:
- MSBuild
title: Making the TemplateFileTask easier to use...
---
One of the disadvantages of the TemplateFile task ([msbuildtasks](http://msbuildtasks.tigris.org/)) is the fact that it requires a lot of typing to define template values

```xml
<ItemGroup Condition= " '$(ConfigurationEnvironment)'=='build' ">
	<Tokens Include="a">
		<ReplacementValue>localhost</ReplacementValue>
	</Tokens>
	<Tokens Include="b">
		<ReplacementValue><mynode/></ReplacementValue>
	</Tokens>
</ItemGroup>
```

Here is a format proposition to make this a lot more finger friendly

```xml
<configuration>
	<variables env="build">
		<x name="a">localhost</x>
		<x name="b><mynode/></x>
	</variables>
</configuration>
```

Here is the msbuild script we need to achieve that

```xml
<PropertyGroup>
	<ConfigurationFile>configuration.xml</ConfigurationFile>
	<ConfigurationEnvironment>build</ConfigurationEnvironment>
</PropertyGroup>

<!-- Retreive all template values for the specific environment -->
<XmlQuery XmlFileName="$(ConfigurationFile)" XPath = "//variables[@env='$(ConfigurationEnvironment)']/*">
	<Output TaskParameter="Values" ItemName="Values" />
</XmlQuery>

<-- Construct @Tokens -->
<ItemGroup>
	<Tokens Include="%(Values.name)">
		<ReplacementValue>%(Values._innerxml)</ReplacementValue>
	</Tokens>
</ItemGroup>

<!-- Generate the configuration files -->
<Message Text="Available variables:" />
<Message Text="====================" />
<Message Text="%(Tokens.Identity): %(Tokens.ReplacementValue)" />
```

Happy coding!
