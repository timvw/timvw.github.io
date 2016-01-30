---
ID: 1715
post_title: >
  Get root directory for
  IsolatedStorageFiles
author: timvw
post_date: 2010-05-01 20:07:04
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/05/01/get-root-directory-for-isolatedstoragefiles/
published: true
dsq_thread_id:
  - "1927140626"
---
<p>Sometimes you want to know the absolute path of a file that is persisted with <a href="http://msdn.microsoft.com/en-us/library/system.io.isolatedstorage.isolatedstoragefile(VS.95).aspx">IsolatedStorageFile</a>.  Apparently there is an internal property RootDirectory which contains this information:</p>

[code lang="csharp"]public static class IsolatedStorageFileExtensions
{
 public static string GetRootDirectory(this IsolatedStorageFile isf)
 {
  var property = isf.GetType().GetProperty("RootDirectory", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.GetProperty);
  return (string)property.GetValue(isf, null);
 }
}[/code]

<p>Here is a real world example of using <a href="http://sharpbits.codeplex.com/">SharpBITS.NET</a> to download a file to IsolatedStorage:</p>

[code lang="csharp"]class Program
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
}[/code]