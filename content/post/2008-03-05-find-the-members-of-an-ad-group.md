---
date: "2008-03-05T00:00:00Z"
tags:
- C#
title: Find the members of an AD group
aliases:
 - /2008/03/05/find-the-members-of-an-ad-group/
 - /2008/03/05/find-the-members-of-an-ad-group.html
---
Because i always seem to forget about the syntax of LDAP Search Filters ([RFC 2254: The String Representation of LDAP Search Filters](http://www.ietf.org/rfc/rfc2254.txt) and [Creating a Query Filter](http://msdn2.microsoft.com/en-us/library/ms675768(VS.85).aspx)) i'm going to post a basic demo of [DirectorySearcher](http://msdn2.microsoft.com/en-us/library/system.directoryservices.directorysearcher.aspx) that returns the members that are part of a given AD group

```csharp
private static void Main(string[] args)
{
	foreach (string member in FindUsernames("CWBE-PS-.NetDev"))
	{
		Console.WriteLine(member);
	}

	Console.Write("{0}Press any key to continue...", Environment.NewLine);
	Console.ReadKey();
}

private static IEnumerable<string> FindUsernames(string groupname)
{
	string filter = "(&(&(objectCategory=Group)(objectClass=Group))(name={0}))";
	filter = string.Format(filter, groupname);

	DirectoryEntry directoryEntry = new DirectoryEntry();
	DirectorySearcher searcher = new DirectorySearcher(directoryEntry);
	searcher.SearchScope = SearchScope.Subtree;
	searcher.Filter = filter;

	DirectoryEntry groupEntry = searcher.FindOne().GetDirectoryEntry();
	PropertyValueCollection members = (PropertyValueCollection)groupEntry.Properties["member"];
	return ConvertAll<object, string>((object[])members.Value);
}

private static IEnumerable<to> ConvertAll<from, To>(IEnumerable<from> elements)
{
	Type toType = typeof(To);

	foreach (From element in elements)
	{
		yield return (To)Convert.ChangeType(element, toType);
	}
}
```
