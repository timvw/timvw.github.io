---
ID: 76
post_title: Kill a user and his processes
author: timvw
post_date: 2003-12-12 00:37:06
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2003/12/12/kill-a-user-and-his-processes/
published: true
---
[code lang="bash"]
#!/bin/sh
#
# Author: Tim Van Wassenhove
# Update: 12-12-2003 13:15
#
# This script kills all processes that are owned by a given user.
#

if [ -n &quot;1&quot; ]
then
        ps -ef | grep $1 | grep -v grep | awk ‘{ print }’ | xargs kill -9
else
        echo &quot;Usage: killuser.sh username&quot;
fi
[/code]