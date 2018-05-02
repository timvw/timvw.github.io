---
id: 210
title: Find WorkItems that have been changed between two dates
date: 2008-02-28T18:44:20+00:00
author: timvw
layout: post
guid: http://www.timvw.be/find-workitems-that-have-been-changed-between-two-dates/
permalink: /2008/02/28/find-workitems-that-have-been-changed-between-two-dates/
tags:
  - 'C#'
---
Sometimes i want to know which WorkItems i have closed (or completed) between two dates. According to [Amit Ghosh](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=2528099&SiteID=1) it's not possible to write such a query so i wrote some code that uses the [TFS SDK](http://msdn2.microsoft.com/en-us/library/bb130146(VS.80).aspx) to get that list

```csharp
static void Main(string[] args)
{
	TeamFoundationServer tfs = TeamFoundationServerFactory.GetServer("tfsrtm08");
	WorkItemStore wis = (WorkItemStore)tfs.GetService(typeof(WorkItemStore));

	DateTime begin = new DateTime(2008, 1, 1);
	DateTime end = new DateTime(2008, 2, 28);
	string username = "Darren";

	foreach (WorkItem workItem in FindChangesByUserInRange(wis, username, begin, end))
	{
		Console.WriteLine("[{0:00000}] {1}", workItem.Id, workItem.Title);
	}

	Console.WriteLine("Press any key to continue...");
	Console.ReadKey();
}

static List<workItem> FindChangesByUserInRange(WorkItemStore workItemStore, string username, DateTime begin, DateTime end)
{
	string query = "SELECT System.ID, System.Title FROM workitems WHERE [Changed By] EVER '{0}' AND [State] IN ('Closed', 'Resolved') AND [Changed Date] >= '{1}'";
	query = string.Format(query, username, begin.Date.ToShortDateString());

	List<workItem> result = new List<workItem>();

	foreach (WorkItem workItem in workItemStore.Query(query))
	{
		if (IsChangedByUserInRange(workItem, username, begin, end))
		{
			result.Add(workItem);
		}
	}

	return result;
}

private static bool IsChangedByUserInRange(WorkItem workItem, string username, DateTime begin, DateTime end)
{
	foreach (Revision rev in workItem.Revisions)
	{
		string changedBy = (string)rev.Fields["Changed By"].Value;
		if (changedBy == username)
		{
			DateTime changedDate = (DateTime)rev.Fields["Changed Date"].Value;
			if (begin <= changedDate && changedDate <= end) 
			{ 
				return true; 
			} 
		} 
	} 
	return false; 
}
```
