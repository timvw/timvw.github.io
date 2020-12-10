---
title: Small modification to achieve better modularity with Prism
layout: post
guid: http://www.timvw.be/?p=1121
tags:
  - 'C#'
---
I have been experimenting with WPF and Prism ([Composite Application Guidance for WPF and Silverlight](http://msdn.microsoft.com/en-us/library/cc707819.aspx)) and ran into a major issue: modularity. Here is an excerpt from the documentation

> Modules have explicit boundaries, typically by subsystem or feature. Having these boundaries makes it easier for separate teams to develop modules. On large applications, teams may be organized by cross-cutting capabilities in addition to being organized by a specific subsystem or feature. For example, there may be a team assigned to shared components of the application, such as the shell or the common infrastructure module.

The Modularity quick start solution uses the DirectoryModuleCatalog to discover modules. The module projects have a build event that copy their output to a single Modules folder

```xml 
xcopy "$(TargetDir)*.*" "$(SolutionDir)DirectoryLookupModularity\$(OutDir)Modules\" /Y
```

This means that if two modules output a file with the same name, one of the two will get lost :(. In order to avoid this we create a directory per module

```xml
xcopy "$(TargetDir)*.*" "$(SolutionDir)DirectoryLookupModularity\$(OutDir)Modules\$(TargetName)\" /Y
```

To make this work we have to modify the catalog a little

```csharp
protected override void InnerLoad()
{
	if (string.IsNullOrEmpty(this.ModulePath))
		throw new InvalidOperationException(Resources.ModulePathCannotBeNullOrEmpty);

	if (!Directory.Exists(this.ModulePath))
		throw new InvalidOperationException(string.Format(CultureInfo.CurrentCulture, Resources.DirectoryNotFound, this.ModulePath));

	foreach (var assemblyFile in Directory.GetFiles(this.ModulePath, "*.dll", SearchOption.AllDirectories))
	{
		var privateBinPath = Path.GetFullPath(Path.GetDirectoryName(assemblyFile));
		var childDomain = this.BuildChildDomain(AppDomain.CurrentDomain, privateBinPath);

		try
		{
			var loaderType = typeof(InnerModuleInfoLoader);
			if (loaderType.Assembly == null) continue;
			var loader = (InnerModuleInfoLoader)childDomain.CreateInstanceFromAndUnwrap(loaderType.Assembly.Location, loaderType.FullName);
			loader.LoadAssembly(assemblyFile);
			this.Items.AddRange(loader.GetModuleInfos());
		}		
		finally
		{
			AppDomain.Unload(childDomain);
		}
	}
}
```

As long as we don't use (unsigned and different) assembly files with the same name in different modules we will have a working solution.
