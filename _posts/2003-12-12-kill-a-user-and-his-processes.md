---
title: Kill a user and his processes
layout: post
tags:
  - Bash
---
```bash
#!/bin/sh 
# 
# # Up#
# This script kills all processes that are owned by a given user.  
#

if [ -n "1" ]
then
	ps -ef | grep $1 | grep -v grep | awk ‘{ print }’ | xargs kill -9
else
	echo "Usage: killuser.sh username"
fi
```
