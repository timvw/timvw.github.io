---
date: "2008-02-18T00:00:00Z"
tags:
- C#
title: Updating Assembly References with TFS
aliases:
 - /2008/02/18/updating-assembly-references-with-tfs/
 - /2008/02/18/updating-assembly-references-with-tfs.html
---
A while ago i [posted some code that allows you to update the Assembly references](http://www.timvw.be/programming-the-csproj-file/). Here is some code that uses the [Team Foundation Server SDK](http://msdn2.microsoft.com/en-us/library/bb130146(VS.80).aspx) that checks the csproj files out and updates their references. Afterwards it's possible to check the modified csproj files in with a reference to a WorkItem (or to undo the checkout in case no modifications were made).

```csharp
static void Main()
{
	string tfsServerName = "tfsrtm08";
	string projectsPath = @"D:\Projects";

	Console.WriteLine( "Connecting to TFS [" + tfsServerName + "]..." );
	TeamFoundationServer teamFoundationServer = TeamFoundationServerFactory.GetServer( tfsServerName );

	Console.WriteLine( Environment.NewLine + "Modified ProjectFiles:" );
	List<workspace> workSpacesWithUpdatedProjectFiles = UpdateReferencesInProjectFiles( teamFoundationServer, projectsPath );

	Console.WriteLine( Environment.NewLine + "Modified Workspaces: " );
	foreach( Workspace workSpace in workSpacesWithUpdatedProjectFiles )
	{
		Console.WriteLine( workSpace.Name );
	}

	//int workItemId = -1;
	//CheckInPendingChanges( teamFoundationServer, workItemId, workSpacesWithUpdatedProjectFiles );

	Console.Write( "{0}Press any key to continue...", Environment.NewLine );
	Console.ReadKey();
}

private static List<workspace> UpdateReferencesInProjectFiles( TeamFoundationServer teamFoundationServer, string projectsPath )
{
	VersionControlServer versionControlServer = (VersionControlServer) teamFoundationServer.GetService( typeof( VersionControlServer ) );

	List<workspace> workSpacesWithUpdatedProjectFiles = new List<workspace>();
	foreach( string projectFileName in ProjectFile.Find( projectsPath ) )
	{
		Workspace workSpace = versionControlServer.GetWorkspace( Path.GetFullPath( projectFileName ) );
		workSpace.PendEdit( projectFileName );

		if( UpdateReferencesInProjectFile( projectFileName ) )
		{
			Console.WriteLine( projectFileName );
			if( !workSpacesWithUpdatedProjectFiles.Contains( workSpace ) )
			{
				workSpacesWithUpdatedProjectFiles.Add( workSpace );
			}
		}
		else
		{
			workSpace.Undo( projectFileName );
		}
	}
	return workSpacesWithUpdatedProjectFiles;
}

private static void CheckInPendingChanges( TeamFoundationServer teamFoundationServer, int workItemId, List<workspace> workSpacesWithUpdatedProjectFiles )
{
	WorkItemStore workItemStore = (WorkItemStore) teamFoundationServer.GetService( typeof( WorkItemStore ) );

	WorkItem workItem = workItemStore.GetWorkItem( workItemId );
	WorkItemCheckinInfo[] workItemChanges = new WorkItemCheckinInfo[] { new WorkItemCheckinInfo( workItem, WorkItemCheckinAction.Associate ) };
	foreach( Workspace workSpace in workSpacesWithUpdatedProjectFiles )
	{
		PendingChange[] pendingChanges = workSpace.GetPendingChanges();
		workSpace.CheckIn( pendingChanges, string.Empty, null, workItemChanges, null );
	}
}
```

Feel free to download the code: [ReferenceManager.zip](http://www.timvw.be/wp-content/code/csharp/ReferenceManager.zip).
