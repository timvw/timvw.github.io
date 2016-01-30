---
ID: 80
post_title: A banner script
author: timvw
post_date: 2004-04-12 00:46:47
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2004/04/12/a-banner-script/
published: true
---
<p>Recently i wrote a <a href="http://www.timvw.be/wp-content/code/php/banner.txt">banner system</a> that displays different banners based on the visitor's  country. It uses the remote address to find the country associated with that address (using <a href="http://www.maxmind.com/">geoip</a>), and then it looks in the database to find a url for that country. If there is no such url, it looks up the default url. And finally it redirects the visitor to the url.</p>