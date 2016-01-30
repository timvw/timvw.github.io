---
ID: 1121
post_title: >
  Small modification to achieve better
  modularity with Prism
author: timvw
post_date: 2009-07-11 15:29:10
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/07/11/modularity-with-prism/
published: true
---
<p>I have been experimenting with WPF and Prism (<a href="http://msdn.microsoft.com/en-us/library/cc707819.aspx">Composite Application Guidance for WPF and Silverlight</a>) and ran into a major issue: modularity. Here is an excerpt from the documentation:</p>

<blockquote>Modules have explicit boundaries, typically by subsystem or feature. Having these boundaries makes it easier for separate teams to develop modules. On large applications, teams may be organized by cross-cutting capabilities in addition to being organized by a specific subsystem or feature. For example, there may be a team assigned to shared components of the application, such as the shell or the common infrastructure module.</blockquote>

<p>The Modularity quick start solution uses the DirectoryModuleCatalog to discover modules. The module projects have a build event that copy their output to a single Modules folder:</p>

<pre>xcopy "$(TargetDir)*.*" "$(SolutionDir)DirectoryLookupModularity\$(OutDir)Modules\" /Y</pre>

<p>This means that if two modules output a file with the same name, one of the two will get lost :(. In order to avoid this we create a directory per module:</p>

<pre>xcopy "$(TargetDir)*.*" "$(SolutionDir)DirectoryLookupModularity\$(OutDir)Modules\$(TargetName)\" /Y</pre>

<p>To make this work we have to modify the catalog a little:</p>

[code lang="csharp"]protected override void InnerLoad()
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
 }
finally
{
  AppDomain.Unload(childDomain);
 }
}[/code]

<p>As long as we don't use (unsigned and different) assembly files with the same name in different modules we will have a working solution.</p>