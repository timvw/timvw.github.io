---
date: "2009-10-09T00:00:00Z"
guid: http://www.timvw.be/?p=1345
tags:
- Information Technology
title: Configuring Apache to serve Office 2007 documents with the correct MIME type
---
Untill now i haven't published any Office 2007 documents but i noticed that my webhost hasn't configured apache to serve such documents with the correct MIME types. This resulted in my web browser downloading .docx files as zip archives. Here's how a couple of additions to .htaccess tackle the problem:

```apache
AddType application/vnd.openxmlformats-officedocument.spreadsheetml.sheet xlsx
AddType application/vnd.openxmlformats-officedocument.spreadsheetml.template xltx
AddType application/vnd.openxmlformats-officedocument.presentationml.template potx
AddType application/vnd.openxmlformats-officedocument.presentationml.slideshow ppsx
AddType application/vnd.openxmlformats-officedocument.presentationml.presentation sldx
AddType application/vnd.openxmlformats-officedocument.presentationml.slide sldx
AddType application/vnd.openxmlformats-officedocument.wordprocessingml.document docx
AddType application/vnd.openxmlformats-officedocument.wordprocessingml.template dotx
AddType application/vnd.ms-excel.addin.macroEnabled.12 xlam
AddType application/vnd.ms-excel.sheet.binary.macroEnabled.12 xslb
```
