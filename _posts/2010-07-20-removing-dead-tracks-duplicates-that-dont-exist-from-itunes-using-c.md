---
id: 1811
title: 'Removing Dead Tracks (Duplicates that don&#039;t exist) from iTunes using C#'
date: 2010-07-20T18:59:15+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1811
permalink: /2010/07/20/removing-dead-tracks-duplicates-that-dont-exist-from-itunes-using-c/
tags:
  - 'C#'
---
Last week i noticed the following post from Scott Hanselman: [Removing Dead Tracks (Duplicates that don't exist) from iTunes using C#](http://www.hanselman.com/blog/RemovingDeadTracksDuplicatesThatDontExistFromITunesUsingC.aspx). As a good boy scout i noticed that these days iTunesLib.IITTrackCollection inherits from IEnumerable so i rewrote the code a little

```csharp
class Program
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
}
```
