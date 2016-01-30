---
ID: 191
post_title: StreamHelper
author: timvw
post_date: 2007-08-17 16:50:23
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/08/17/streamhelper/
published: true
---
<p>The following is an example of a classic mistake for people that read from a <a href="http://msdn2.microsoft.com/en-us/library/system.io.stream.aspx">Stream</a>:</p>

<blockquote>
<div>
Basically I think I've discovered a bug or limitation of the HttpListenerRequest that I can't find documented anywhere and am unsure how to proceed.<br/>
<br/>
Basically, I've been trying to write a function to strip any uploaded files out of the InputStream of the HttpListenerRequest.  The function works fine until the files are over 128kb (ish).<br/>
<br/>
Dim Body As System.IO.Stream = Request.InputStream<br/>
Body.Read(Bytes, 0, Request.ContentLength64)<br/>
<br/>
Though the ContentLength64 property returns the correct value, the stream object seems to simply be padded with empty bytes.
</div>
</blockquote>

<p>Offcourse, if you look at the documentation for the <a href="http://msdn2.microsoft.com/en-us/library/system.io.stream.read.aspx">Read</a> method it clearly says that the function returns the number of bytes that were actually read. Here is a little helper function that keeps you from writing the same code over and over again:</p>
[code lang="csharp"]public void Copy(Stream input, Stream output, int bufferSize)
{
 byte[] buffer = new byte[bufferSize];
 int bytesRead;

 while((bytesRead = input.Read(buffer, 0, bufferSize)) > 0)
 {
  output.Write(buffer, 0, bytesRead);
 }
}[/code]
<p>And as usual, a little demo of it's use:</p>
[code lang="csharp"]static void DownloadFile(string url, string path)
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
}[/code]