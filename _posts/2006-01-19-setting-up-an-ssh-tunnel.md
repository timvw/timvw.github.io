---
title: Setting up an SSH tunnel
layout: post
tags:
  - Free Software
---
On the machine example there is a ([tcp/ip](http://en.wikipedia.org/wiki/TCP/IP)) program listening on port 12345. The protocol it talks is some [plaintext](http://en.wikipedia.org/wiki/Plain_text) language. I want to talk with it, but i do not want others to know what i am sending to it. I am lucky enough to have remote access to that machine via [ssh](http://en.wikipedia.org/wiki/Ssh). I setup a tunnel with the following command

```bash
ssh -N -L 12345:example:12345 timvw@example
```

Now my program can connect to localhost:12345 and ssh will make sure that it ends up at example.:12345 without others being able to see the actual data. For windows users i suggest that you take a look at [Plink](http://www.chiark.greenend.org.uk/~sgtatham/putty).
