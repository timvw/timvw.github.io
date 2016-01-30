---
ID: 1811
post_title: 'Removing Dead Tracks (Duplicates that don&#039;t exist) from iTunes using C#'
author: timvw
post_date: 2010-07-20 18:59:15
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/07/20/removing-dead-tracks-duplicates-that-dont-exist-from-itunes-using-c/
published: true
---
<p>Last week i noticed the following post from Scott Hanselman: <a href="http://www.hanselman.com/blog/RemovingDeadTracksDuplicatesThatDontExistFromITunesUsingC.aspx">Removing Dead Tracks (Duplicates that don't exist) from iTunes using C#</a>. As a good boy scout i noticed that these days iTunesLib.IITTrackCollection inherits from IEnumerable so i rewrote the code a little:</p>

[code lang="csharp"]class Program
{
 [STAThread]
 static void Main()
 {
  var itunes = new iTunesApp();
  itunes.DeleteTracksThatDoNotExist();
 }
}

public static class ITunesExtensions
{
 public static void DeleteTracksThatDoNotExist(this IiTunes itunes)
 {
  var tracksThatDoNotExist = FindTracksThatDoNotExist(itunes);
  foreach (var track in tracksThatDoNotExist) track.Delete();
 }

 public static IEnumerable<iitfileOrCDTrack> FindTracksThatDoNotExist(this IiTunes iTunes)
 {
  return iTunes.LibraryPlaylist.Tracks
   .OfType<iitfileOrCDTrack>()
   .Where(track => !File.Exists(track.Location));
 }
}[/code]