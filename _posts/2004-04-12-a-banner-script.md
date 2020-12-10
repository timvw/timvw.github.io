---
title: A banner script
layout: post
tags:
  - PHP
---
Recently i wrote a [banner system](http://www.timvw.be/wp-content/code/php/banner.txt) that displays different banners based on the visitor's country. It uses the remote address to find the country associated with that address (using [geoip](http://www.maxmind.com/)), and then it looks in the database to find a url for that country. If there is no such url, it looks up the default url. And finally it redirects the visitor to the url.
