---
date: "2010-05-28T00:00:00Z"
guid: http://www.timvw.be/?p=1754
tags:
- CSharp
title: 'WCF REST: generate correct Content-Length header for HEAD request'
aliases:
 - /2010/05/28/wcf-rest-generate-correct-content-length-header-for-head-request/
 - /2010/05/28/wcf-rest-generate-correct-content-length-header-for-head-request.html
---
The point of a HEAD request is to return a Content-Length header, but with an empty body. 
The WCF transport stack has the annoying 'feature' that it 'corrects' the Content-Length header based on the stream that is returned. 
With the aid of Carlos Figueira's [MyLengthOnlyStream](http://social.msdn.microsoft.com/Forums/en/wcf/thread/c2672206-f255-4b14-b45e-7e3d057f4ffc) i was able to workaround that 'feature' :)
(I know, i know, a good old HttpHandler is so much easier to implement!)
