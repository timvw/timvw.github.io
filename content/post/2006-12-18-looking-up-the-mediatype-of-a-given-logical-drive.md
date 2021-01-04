---
date: "2006-12-18T00:00:00Z"
tags:
- C#
title: Looking up the MediaType of a given Logical Drive
aliases:
 - /2006/12/18/looking-up-the-mediatype-of-a-given-logical-drive/
 - /2006/12/18/looking-up-the-mediatype-of-a-given-logical-drive.html
---
Earlier today i saw someone asking how he could find out the MediaType of a given logical drive. The easy solution would be to iterate over [DriveInfo.GetDrives](http://msdn2.microsoft.com/en-us/library/system.io.driveinfo.getdrives.aspx) and pick the one you are looking for... Anyway, i thought it would be nice to experiment with [WMI](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/wmisdk/wmi/wmi_start_page.asp) so i wrote a little function that uses [Win32_LogicalDisk](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/wmisdk/wmi/Win32_LogicalDisk.asp) to look the MediaType up

```csharp
static void Main(string[] args)
{
	char[] driveLetters = new char[] { 'a', 'c', 'd', 'e' };
	foreach (char driveLetter in driveLetters)
	{
		try
		{
			Console.WriteLine("Drive {0} is a {1}", driveLetter, GetMediaType(driveLetter));
		}
		catch (ManagementException)
		{
			Console.WriteLine("Drive {0} was not found", driveLetter);
		}
	}

	Console.WriteLine("Press any key to continue...");
	Console.ReadKey();
}

static string GetMediaType(char driveLetter)
{
	ManagementObject disk = new ManagementObject("win32_logicaldisk.deviceid=\"" + driveLetter + ":\"");
	disk.Get();
	return GetMediaMeaning((uint)disk["MediaType"]);
}

static string GetMediaMeaning(uint mediaType)
{
	Dictionary<uint, string> mediaTypes = new Dictionary<uint, string>();
	mediaTypes.Add(0, "Unknown Format");
	mediaTypes.Add(1, "51/4-Inch Floppy Disk -- 1.2Mb -- 512bytes/sector");
	mediaTypes.Add(2, "31/2-Inch Floppy Disk -- 1.44Mb -512bytes/sector");
	mediaTypes.Add(3, "31/2-Inch Floppy Disk -- 2.88Mb -- 512bytes/sector");
	mediaTypes.Add(4, "31/2-Inch Floppy Disk -- 20.8Mb -- 512bytes/sector");
	mediaTypes.Add(5, "31/2-Inch Floppy Disk -- 720Kb -- 512bytes/sector");
	mediaTypes.Add(6, "51/4-Inch Floppy Disk -- 360Kb -- 512bytes/sector");
	mediaTypes.Add(7, "51/4-Inch Floppy Disk -- 320Kb -- 512bytes/sector");
	mediaTypes.Add(8, "51/4-Inch Floppy Disk -- 320Kb -- 1024bytes/sector");
	mediaTypes.Add(9, "51/4-Inch Floppy Disk -- 180Kb -- 512bytes/sector");
	mediaTypes.Add(10, "51/4-Inch Floppy Disk -- 160Kb -- 512bytes/sector");
	mediaTypes.Add(11, "Removable media other than floppy");
	mediaTypes.Add(12, "Fixed hard disk media");
	mediaTypes.Add(13, "31/2-Inch Floppy Disk -- 120Mb -- 512bytes/sector");
	mediaTypes.Add(14, "31/2-Inch Floppy Disk -- 640Kb -- 512bytes/sector");
	mediaTypes.Add(15, "51/4-Inch Floppy Disk -- 640Kb -- 512bytes/sector");
	mediaTypes.Add(16, "51/4-Inch Floppy Disk -- 720Kb -- 512bytes/sector");
	mediaTypes.Add(17, "31/2-Inch Floppy Disk -- 1.2Mb -- 512bytes/sector");
	mediaTypes.Add(18, "31/2-Inch Floppy Disk -- 1.23Mb -- 1024bytes/sector");
	mediaTypes.Add(19, "51/4-Inch Floppy Disk -- 1.23Mb -- 1024bytes/sector");
	mediaTypes.Add(20, "31/2-Inch Floppy Disk -- 128Mb -- 512bytes/sector");
	mediaTypes.Add(21, "31/2-Inch Floppy Disk -- 230Mb -- 512bytes/sector");
	mediaTypes.Add(22, "8-Inch Floppy Disk -- 256Kb -- 128bytes/sector");

	string meaning = "Unknown format";
	mediaTypes.TryGetValue(mediaType, out meaning);
	return meaning;
}
```
