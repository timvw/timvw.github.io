---
id: 147
title: 'Making WebRequests in parallel...'
date: 2007-01-14T02:00:00+00:00
author: timvw
layout: post
guid: http://www.timvw.be/asynchronous-webrequests/
permalink: /2007/01/14/asynchronous-webrequests/
dsq_thread_id:
  - 1929575324
tags:
  - 'C#'
---
Under the assumption that making sequential WebRequests is slower than making them in parallel i wrote a little program that returns the HTTP status code for each URI in a list. Because the number of WaitHandles on a system is limited to 64 and i would have been required to hack around this limitation i decided to use ThreadPool instead...

```csharp
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Net;

namespace ManyRequests
{
	class Program
	{
	
		static void Main(string[] args)
		{
			List<uri> uris = new List<uri>();
			uris.Add(new Uri("http://www.timvw.be"));
			uris.Add(new Uri("http://example.com/does\_not\_exist"));
			uris.Add(new Uri("http://www.timvw.be/c-sharp"));
			uris.Add(new Uri("http://www.timvw.be/rss-feed/"));
			uris.Add(new Uri("http://localhost"));

		Console.WriteLine("Getting the HttpStatusCodes...");
		HttpStatusCodeReader httpStatusCodeReader = new HttpStatusCodeReader(uris);
		int[] httpStatusCodes = httpStatusCodeReader.GetHttpStatusCodes();

		for (int i = 0; i < uris.Count; ++i) 
		{ 
			Console.WriteLine("{0} {1}", httpStatusCodes[i], uris[i]); }
			Console.Write("{0}Press any key to continueâ€¦", Environment.NewLine); 
			Console.ReadKey(); 
		} 
	} 
	
	public class HttpStatusCodeReader 
	{ 
		private List<uri> uris;
		private int[] httpStatusCodes;
		private object syncLock;
		private int completed;

		public HttpStatusCodeReader(List<uri> uris)
		{
			if (uris == null)
			{
				throw new ArgumentNullException("uris");
			}

			foreach (Uri uri in uris)
			{
				if (uri.Scheme != Uri.UriSchemeHttp && uri.Scheme != Uri.UriSchemeHttps)
				{
					throw new ArgumentException(uri.ToString() + " is not valid http(s) uri.", "uris");
				}
			}

			this.uris = uris;
			this.httpStatusCodes = new int[uris.Count];
			this.syncLock = new object();
			this.completed = 0;
		}

		public int[] GetHttpStatusCodes()
		{
			for (int i = 0; i < this.httpStatusCodes.Length; ++i) 
			{ 
				HttpWebRequest httpWebRequest = WebRequest.Create(this.uris[i]) as HttpWebRequest; 
				httpWebRequest.Method = "HEAD"; 
				httpWebRequest.AllowAutoRedirect = true; 
				httpWebRequest.BeginGetResponse(this.GetResponseCompleted, new object[] { httpWebRequest, i });
			} 
			lock (this.syncLock) 
			{ 
				while (this.completed < this.httpStatusCodes.Length) 
				{ 
					Monitor.Wait(this.syncLock); 
				} 
			} 
			return this.httpStatusCodes; 
		} 
		
		private void GetResponseCompleted(IAsyncResult ar) 
		{ 
			object[] objects = ar.AsyncState as object[];
			HttpWebRequest httpWebRequest = objects[0] as HttpWebRequest; 
			int index = (int)objects[1]; 
			HttpWebResponse httpWebResponse = null; 
			try 
			{
				httpWebResponse = httpWebRequest.EndGetResponse(ar) as HttpWebResponse; 
				this.httpStatusCodes[index] = (int)httpWebResponse.StatusCode; 
			} 
			catch (WebException webException) 
			{ 
				httpWebResponse = webException.Response as HttpWebResponse; 
				if (httpWebResponse != null) 
				{ 
					this.httpStatusCodes[index] = (int)httpWebResponse.StatusCode; 
				} 
			} 
			finally 
			{ 
				if (httpWebResponse != null) 
				{ 
					httpWebResponse.Close(); 
				} 
				lock (this.syncLock) 
				{ 
					Interlocked.Add(ref this.completed, 1); 
					Monitor.Pulse(this.syncLock); 
				} 
			}
		} 
	} 
}
```
