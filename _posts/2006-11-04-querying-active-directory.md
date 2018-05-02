---
id: 125
title: Querying Active Directory
date: 2006-11-04T15:22:15+00:00
author: timvw
layout: post
guid: http://www.timvw.be/querying-active-directory/
permalink: /2006/11/04/querying-active-directory/
tags:
  - 'C#'
---
A while ago i wanted to figure out which demo accounts i had already created in my [Active Directory](http://www.microsoft.com/windowsserver2003/technologies/directory/activedirectory/default.mspx). Since i was smart enough to give them all a description 'Demo User' this was easily done as following

```csharp
using( DirectoryEntry directoryEntry = new DirectoryEntry() )
{
	using( DirectorySearcher directorySearcher = new DirectorySearcher() )
	{
		directorySearcher.Filter = "(&(objectClass=user)(description=Demo User))";
		directorySearcher.SearchScope = SearchScope.Subtree;
		directorySearcher.Sort = new SortOption("displayname", SortDirection.Ascending );

		SearchResultCollection results = directorySearcher.FindAll();
		foreach( SearchResult result in results )
		{
			ResultPropertyCollection propertyCollection = result.Properties;
			Console.WriteLine( "{0}: {1}", propertyCollection\["displayname"\]\[0\].ToString(), propertyCollection\["description"\]\[0\].ToString() );
		}
	}
}
```
