---
id: 80
title: A banner script
date: 2004-04-12T00:46:47+00:00
author: timvw
layout: post
guid: http://www.timvw.be/a-banner-script/
permalink: /2004/04/12/a-banner-script/
tags:
  - PHP
---
Recently i wrote a [banner system](http://www.timvw.be/wp-content/code/php/banner.txt) that displays different banners based on the visitor's country. It uses the remote address to find the country associated with that address (using [geoip](http://www.maxmind.com/)), and then it looks in the database to find a url for that country. If there is no such url, it looks up the default url. And finally it redirects the visitor to the url.
