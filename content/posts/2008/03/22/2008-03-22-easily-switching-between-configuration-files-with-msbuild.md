---
date: "2008-03-22T00:00:00Z"
tags:
- Visual Studio
title: Easily switching between configuration files with MSBuild
aliases:
 - /2008/03/22/easily-switching-between-configuration-files-with-msbuild/
 - /2008/03/22/easily-switching-between-configuration-files-with-msbuild.html
---
A couple of days ago i wrote about [Easily switching between App.Config files with MSBuild](http://www.timvw.be/easily-switching-between-appconfig-files-with-msbuild/). Christophe Gijbels, a fellow [compuwarrior](http://www.compuware.be/root/Careers/index.asp), pointed out that developers usually need to copy more than a single App.Config file... I would propose to add a Folder for each Customer that contains all the specific configuration files. Eg

![screenshot of solution explorer with proposed folder structures](http://www.timvw.be/wp-content/images/customerconfigurations.gif)

Now i have to configure MSBuild so that the right files are copied into the [OutDir](http://msdn2.microsoft.com/en-us/library/bb629394.aspx):

```xml
<!-- Define the CustomerPath depending on the choosen Configuration -->
<propertyGroup Condition=" $(Configuration) == 'Customer1 Debug' "> 
	<customerPath>Customer1</customerPath> 
</propertyGroup> 
<propertyGroup Condition=" $(Configuration) == 'Customer2 Debug' "> 
	<customerPath>Customer2</customerPath> 
</propertyGroup> 

<!-- Define AppConfig in the CustomerPath  -->
<propertyGroup>
	<appConfig>$(CustomerPath)\App.config</appConfig> 
</propertyGroup> 

<!-- Find all files in CustomerPath, excluding AppConfig -->
<itemGroup>
	<customerFiles Include="$(CustomerPath)\*.*" Exclude="$(CustomerPath)\App.config" />
</itemGroup>

<target Name="AfterBuild">
	<copy SourceFiles="@(CustomerFiles)" DestinationFolder="$(OutDir)" SkipUnchangedFiles="true"/>
</target>
```
