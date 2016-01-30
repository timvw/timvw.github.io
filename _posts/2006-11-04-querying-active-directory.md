---
ID: 125
post_title: Querying Active Directory
author: timvw
post_date: 2006-11-04 15:22:15
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/11/04/querying-active-directory/
published: true
---
<p>A while ago i wanted to figure out which demo accounts i had already created in my <a href="http://www.microsoft.com/windowsserver2003/technologies/directory/activedirectory/default.mspx">Active Directory</a>. Since i was smart enough to give them all a description 'Demo User' this was easily done as following:</p>
[code lang="csharp"]
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
   Console.WriteLine( "{0}: {1}", propertyCollection["displayname"][0].ToString(), propertyCollection["description"][0].ToString() );
   }
  }
}[/code]