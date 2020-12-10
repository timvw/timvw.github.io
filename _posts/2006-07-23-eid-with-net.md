---
title: eID with .NET
layout: post
tags:
  - 'C#'
---
When i started working (already 3 weeks ago) i recieved a laptop. Friday i discovered that this laptop has a [Smart card](http://en.wikipedia.org/wiki/Smartcard) reader and i wanted to experiment with it. I thought it would be nice if i could read the data on my [eID](http://eid.belgium.be/). Apart from [Accessing the eID Middleware from .NET (Version 1.0)](http://download.microsoft.com/download/4/f/d/4fd49a94-8772-4bd0-88ca-bf46e2d029fc/WHITEPAPERS/Accessing%20the%20eID%20Middleware%20from%20.NET%20(Version%201.0).doc) i couldn't find much information. I decided to use the document as the basis for my own libeid wrapper. With the Simple (Wrapper API) reading data becomes extremely easy

```csharp
using eID.Simple;

Reader reader = Reader.GetReader();
pictureBox.Image = reader.GetImage();
labelName.Text = reader.GetName();
labelGivenNames.Text = reader.GetFirstName1() + reader.GetFirstName2() + reader.GetFirstName3();
dateTimePickerBirthdate.Value = reader.GetBirthdate();
```

As usual, feel free to download the source ([Belgium.zip](http://www.timvw.be/wp-content/code/csharp/Belgium.zip)) and/or leave any comments
