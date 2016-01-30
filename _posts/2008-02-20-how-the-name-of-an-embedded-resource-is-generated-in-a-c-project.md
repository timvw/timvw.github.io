---
ID: 206
post_title: 'How the name of an embedded resource is generated in a C# project'
author: timvw
post_date: 2008-02-20 19:32:04
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/02/20/how-the-name-of-an-embedded-resource-is-generated-in-a-c-project/
published: true
---
<p>A while ago i was wondering how the name of an embedded resource is generated in a C&#35; project. Earlier today i was looking in Microsoft.CSharp.targets and found the answer:</p>
<blockquote><pre>
The CreateManifestResourceNames target create the manifest resource names from the .RESX files.

[IN]
@(ResxWithNoCulture) - The names the non-culture .RESX files.
@(ResxWithCulture) - The names the culture .RESX files.
@(NonResxWithNoCulture) - The names of the non-culture non-RESX files (like bitmaps, etc).
@(NonResxWithCulture) - The names of the culture non-RESX files (like bitmaps, etc).

[OUT]
@(ManifestResourceWithNoCultureName) - The corresponding manifest resource name (.RESOURCE)
@(ManifestResourceWithCultureName) - The corresponding manifest resource name (.RESOURCE)
@(ManifestNonResxWithNoCulture) - The corresponding manifest resource name.
@(ManifestNonResxWithCulture) - The corresponding manifest resource name.

For C# applications the transformation is like:

Resources1.resx => RootNamespace.Resources1 => Build into main assembly
SubFolder\Resources1.resx => RootNamespace.SubFolder.Resources1 => Build into main assembly
Resources1.fr.resx => RootNamespace.Resources1.fr => Build into satellite assembly
Resources1.notaculture.resx => RootNamespace.Resources1.notaculture => Build into main assembly

For other project systems, this transformation may be different.
</pre></blockquote>

<p>With <a href="http://www.attrice.info/msbuild/index.htm">Attrice Corporation Microsoft Build Sidekick v2</a> you can easily visualize the flow throughout the targets via Tools -> View Targets Diagram.</p>