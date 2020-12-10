---
title: GNU screen
layout: post
tags:
  - Free Software
---
Another tool that belongs to my favorites is [GNU Screen](http://www.gnu.org/software/screen/). A couple of years ago i had a bad internet connection and when i was working on a remote shell i was always logged out and had to start over. I really hated that 😉 Today i don't have this problem anymore, but i like to keep [Irssi](http://www.irssi.org) (an [IRC](http://en.wikipedia.org/wiki/IRC) user-agent) running, even when i'm not logged in. [TIP Using Screen](http://gentoo-wiki.com/TIP_Using_screen) is an article that gives a couple of other reasons to use it and explains how it works. The default settings suck if you also use [GNU Emacs](http://www.gnu.org/software/emacs/). So i had to figure out a couple of keypresses. With "cat -v" i could easily see what those keypresses were. Here is my .screenrc file

```bash
##############################################
# # Up##############################################
startup_message off
escape ^Oo

bind i screen -t 'irssi'        3 irssi
bind v screen -t 'vim'          4 vim
bind m screen -t 'mutt'         5 mutt
bind b screen -t 'slrn belnet'  6 slrn -h news.belnet.be
bind r screen -t 'slrn php'     7 slrn -h news.php.net
bind e screen -t 'elinks'       8 elinks http://www.google.com
```
