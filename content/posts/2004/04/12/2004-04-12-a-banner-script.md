---
date: "2004-04-12T00:00:00Z"
tags:
- PHP
title: A banner script
aliases:
 - /2004/04/12/a-banner-script/
 - /2004/04/12/a-banner-script.html
---
Recently i wrote a [banner system](http://www.timvw.be/wp-content/code/php/banner.txt) that displays different banners based on the visitor's country. It uses the remote address to find the country associated with that address (using [geoip](http://www.maxmind.com/)), and then it looks in the database to find a url for that country. If there is no such url, it looks up the default url. And finally it redirects the visitor to the url.
