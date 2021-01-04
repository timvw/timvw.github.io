---
date: "2008-03-17T00:00:00Z"
tags:
- Visual Studio
title: Easily switching between App.Config files with MSBuild
aliases:
 - /2008/03/17/easily-switching-between-appconfig-files-with-msbuild/
 - /2008/03/17/easily-switching-between-appconfig-files-with-msbuild.html
---
Imagine the following situation: One codebase, two customers with different [Application Configuration files](http://msdn2.microsoft.com/en-us/library/kkz9kefa(VS.80).aspx). How can we easily switch between the different configurations? By taking advantage of the [Build Configurations](http://msdn2.microsoft.com/en-us/library/kkz9kefa(VS.80).aspx) functionality in Visual Studio we can easily switch between different configurations

![screenshot of the configuration manager in visual studio](http://www.timvw.be/wp-content/images/vsconfigurationmanager.gif)

A brute-force solution would be to add a [Post-build Event](http://msdn2.microsoft.com/en-us/library/42x5kfw4(VS.80).aspx) that copies the desired App.Config file to the destination directory. In the Microsoft.Common.targets file (usually at C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727) around line 725 you can read how [MSBuild](http://msdn2.microsoft.com/en-us/library/wea2sca5.aspx) chooses the App.Config that is copied to the destination folder

> Choose exactly one app.config to be the main app.config that is copied to the destination folder.  
> The search order is:
> 
>   1. Choose the value $(AppConfig) set in the main project.
>   2. Choose @(None) App.Config in the same folder as the project.
>   3. Choose @(Content) App.Config in the same folder as the project.
>   4. Choose @(None) App.Config in any subfolder in the project.
>   5. Choose @(Content) App.Config in any subfolder in the project.

Thus, simply setting $(AppConfig) should be enough to make sure that MSBuild chooses the appropriate App.Config file. Here is an example of a csproj section that defines $(AppConfig) as App.Customer1.Config or App.Customer2.Config depending on the choosen Build configuration

```xml 
<propertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug Customer1|AnyCPU' "> 
	<debugSymbols>true</debugSymbols>
	<debugType>full</debugType>
	<optimize>false</optimize>
	<outputPath>bin\Debug\</outputPath>
	<defineConstants>DEBUG;TRACE</defineConstants>
	<errorReport>prompt</errorReport>
	<warningLevel>4</warningLevel>
	<appConfig>App.Customer1.Config</appConfig> 
</propertyGroup> 
<propertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug Customer2|AnyCPU' "> 
	<debugSymbols>true</debugSymbols>
	<outputPath>bin\Debug Customer2\</outputPath>
	<defineConstants>DEBUG;TRACE</defineConstants>
	<debugType>full</debugType> <platformTarget>AnyCPU</platformTarget> <codeAnalysisUseTypeNameInSuppression>true</codeAnalysisUseTypeNameInSuppression>
	<codeAnalysisModuleSuppressionsFile>GlobalSuppressions.cs</codeAnalysisModuleSuppressionsFile>
	<errorReport>prompt</errorReport>
	<appConfig>App.Customer2.Config</appConfig> 
</propertyGroup> 
```
