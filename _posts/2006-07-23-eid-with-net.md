---
ID: 21
post_title: eID with .NET
author: timvw
post_date: 2006-07-23 02:15:19
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/07/23/eid-with-net/
published: true
dsq_thread_id:
  - "1920134027"
---
<p>When i started working (already 3 weeks ago) i recieved a laptop. Friday i discovered that this laptop has a <a href="http://en.wikipedia.org/wiki/Smartcard">Smart card</a> reader and i wanted to experiment with it. I thought it would be nice if i could read the data on my <a href="http://eid.belgium.be/">eID</a>. Apart from <a href="http://download.microsoft.com/download/4/f/d/4fd49a94-8772-4bd0-88ca-bf46e2d029fc/WHITEPAPERS/Accessing%20the%20eID%20Middleware%20from%20.NET%20(Version%201.0).doc">Accessing the eID Middleware from .NET (Version 1.0)</a> i couldn't find much information. I decided to use the document as the basis for my own libeid wrapper. With the Simple (Wrapper API) reading data becomes extremely easy: </p>

[code lang="csharp"]
using eID.Simple;

Reader reader = Reader.GetReader();
pictureBox.Image = reader.GetImage();
labelName.Text = reader.GetName();
labelGivenNames.Text = reader.GetFirstName1() + reader.GetFirstName2() + reader.GetFirstName3();
dateTimePickerBirthdate.Value = reader.GetBirthdate();
[/code]

<p>As usual, feel free to download the source (<a href="http://www.timvw.be/wp-content/code/csharp/Belgium.zip">Belgium.zip</a>) and/or leave any comments</p>