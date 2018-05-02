---
id: 42
title: Accept posted XML data
date: 2006-01-18T02:57:07+00:00
author: timvw
layout: post
guid: http://www.timvw.be/accept-posted-xml-data/
permalink: /2006/01/18/accept-posted-xml-data/
tags:
  - PHP
  - XML
---
I remember that i have spent a lot of time finding something that allowed me to accept the posted XML data. The solution was very simple

```php
$data = file_get_contents("php://input");
```
