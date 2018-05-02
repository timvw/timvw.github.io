---
id: 76
title: Kill a user and his processes
date: 2003-12-12T00:37:06+00:00
author: timvw
layout: post
guid: http://www.timvw.be/kill-a-user-and-his-processes/
permalink: /2003/12/12/kill-a-user-and-his-processes/
tags:
  - Bash
---
```bash
#!/bin/sh 
# 
# Author: Tim Van Wassenhove  
# Update: 12-12-2003 13:15  
#
# This script kills all processes that are owned by a given user.  
#

if [ -n "1" ]
then
	ps -ef | grep $1 | grep -v grep | awk ‘{ print }’ | xargs kill -9
else
	echo "Usage: killuser.sh username"
fi
```
