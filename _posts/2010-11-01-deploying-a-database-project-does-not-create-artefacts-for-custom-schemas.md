---
ID: 1932
post_title: >
  Deploying a Database Project does not
  create artefacts for custom schemas
author: timvw
post_date: 2010-11-01 10:08:12
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/11/01/deploying-a-database-project-does-not-create-artefacts-for-custom-schemas/
published: true
---
<p>Last week we noticed that the artefacts for a custom schema in our Database Project were not created (or updated). It took us a while to figure out what was wrong. When you add a script via the 'Add Existing item' menu in VS2010 the file's <b>Build Action</b> is set to <b>Not in Build</b> for some unknown reason. As soon as we changed the value to <b>Build</b> and Deployed again our artefacts were created.</p>