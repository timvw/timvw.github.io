---
id: 2079
title: Using WinMerge as difftool on cygwin/git
date: 2011-03-12T10:06:26+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2079
permalink: /2011/03/12/using-winmerge-as-difftool-on-cygwingit/
categories:
  - Uncategorized
tags:
  - cygwin
  - git
  - winmerge
---
Last couple of weeks i have been using [Git](http://git-scm.com/) on [cygwin](http://www.cygwin.com) and i got very satisfying results out of it. One thing that i wanted to tweak was the ability to use [WinMerge](http://winmerge.org/) to compare files. Here is how i do it:

Here is my ~/.gitconfig:

```bash
[user]	  
name = Tim Van Wassenhove	  
email = git@timvw.be
[diff]
external = "~/bin/git-diff-wrapper.sh"
```

Here is my ~/bin/git-diff-wrapper.sh (it uses [cygpath](http://www.cygwin.com/cygwin-ug-net/using-utils.html) to translate the paths):

```bash
#!/bin/sh
"/cygdrive/c/Program Files/WinMerge/WinMergeU.EXE" /e /ub /dl other /dr local "\`cygpath -aw $1\`" "\`cygpath -aw $2\`" "\`cygpath -aw $5\`"
```

And now we are good to go 😉
