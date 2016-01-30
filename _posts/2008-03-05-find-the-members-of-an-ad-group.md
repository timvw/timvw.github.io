---
ID: 212
post_title: Find the members of an AD group
author: timvw
post_date: 2008-03-05 18:08:39
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/03/05/find-the-members-of-an-ad-group/
published: true
---
<p>Because i always seem to forget about the syntax of LDAP Search Filters (<a href="http://www.ietf.org/rfc/rfc2254.txt">RFC 2254: The String Representation of LDAP Search Filters</a> and <a href="http://msdn2.microsoft.com/en-us/library/ms675768(VS.85).aspx">Creating a Query Filter</a>) i'm going to post a basic demo of <a href="http://msdn2.microsoft.com/en-us/library/system.directoryservices.directorysearcher.aspx">DirectorySearcher</a> that returns the members that are part of a given AD group:</p>
[code lang="csharp"]private static void Main(string[] args)
{
 foreach (string member in FindUsernames("?CWBE-PS-.NetDev"))
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
}[/code]