---
ID: 185
post_title: >
  Professional SQL Server 2005 Reporting
  Services
author: timvw
post_date: 2007-08-04 22:09:06
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/08/04/professional-sql-server-2005-reporting-services/
published: true
dsq_thread_id:
  - "1933324316"
---
<p>Last couple of days i've been reading <a href="http://www.wrox.com/WileyCDA/WroxTitle/productCd-0764568787.html">Professional SQL Server Reporting Services</a>. Today i wanted to display some images so i decided to use the Northwind database which has an Employees table that contains photos.. I set the MIMEType to image/bmp, Source to Database and Value to =Fields!Photo.Value but i kept getting a red cross instead of the image:</p>
<img src="http://www.timvw.be/wp-content/images/reportingservices-01.gif" alt="image of a sql server reporting service report where an error box appears instead of the image"/>
<p>After a lot of searching, i found the following in <a href="http://www.sqlreportingservices.net/BookSrs2000/default.aspx">Hitchhiker's Guide to SQL Server 2000 Reporting Services</a>:</p>

<blockquote>
<div>
As we touched on earlier, you might find there is a problem if you need to use images that have been added to SQL Server through Microsoft Access or drawn directly from an Access/JET database or another similar tool. If you've run the Image wizard and bound the images to the DataSet and they still don't appear to render, the image data might be corrupted or simply prefixed with an OLE header. The Northwind Employees report is an example of a report with this issuered error boxes appear in the Image controls.
<br/><br/>
The reason for this could be that the image data is corrupted or simply has an OLE header at the beginning of the binary image data. Once this header is removed or bypassed, the image displays correctly. The typical OLE header is 105 bytes long and can be stepped over by editing the image control's Value property to the following expression:
<br/><br/>
<b>=System.Convert.FromBase64String(Mid(System.Convert.ToBase64String( Fields!Photo.Value ),105))</b>
</div>
</blockquote>

<p>And yes, once i used this as value for the image, everything worked as expected:</p>
<img src="http://www.timvw.be/wp-content/images/reportingservices-02.gif" alt="image of a sql server reporting service report where an image is correctly displayed"/>