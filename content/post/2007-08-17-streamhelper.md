---
date: "2007-08-17T00:00:00Z"
tags:
- C#
title: StreamHelper
aliases:
 - /2007/08/17/streamhelper/
 - /2007/08/17/streamhelper.html
---
The following is an example of a classic mistake for people that read from a [Stream](http://msdn2.microsoft.com/en-us/library/system.io.stream.aspx)

> <div>
>   Basically I think I've discovered a bug or limitation of the HttpListenerRequest that I can't find documented anywhere and am unsure how to proceed.</p> 
>   
>   <p>
>     Basically, I've been trying to write a function to strip any uploaded files out of the InputStream of the HttpListenerRequest. The function works fine until the files are over 128kb (ish).
>   </p>
>   
>   <p>
>     Dim Body As System.IO.Stream = Request.InputStream<br /> Body.Read(Bytes, 0, Request.ContentLength64)
>   </p>
>   
>   <p>
>     Though the ContentLength64 property returns the correct value, the stream object seems to simply be padded with empty bytes.
>   </p>
> </div>

Offcourse, if you look at the documentation for the [Read](http://msdn2.microsoft.com/en-us/library/system.io.stream.read.aspx) method it clearly says that the function returns the number of bytes that were actually read. Here is a little helper function that keeps you from writing the same code over and over again

```csharp
public void Copy(Stream input, Stream output, int bufferSize)
{
	byte[] buffer = new byte[bufferSize];
	int bytesRead;

	while((bytesRead = input.Read(buffer, 0, bufferSize)) > 0)
	{
		output.Write(buffer, 0, bytesRead);
	}
}
```

And as usual, a little demo of it's use

```csharp
static void DownloadFile(string url, string path)
{
	WebRequest req = WebRequest.Create(url);
	WebResponse rsp = req.GetResponse();
	using (Stream input = rsp.GetResponseStream())
	using (Stream output = File.Open(path, FileMode.Create))
	{
		StreamHelper.Copy(input, output, 1024 * 1000);
	}
}

static void Main(string[] args)
{
	DownloadFile("ftp://example.com/pub/test.bin", @"c:\test.bin");

	Console.Write("{0}Press any key to continue...", Environment.NewLine);
	Console.ReadKey();
}
```
