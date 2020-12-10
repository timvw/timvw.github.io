---
title: Deploying a Database Project does not create artefacts for custom schemas
layout: post
guid: http://www.timvw.be/?p=1932
categories:
  - Uncategorized
tags:
  - SQL
  - vs2010
---
Last week we noticed that the artefacts for a custom schema in our Database Project were not created (or updated). It took us a while to figure out what was wrong. When you add a script via the 'Add Existing item' menu in VS2010 the file's **Build Action** is set to **Not in Build** for some unknown reason. As soon as we changed the value to **Build** and Deployed again our artefacts were created.
