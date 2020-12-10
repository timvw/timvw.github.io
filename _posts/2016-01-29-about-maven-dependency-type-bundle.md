---
title: About maven dependency type 'bundle'
layout: post
guid: http://www.timvw.be/?p=2529
categories:
  - Uncategorized
tags:
  - maven scala osgi
---
Earlier this week my build failed because maven was not able to resolve an (indirect) dependency on some package. It took me a while to notice that the dependency node in the pom file had an extra attribute: type = bundle. It only took a couple of minutes to find a good explanation [here](http://stackoverflow.com/questions/14913615/osgi-bundle-vs-jar-dependency). Build fixed 😉
