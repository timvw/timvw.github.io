---
date: "2012-08-06T00:00:00Z"
guid: http://www.timvw.be/?p=2280
title: Using eID on OS X Mountain Lion
---
Last week or so I got myself a MacBook Air and I am really loving it so far. Today I needed to use my [eID](http://eid.belgium.be/en/) so I installed the middleware application without any hassle but had a hard time configuring Safari. Apparently Apply removed support for [PKCS #11](http://en.wikipedia.org/wiki/PKCS_?11) in [OS X Mountain Lion](http://www.apple.com/osx/). After installing [SmartCard Services](http://smartcardservices.macosforge.org) the certificates appeared in the Keychain and I became able to authenticate on websites using my certificate