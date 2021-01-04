---
date: "2006-11-04T00:00:00Z"
tags:
- C#
title: Querying Active Directory
aliases:
 - /2006/11/04/querying-active-directory/
 - /2006/11/04/querying-active-directory.html
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
