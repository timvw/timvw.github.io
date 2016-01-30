---
ID: 2529
post_title: 'About maven dependency type &#8216;bundle&#8217;'
author: timvw
post_date: 2016-01-29 19:41:51
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2016/01/29/about-maven-dependency-type-bundle/
published: true
---
<p>Earlier this week my build failed because maven was not able to resolve an (indirect) dependency on some package. It took me a while to notice that the dependency node in the pom file had an extra attribute: type = bundle. It only took a couple of minutes to find a good explanation <a href="http://stackoverflow.com/questions/14913615/osgi-bundle-vs-jar-dependency">here</a>. Build fixed ;)</p>