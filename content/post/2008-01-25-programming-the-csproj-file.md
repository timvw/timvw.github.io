---
date: "2008-01-25T00:00:00Z"
tags:
- C#
title: Programming the csproj file
aliases:
 - /2008/01/25/programming-the-csproj-file/
 - /2008/01/25/programming-the-csproj-file.html
---
Imagine that you have a couple of project files that reference framework libraries that are on a buildserver. Upgrading to a newer version requires that you update all the references... I wrote some wrapper classes ([ProjectFile](http://www.timvw.be/wp-content/code/csharp/ProjectFile.txt), [AssemblyReference](http://www.timvw.be/wp-content/code/csharp/AssemblyReference.txt)) that make this tedious task a breeze. Here is an example of their usage

```csharp
string path = "D:\\Projects\\MyProject";
string[] projectFileNames = ProjectFile.Find(path);
foreach (string projectFileName in projectFileNames)
{
	ProjectFile projectFile = new ProjectFile(projectFileName);

	bool updated = false;
	foreach (AssemblyReference assemblyReference in projectFile.AssemblyReferences)
	{
		if (assemblyReference.HintPath.ToLower().StartsWith("\\\\buildserver\\framework\\2.0"))
		{
			string newHintPath = assemblyReference.HintPath.Replace("\\2.0\\", "\\2.1\\");
			assemblyReference.HintPath = newHintPath;

			AssemblyName assemblyName = AssemblyName.GetAssemblyName(assemblyReference.HintPath);
			assemblyReference.AssemblyName = assemblyName.FullName + ", processorArchitecture=" + assemblyName.ProcessorArchitecture;

			updated = true;
		}
	}

	if (updated)
	{
		projectFile.Save();
	}
}
```

**Edit:** Be careful because it might be possible that the code changes the encoding of your csproj file (and it seems that the TFS 2005 merge tool doesn't like that). Currently files are written as UTF-8, which is the default for VS2005 csproj files.
