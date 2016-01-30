---
ID: 2280
post_title: Using eID on OS X Mountain Lion
author: timvw
post_date: 2012-08-06 22:45:52
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2012/08/06/using-eid-on-os-x-mountain-lion/
published: true
dsq_thread_id:
  - "1933063167"
---
<p>Last week or so I got myself a MacBook Air and I am really loving it so far. Today I needed to use my <a href="http://eid.belgium.be/en/">eID</a> so I installed the middleware application without any hassle but had a hard time configuring Safari. Apparently Apply removed support for <a href="http://en.wikipedia.org/wiki/PKCS_?11">PKCS #11</a> in <a href="http://www.apple.com/osx/">OS X Mountain Lion</a>. After installing <a href="http://smartcardservices.macosforge.org">SmartCard Services</a> the certificates appeared in the Keychain and I became able to authenticate on websites using my certificate</p>