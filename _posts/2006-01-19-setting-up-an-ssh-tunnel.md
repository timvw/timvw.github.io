---
ID: 59
post_title: Setting up an SSH tunnel
author: timvw
post_date: 2006-01-19 21:31:58
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/01/19/setting-up-an-ssh-tunnel/
published: true
dsq_thread_id:
  - "1933324843"
---
<p>On the machine example there is a (<a href="http://en.wikipedia.org/wiki/TCP/IP">tcp/ip</a>) program listening on port 12345.  The protocol it talks is some <a href="http://en.wikipedia.org/wiki/Plain_text">plaintext</a> language. I want to talk with it, but i don't want others to know what i'm sending to it. I'm lucky enough to have remote access to that machine via <a href="http://en.wikipedia.org/wiki/Ssh">ssh</a>. I setup a tunnel with the following command:</p>
[code lang="bash"]
ssh -N -L 12345:example:12345 timvw@example
[/code]
<p>Now my program can connect to localhost:12345 and ssh will make sure that it ends up at example.:12345 without others being able to see the actual data :) For windows users i suggest that you take a look at <a href="http://www.chiark.greenend.org.uk/~sgtatham/putty">Plink</a>.</p>