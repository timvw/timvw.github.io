---
id: 189
title: List string resources
date: 2007-08-11T19:05:34+00:00
author: timvw
layout: post
guid: http://www.timvw.be/list-string-resources/
permalink: /2007/08/11/list-string-resources/
tags:
  - 'C#'
---
Earlier today someone asked how he could list the string resources (name, value and comment) in a Resource file. Here is some code that generates a nice list of the information

```csharp
static void Main(string[] args)
{
	DislayResourceStrings(GetResourceStrings(@"C:\Resource1.resx"));

	Console.Write("{0}Press any key to continue...", Environment.NewLine);
	Console.ReadKey();
}

public static List<resourceString> GetResourceStrings(string path)
{
	List<resourceString> resourceStrings = new List<resourceString>();

	XPathDocument doc = new XPathDocument(path);
	foreach (XPathNavigator node in doc.CreateNavigator().Select("//data"))
	{
		string type = node.GetAttribute("type", string.Empty);
		if (type == string.Empty)
		{
			XPathNavigator nav;

			string name = node.GetAttribute("name", string.Empty);
			nav = node.SelectSingleNode("./value");
			string value = nav != null ? nav.Value : string.Empty;

			nav = node.SelectSingleNode("./comment");
			string comment = nav != null ? nav.Value : string.Empty;

			resourceStrings.Add(new ResourceString(name, value, comment));
		}
	}

	return resourceStrings;
}

public static void DisplayResourceStrings(List<resourceString> resourceStrings)
{
	string format = "{0, -25} {1, -25} {2, -25}";
	Console.WriteLine(format, "Name", "Value", "Comment");
	Console.WriteLine(format, "---", "----", "-----");

	foreach (ResourceString resourceString in resourceStrings)
	{
		Console.WriteLine(format, resourceString.Name, resourceString.Value, resourceString.Comment);
	}
}

public struct ResourceString
{
	public string Name;
	public string Value;
	public string Comment;

	public ResourceString(string name, string value, string comment)
	{
		this.Name = name;
		this.Value = value;
		this.Comment = comment;
	}
}
```
