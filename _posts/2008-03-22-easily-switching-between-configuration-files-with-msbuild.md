---
ID: 220
post_title: >
  Easily switching between configuration
  files with MSBuild
author: timvw
post_date: 2008-03-22 18:40:58
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/03/22/easily-switching-between-configuration-files-with-msbuild/
published: true
---
<p>A couple of days ago i wrote about <a href="http://www.timvw.be/easily-switching-between-appconfig-files-with-msbuild/">Easily switching between App.Config files with MSBuild</a>. Christophe Gijbels, a fellow <a href="http://www.compuware.be/root/Careers/index.asp">compuwarrior</a>, pointed out that developers usually need to copy more than a single App.Config file... I would propose to add a Folder for each Customer that contains all the specific configuration files. Eg:</p>

<img src="http://www.timvw.be/wp-content/images/customerconfigurations.gif" alt="screenshot of solution explorer with proposed folder structures"/>

<p>Now i have to configure MSBuild so that the right files are copied into the <a href="http://msdn2.microsoft.com/en-us/library/bb629394.aspx">OutDir</a>:</p>

[code lang="xml"]<!-- Define the CustomerPath depending on the choosen Configuration -->
<propertyGroup  Condition=" $(Configuration) == 'Customer1 Debug' ">
 <customerPath>Customer1</customerPath>
</propertyGroup>
<propertyGroup  Condition=" $(Configuration) == 'Customer2 Debug' ">
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
</target>[/code]