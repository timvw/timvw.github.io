---
date: "2010-06-26T00:00:00Z"
guid: http://www.timvw.be/?p=1779
tags:
- MSBuild
title: Setting up a self-contained build
aliases:
 - /2010/06/26/setting-up-a-self-contained-build/
 - /2010/06/26/setting-up-a-self-contained-build.html
---
Here is something you may have experienced already: As a newcomer on an existing project, you check out the code from source-control and discover that the build is broken. When you ask around no-one else seems to have that problem but a helpful collegue is kind enough to tell you that you can find the installers for the missing dependencies at location X (Let's not even mention the places where those installers are not available \*sigh\*).

Anway, in order to avoid such a situation you could organize your solution in such a way that all the dependencies (libraries and tools) are part of it. A typical folder structure would look like this:

![screenshot of typical solution folder organization](http://www.timvw.be/wp-content/images/solution_tools.png)

In order to get those files out of the installer and in your solution (instead of installed under %Program Files%) you could do an administrative install of the msi (eg: msiexec /a Blah.msi) but i find it easier to use [Qwerty.Msi](http://www.qwerty-msi.com/).

Here are a couple of settings you may want to add to your build configuration in order to make your self-contained build work

```xml
<!-- Configure solution directories -->
<basePath Condition="'$(BasePath)'==''">$(MSBuildThisFileDirectory)..</basePath>
<buildPath>$(BasePath)\build</buildPath><sourcePath>$(BasePath)\src</sourcePath>
<toolsPath>$(BasePath)\tools</toolsPath>

<!-- Configure tool directories -->
<!-- the ending \ is required for the extension pack -->
<extensionTasksPath>$(ToolsPath)\MSBuild.ExtensionPack\</extensionTasksPath>
<msbuildCommunityTasksPath>$(ToolsPath)\MSBuildCommunityTasks</msbuildCommunityTasksPath>
<ilmergeToolPath>$(ToolsPath)\ILMerge</ilmergeToolPath>
<svnToolPath>$(ToolsPath)\Subversion\bin</svnToolPath>
<!-- wix will use this property to determine the location of other files -->
<wixToolPath>$(ToolsPath)\Wix</wixToolPath>

<!-- Configure target file paths -->
<commonTargetsPath>$(BuildPath)\common.targets</commonTargetsPath>
<msbuildCommunityTasksTargetsPath>$(MSBuildCommunityTasksPath)\MSBuild.Community.Tasks.Targets</msbuildCommunityTasksTargetsPath>
<extensionPackTargetsPath>$(ExtensionTasksPath)MSBuild.ExtensionPack.tasks</extensionPackTargetsPath>

<!-- Configure WIX -->
<wixTargetsPath>$(WixToolPath)\Wix.targets</wixTargetsPath>
<wixTasksPath>$(WixToolPath)\WixTasks.dll</wixTasksPath>
<wixTargetsPath>$(WixToolPath)\Wix.targets</wixTargetsPath>
<wixTasksPath>$(WixToolPath)\WixTasks.dll</wixTasksPath>
<luxTargetsPath>$(WixToolPath)\Lux.targets</luxTargetsPath>
<luxTasksPath>$(WixToolPath)\LuxTasks.dll</luxTasksPath>
<luxTargetsPath>$(WixToolPath)\Lux.targets</luxTargetsPath>
<luxTasksPath>$(WixToolPath)\LuxTasks.dll</luxTasksPath>
```

With this solution in place the next 'new guy' does not have to waste time trying to figure out where those dependencies are ;)
