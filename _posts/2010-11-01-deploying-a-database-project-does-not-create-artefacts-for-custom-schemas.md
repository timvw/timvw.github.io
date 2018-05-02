---
id: 1932
title: Deploying a Database Project does not create artefacts for custom schemas
date: 2010-11-01T10:08:12+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1932
permalink: /2010/11/01/deploying-a-database-project-does-not-create-artefacts-for-custom-schemas/
categories:
  - Uncategorized
tags:
  - SQL
  - vs2010
---
Last week we noticed that the artefacts for a custom schema in our Database Project were not created (or updated). It took us a while to figure out what was wrong. When you add a script via the 'Add Existing item' menu in VS2010 the file's **Build Action** is set to **Not in Build** for some unknown reason. As soon as we changed the value to **Build** and Deployed again our artefacts were created.
