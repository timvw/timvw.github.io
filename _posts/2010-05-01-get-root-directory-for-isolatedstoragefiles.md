---
title: Get root directory for IsolatedStorageFiles
layout: post
guid: http://www.timvw.be/?p=1715
tags:
  - 'C#'
---
Sometimes you want to know the absolute path of a file that is persisted with [IsolatedStorageFile](http://msdn.microsoft.com/en-us/library/system.io.isolatedstorage.isolatedstoragefile(VS.95).aspx). Apparently there is an internal property RootDirectory which contains this information

```csharp
public static class IsolatedStorageFileExtensions
{
	public static string GetRootDirectory(this IsolatedStorageFile isf)
	{
		var property = isf.GetType().GetProperty("RootDirectory", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.GetProperty);
		return (string)property.GetValue(isf, null);
	}
}
```

Here is a real world example of using [SharpBITS.NET](http://sharpbits.codeplex.com/) to download a file to IsolatedStorage:

```csharp
class Program
{
	static void Main()
	{
		var mgr = new BitsManager();
		mgr.OnJobError += mgr_OnJobError;
		mgr.OnJobTransferred += mgr_OnJobTransferred;

		var job = mgr.CreateJob("job@" + DateTime.Now, JobType.Download);
		var src = @"http://localhost/";
		var dst = Path.Combine(GetIsfRoot(), "test.html");
		job.AddFile(src,dst);
		job.Resume();

		Console.WriteLine("running...");
		Console.ReadKey();
	}

	static void mgr_OnJobTransferred(object sender, NotificationEventArgs e)
	{
		e.Job.Complete();
		Console.WriteLine("completed: " + e.Job.DisplayName);
	}

	static void mgr_OnJobError(object sender, ErrorNotificationEventArgs e)
	{
		Console.WriteLine("error: " + e.Error.Description);
	}

	static string GetIsfRoot()
	{
		using (var f = IsolatedStorageFile.GetUserStoreForAssembly())
		{
			return f.GetRootDirectory();
		}
	}
}
```
