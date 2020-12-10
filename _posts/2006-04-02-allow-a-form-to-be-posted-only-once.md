---
title: Allow a form to be posted only once
layout: post
tags:
  - PHP
---
People can fill in a form and submit it. Then they can hit their back button, and choose to submit it again. Usually the second time this form is being posted, the values in that form aren't valid anymore and thus corrupt the database.
  
Most developpers i know try to work around this problem by using the header function or the html meta tags to set the expiration date. However, this solution does not only limit the usability of a site, it simply does not work for visitors that have a browser that ignores the expiration date.

My solution for this problem is quite easy. For each entity in the database that can be updated by a form, we should add an attribute lastupdate. Now every time we build a form that contains data of that entity, we should also add an input of type hidden with the value of that lastupdate attribute. If the value of the lastupdate attribute in the database is more recent than the value of the posted lastupdate in the recieving script, then the posted values are invalid and this script should tell the user about this error. Offcourse, every time such an entity is updated, the lastupdate attribute of this entity should be updated too.
