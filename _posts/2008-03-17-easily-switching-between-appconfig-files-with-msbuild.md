---
ID: 217
post_title: >
  Easily switching between App.Config
  files with MSBuild
author: timvw
post_date: 2008-03-17 20:04:03
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/03/17/easily-switching-between-appconfig-files-with-msbuild/
published: true
dsq_thread_id:
  - "1920274229"
---
<p>Imagine the following situation: One codebase, two customers with different <a href="http://msdn2.microsoft.com/en-us/library/kkz9kefa(VS.80).aspx">Application Configuration files</a>. How can we easily switch between the different configurations? By taking advantage of the <a href="http://msdn2.microsoft.com/en-us/library/kkz9kefa(VS.80).aspx">Build Configurations</a> functionality in Visual Studio we can easily switch between different configurations:</p>

<img src="http://www.timvw.be/wp-content/images/vsconfigurationmanager.gif" alt="screenshot of the configuration manager in visual studio"/>

<p>A brute-force solution would be to add a <a href="http://msdn2.microsoft.com/en-us/library/42x5kfw4(VS.80).aspx">Post-build Event</a> that copies the desired App.Config file to the destination directory. In the Microsoft.Common.targets file (usually at C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727) around line 725 you can read how <a href="http://msdn2.microsoft.com/en-us/library/wea2sca5.aspx">MSBuild</a> chooses the App.Config that is copied to the destination folder:</p>
<blockquote>
<p>Choose exactly one app.config to be the main app.config that is copied to the destination folder.<br/>
The search order is:</p>
<ol>
<li>Choose the value $(AppConfig) set in the main project.</li>
<li>Choose @(None) App.Config in the same folder as the project.</li>
<li>Choose @(Content) App.Config in the same folder as the project.</li>
<li>Choose @(None) App.Config in any subfolder in the project.</li>
<li>Choose @(Content) App.Config in any subfolder in the project.</li>
</ol>
</blockquote>

<p>Thus, simply setting $(AppConfig) should be enough to make sure that MSBuild chooses the appropriate App.Config file. Here is an example of a csproj section that defines $(AppConfig) as App.Customer1.Config or App.Customer2.Config depending on the choosen Build configuration:</p>

[code lang="xml"]
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
 <debugType>full</debugType>
 <platformTarget>AnyCPU</platformTarget>
 <codeAnalysisUseTypeNameInSuppression>true</codeAnalysisUseTypeNameInSuppression>
 <codeAnalysisModuleSuppressionsFile>GlobalSuppressions.cs</codeAnalysisModuleSuppressionsFile>
 <errorReport>prompt</errorReport>
 <appConfig>App.Customer2.Config</appConfig>
  </propertyGroup>
[/code]